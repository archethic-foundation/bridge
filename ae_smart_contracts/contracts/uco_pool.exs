@version 1

condition transaction: [
  type: List.in?(["contract", "data"], transaction.type),
  content: valid_content?(),
  code: valid_code?(),
  address: (
    # Here ensure Ethereum contract exists and check rules
    # How to ensure Ethereum contract is a valid one ?
    # Maybe get the ABI of HTLC on github and compare it to the one on Ethereum
    # Then control rules
    true
  )
]

actions triggered_by: transaction do
  # Replace by named action
  params = Json.parse(transaction.content)

  contract_content = Json.parse(contract.content)

  if params.action == "request_funds" do
    Contract.set_type "transfer"
    Contract.add_uco_transfer to: transaction.address, amount: params.amount
  end

  if params.action == "request_secret_hash" do
    # Find a way to generate a random secret
    secret = transaction.address
    secret_hash = Crypto.hash(secret, "sha256")

    # Build signature for EVM decryption
    signature = sign_for_evm(secret_hash)

    # Add secret and signature in content
    # secret should be encrypted (Not possible with ec_encrypt for now)
    # secret should be stored in State
    # secret_hash and signature should be sent in recipient parameter 
    htlc_map = [
      secret: transaction.address,
      secret_hash: secret_hash,
      secret_hash_signature: signature,
      end_time: params.endTime
    ]

    htlc_genesis_address = Chain.get_genesis_address(transaction.address)
    
    contract_content = Map.set(contract_content, htlc_genesis_address, htlc_map)

    Contract.add_recipient transaction.address
  end

  if params.action == "request_secret" do
    htlc_map = Map.get(contract_content, params.htlcGenesisAddress)
    
    if htlc_map.end_time > Time.now() do
      # Here should decrypt secret and add it in recipient with named action
      # But for now we just sign secret and let it in contract content
      signature = sign_for_evm(htlc_map.secret)
      
      new_htlc_map = [
        secret: htlc_map.secret,
        secret_signature: signature,
        end_time: htlc_map.end_time,
        withdrawn?: true
      ]

      contract_content = Map.set(contract_content, params.htlcGenesisAddress, new_htlc_map)

      Contract.add_recipient params.htlcGenesisAddress
    end
  end

  # Here delete old secret that hasn't been used before endTime
  new_content = Map.new()

  for key in Map.keys(contract_content) do
    htlc_map = Map.get(contract_content, key)
    if htlc_map.end_time > Time.now() do
      new_content = Map.set(new_content, key, htlc_map)
    end
  end

  Contract.set_content Json.to_string(new_content)
end

fun valid_content?(content) do
  # Replace content JSON by named action params
  valid? = false
  action = nil

  if Json.is_valid?(content) && Json.path_match?(content, "$.action") do
    action = Json.path_extract(content, "$.action")
  end

  if action == "request_funds" do
    valid? = Json.path_match?(content, "$.endTime") &&
      Json.path_match?(content, "$.amount") &&
      Json.path_match?(content, "$.userAddress") &&
      Json.path_match?(content, "$.secretHash")
  end

  if action == "request_secret_hash" do
    valid? = Json.path_match?(content, "$.endTime") &&
      Json.path_match?(content, "$.amount") &&
      Json.path_match?(content, "$.userAddress")
  end

  if action == "request_secret" do
    if Json.path_match?(content, "$.htlcGenesisAddress") do
      htlc_genesis_address = Json.path_extract(content, "$.htlcGenesisAddress")
      htlc_map = Map.get(Json.parse(contract.content), htlc_genesis_address)
      valid? = htlc_map != nil && !htlc_map.withdrawn?
    else
      valid? = false
    end
  end

  valid?
end

