@version 1

####################################
# EVM => Archethic : Request funds #
####################################

condition transaction, on: request_funds(end_time, amount, user_address, secret_hash), as: [
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

condition transaction, on: request_secret_hash(end_time, amount, user_address), as: [
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

condition transaction, on: reveal_secret(htlc_genesis_address), as: [
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
  log("VALID CHARGEABLE ?")
  log(end_time)
  log(amount)
  log(user_address)
  log(secret_hash)
  expected_code = get_chargeable_htlc(
    end_time,
    user_address,
    #POOL_ADDRESS#, # Replace by pool address
    secret_hash,
    "UCO", # Replace by token address if pool manage token
    amount
  )

  Code.is_same?(expected_code, transaction.code)
end

fun valid_signed_code?(end_time, amount, user_address) do
  expected_code = get_signed_htlc(
    end_time,
    user_address,
    #POOL_ADDRESS#, # Replace by pool address
    "UCO", # Replace by token address if pool manage token
    amount
  )

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

####################
# Public functions #
####################

export fun get_protocol_fee() do
  0.3
end

export fun get_protocol_fee_address() do
  #PROTOCOL_FEE_ADDRESS#
end

###############################
# External chain => Archethic #
###############################

export fun get_chargeable_htlc(end_time, user_address, pool_address, secret_hash, token, amount) do
  # Here we should ensure end_time is valid compared to Time.now() and return error

  user_address = String.to_hex(user_address)
  pool_address = String.to_hex(pool_address)
  secret_hash = String.to_hex(secret_hash)
  token = String.to_uppercase(token)

  return_transfer_code = ""
  if token == "UCO" do
    # We don't burn UCO, we return them in pool contract
    return_transfer_code = "Contract.add_uco_transfer to: 0x#{pool_address}, amount: #{amount}"
  else
    burn_address = Chain.get_burn_address()
    return_transfer_code = "Contract.add_token_transfer to: 0x#{burn_address}, amount: #{amount}, token_address: 0x#{token}"
  end

  fee_amount = amount * 0.003
  user_amount = amount - fee_amount

  fee_transfer_code = ""
  if token == "UCO" do
    fee_transfer_code = "Contract.add_uco_transfer to: #PROTOCOL_FEE_ADDRESS#, amount: #{fee_amount}"
  else
    fee_transfer_code = "Contract.add_token_transfer to: #PROTOCOL_FEE_ADDRESS#, amount: #{fee_amount}, token_address: 0x#{token}"
  end

  valid_transfer_code = ""
  if token == "UCO" do
    valid_transfer_code = """
    Contract.add_uco_transfer to: 0x#{user_address}, amount: #{user_amount}
      #{fee_transfer_code}
    """
  else
    valid_transfer_code = """
    Contract.add_token_transfer to: 0x#{user_address}, amount: #{user_amount}, token_address: 0x#{token}"
      #{fee_transfer_code}
    """
  end

  """
  @version 1

  # Automate the refunding after the given timestamp
  actions triggered_by: datetime, at: #{end_time} do
    Contract.set_type "transfer"
    # Send back the token to the bridge pool
    #{return_transfer_code}
    Contract.set_code ""
  end

  condition transaction, on: reveal_secret(secret), as: [
    timestamp: transaction.timestamp < #{end_time},
    content: Crypto.hash(String.to_hex(secret)) == 0x#{secret_hash},
    address: (
      # Here ensure withdraw is done on ethereum
      true
    )
  ]

  actions triggered_by: transaction, on: reveal_secret(secret) do
    Contract.set_type "transfer"
    #{valid_transfer_code}
    Contract.set_code ""
  end
  """
end

###############################
# Archethic => External chain #
###############################

export fun get_signed_htlc(end_time, user_address, pool_address, token, amount) do
  # Here we should ensure end_time is valid compared to Time.now() and return error

  user_address = String.to_hex(user_address)
  pool_address = String.to_hex(pool_address)
  token = String.to_uppercase(token)

  return_transfer_code = ""
  if token == "UCO" do
    return_transfer_code = "Contract.add_uco_transfer to: 0x#{user_address}, amount: #{amount}"
  else
    return_transfer_code = "Contract.add_token_transfer to: 0x#{user_address}, amount: #{amount}, token_address: 0x#{token}"
  end

  fee_amount = amount * 0.003
  user_amount = amount - fee_amount

  fee_transfer_code = ""
  if token == "UCO" do
    fee_transfer_code = "Contract.add_uco_transfer to: #PROTOCOL_FEE_ADDRESS#, amount: #{fee_amount}"
  else
    fee_transfer_code = "Contract.add_token_transfer to: #PROTOCOL_FEE_ADDRESS#, amount: #{fee_amount}, token_address: 0x#{token}"
  end

  valid_transfer_code = ""
  if token == "UCO" do
    # We don't burn UCO, we return them in pool contract
    valid_transfer_code = """
        Contract.add_uco_transfer to: 0x#{pool_address}, amount: #{user_amount}
        #{fee_transfer_code}
    """
  else
    burn_address = Chain.get_burn_address()
    valid_transfer_code = """
        Contract.add_token_transfer to: 0x#{burn_address}, amount: #{user_amount}, token_address: 0x#{token}"
        #{fee_transfer_code}
    """
  end

  date_time_trigger = """
  # Automate the refunding after the given timestamp
  actions triggered_by: datetime, at: #{end_time} do
    Contract.set_type "transfer"
    # Send back the token to the user address
    #{return_transfer_code}
    Contract.set_code ""
  end
  """

  code_after_withdraw = """
      @version 1

      export fun get_secret() do
        Json.to_string([
          secret: 0x\\\#{secret},
          secret_signature: [
            r: 0x\\\#{secret_signature.signature.r},
            s: 0x\\\#{secret_signature.signature.s},
            v: \\\#{secret_signature.recid}
          ]
        ])
      end
  """

  after_secret_code = """
    @version 1
    #{date_time_trigger}
    condition transaction, on: reveal_secret(secret, secret_signature), as: [
      address: (
			  #Here we should ensure the transaction is comming from pool
			  #Chain.get_genesis_address() == 0x#{pool_address}
			  #is not working this the transaction is not validated so it return the same address
			  true
		  ),
      timestamp: transaction.timestamp < #{end_time},
      content: Crypto.hash(String.to_hex(secret)) == 0x\#{secret_hash}
    ]

    actions triggered_by: transaction, on: reveal_secret(secret, secret_signature) do
      next_code = """
  #{code_after_withdraw}
      \\\"""

      Contract.set_type "transfer"
  #{valid_transfer_code}
      Contract.set_code next_code
    end

    export fun get_secret_hash() do
      Json.to_string([
        secret_hash: 0x\#{secret_hash},
        secret_hash_signature: [
          r: 0x\#{secret_hash_signature.signature.r},
          s: 0x\#{secret_hash_signature.signature.s},
          v: \#{secret_hash_signature.recid}
        ]
      ])
    end
  """

  """
  @version 1
  #{date_time_trigger}
  condition transaction, on: set_secret_hash(secret_hash, secret_hash_signature), as: [
    address: (
			#Here we should ensure the transaction is comming from pool
			#Chain.get_genesis_address() == 0x#{pool_address}
			#is not working this the transaction is not validated so it return the same address
			true
		)
  ]

  actions triggered_by: transaction, on: set_secret_hash(secret_hash, secret_hash_signature) do
    next_code = \"""
  #{after_secret_code}
    \"""

    Contract.set_code next_code
  end
  """
end

