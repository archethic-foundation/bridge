@version 1

####################################
# EVM => Archethic : Request funds #
####################################

condition triggered_by: transaction, on: request_funds(end_time, amount, user_address, secret_hash), as: [
  type: "contract",
  code: valid_chargeable_code?(end_time, amount, user_address, secret_hash),
  timestamp: end_time > Time.now(),
  address: (
    # Here ensure Ethereum contract exists and check rules
    # How to ensure Ethereum contract is a valid one ?
    # Maybe get the ABI of HTLC on github and compare it to the one on Ethereum
    # Then control rules
    true
  )
]

actions triggered_by: transaction, on: request_funds(_end_time, amount, user_address, secret_hash) do
  Contract.set_type "transfer"
  Contract.add_uco_transfer to: transaction.address, amount: amount
end

##########################################
# Archethic => EVM : Request secret hash #
##########################################

condition triggered_by: transaction, on: request_secret_hash(end_time, amount, user_address), as: [
  type: "contract",
  code: valid_signed_code?(end_time, amount, user_address),
  timestamp: end_time > Time.now()
]

actions triggered_by: transaction, on: request_secret_hash(end_time, amount, user_address) do
  # Here delete old secret that hasn't been used before endTime
  contract_content = Map.new()
  if Json.is_valid?(contract.content) do
    contract_content = Json.parse(contract.content)
  end

  for key in Map.keys(contract_content) do
    htlc_map = Map.get(contract_content, key)
    if htlc_map.end_time > Time.now() do
      contract_content = Map.delete(contract_content, key)
    end
  end

  # Find a way to generate a random secret
  secret = Crypto.hash(transaction.address)
  secret_hash = Crypto.hash(secret, "sha256")

  # Build signature for EVM decryption
  signature = sign_for_evm(secret_hash)

  # Add secret and signature in content
  # secret should be encrypted (Not possible with ec_encrypt for now)
  # secret should be stored in State
  htlc_map = [secret: secret, end_time: end_time]

  htlc_genesis_address = Chain.get_genesis_address(transaction.address)

  contract_content = Map.set(contract_content, htlc_genesis_address, htlc_map)

  Contract.set_content Json.to_string(contract_content)
  Contract.add_recipient address: transaction.address, action: "set_secret_hash", args: [secret_hash, signature]
end

####################################
# Archethic => EVM : Reveal secret #
####################################

condition triggered_by: transaction, on: reveal_secret(htlc_genesis_address), as: [
  type: "transfer",
  content: (
    # Ensure htlc_genesis_address exists in pool state
    # and end_time has not been reached
    valid? = false

    if Json.is_valid?(contract.content) do
      htlc_genesis_address = String.to_hex(htlc_genesis_address)
      htlc_map = Map.get(Json.parse(contract.content), htlc_genesis_address)

      if htlc_map != nil do
        valid? = htlc_map.end_time > Time.now()
      end
    end

    valid?
  ),
  address: (
    # Here ensure Ethereum contract exists and check rules
    # How to ensure Ethereum contract is a valid one ?
    # Maybe get the ABI of HTLC on github and compare it to the one on Ethereum
    # Then control rules
    true
  )
]

actions triggered_by: transaction, on: reveal_secret(htlc_genesis_address) do
  contract_content = Json.parse(contract.content)

  htlc_genesis_address = String.to_hex(htlc_genesis_address)
  htlc_map = Map.get(contract_content, htlc_genesis_address)

  contract_content = Map.delete(contract_content, htlc_genesis_address)

  # Here should decrypt secret
  signature = sign_for_evm(htlc_map.secret)


  Contract.set_content Json.to_string(contract_content)
  Contract.add_recipient address: htlc_genesis_address, action: "reveal_secret", args: [htlc_map.secret, signature]
end

#####################
# Private functions #
#####################

fun valid_chargeable_code?(end_time, amount, user_address, secret_hash) do
  args = [
    end_time,
    user_address,
    #POOL_ADDRESS#, # Replace by pool address
    secret_hash,
    "UCO", # Replace by token address if pool manage token
    amount
  ]

  expected_code = Contract.call_function(#FACTORY_ADDRESS#, "get_chargeable_htlc", args)

  Code.is_same?(expected_code, transaction.code)
end

fun valid_signed_code?(end_time, amount, user_address) do
  args = [
    end_time,
    user_address,
    #POOL_ADDRESS#, # Replace by pool address
    "UCO", # Replace by token address if pool manage token
    amount
  ]

  expected_code = Contract.call_function(#FACTORY_ADDRESS#, "get_signed_htlc", args)

  Code.is_same?(expected_code, transaction.code)
end

fun sign_for_evm(data) do
  prefix = String.to_hex("\x19Ethereum Signed Message:\n32")
  signature_payload = Crypto.hash("#{prefix}#{data}", "keccak256")

  res = Crypto.sign(signature_payload)

  if res.recid == 0 do
    res = Map.set(res, "recid", 27)
  else
    res = Map.set(res, "recid", 28)
  end

  res
end