fun valid_code?() do
  valid_code? = false

  # Get params from named action params
  params = Json.parse(transaction.content)

  htlc_factory = 0x1234 # Replace by HTLC factory address
  expected_code = ""

  if params.action == "request_funds" do
    # Here we should ensure that the htlc will have enough UCO to pay the trigger datetime
    # if the htlc is not used util end time

    expected_code = get_chargeable_htlc(
      params.endTime,
      params.userAddress,
      #POOL_ADDRESS#, # Replace by pool address
      params.secretHash,
      "UCO", # Replace by token address if pool manage token
      params.amount
    )
  end

  if params.action == "request_secret_hash" do
    # Here we should ensure the htlc has enough fund than the amount it is supposed to send

    expected_code = get_signed_htlc(
      params.endTime,
      params.userAddress,
      #POOL_ADDRESS#, # Replace by pool address
      "UCO", # Replace by token address if pool manage token
      params.amount
    )
  end

  if expected_code != "" do
    # Here we should have more control on endTime to not accept contract 
    # that almost reached endTime or where endTime is to far from now
    Code.is_same?(expected_code, transaction.code) && params.endTime > Time.now()
  else
    true
  end
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
    return_transfer_code = "Contract.add_uco_transfer to: 0x#{pool_address}, amount: #{amount}"
  else
    return_transfer_code = "Contract.add_token_transfer to: 0x#{pool_address}, amount: #{amount}, token_address: 0x#{token}"
  end

  valid_transfer_code = ""
  if token == "UCO" do
    valid_transfer_code = "Contract.add_uco_transfer to: 0x#{user_address}, amount: #{amount}"
  else
    valid_transfer_code = "Contract.add_token_transfer to: 0x#{user_address}, amount: #{amount}, token_address: 0x#{token}"
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

  condition transaction: [
    timestamp: transaction.timestamp < #{end_time},
    content: Crypto.hash() == 0x#{secret_hash},
    address: (
      # Here ensure withdraw is done on ethereum
      true
    )
  ]

  actions triggered_by: transaction do
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

  valid_transfer_code = ""
  if token == "UCO" do
    # We don't burn UCO, we return them in pool contract
    valid_transfer_code = "Contract.add_uco_transfer to: 0x#{pool_address}, amount: #{amount}"
  else
    burn_address = Chain.get_burn_address()
    valid_transfer_code = "Contract.add_token_transfer to: 0x#{burn_address}, amount: #{amount}, token_address: 0x#{token}"
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
    condition transaction: [
      address: (
				#Here we should ensure the transaction is comming from pool
				#Chain.get_genesis_address() == 0x#{pool_address}
				#is not working this the transaction is not validated so it return the same address
				true
			),
      timestamp: transaction.timestamp < #{end_time},
      content: valid_hash?()
    ]

    actions triggered_by: transaction do
      params = Json.parse(transaction.content)

      genesis_address = Chain.get_genesis_address(contract.address)
      secret = params[genesis_address].secret
      secret_signature = params[genesis_address].secret_signature
      
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

    fun valid_hash?(content) do
      params = Json.parse(content)

      genesis_address = Chain.get_genesis_address(contract.address)
      secret = params[genesis_address].secret
      Crypto.hash(secret) == 0x\#{secret_hash}
    end
  """

  """
  @version 1
  #{date_time_trigger}
  condition transaction: [
    address: (
				#Here we should ensure the transaction is comming from pool
				#Chain.get_genesis_address() == 0x#{pool_address}
				#is not working this the transaction is not validated so it return the same address
				true
			),
    content: valid_content?()
  ]

  actions triggered_by: transaction do
    params = Json.parse(transaction.content)

    genesis_address = Chain.get_genesis_address(contract.address)
    secret_hash = params[genesis_address].secret_hash
    secret_hash_signature = params[genesis_address].secret_hash_signature

    next_code = \"""
    #{after_secret_code}
    \"""

    Contract.set_code next_code
  end

  fun valid_content?(content) do
    genesis_address = Chain.get_genesis_address(contract.address)
    params = Json.parse(content)

    params[genesis_address].secret_hash != nil && params[genesis_address].secret_hash_signature != nil
  end
  """
end
