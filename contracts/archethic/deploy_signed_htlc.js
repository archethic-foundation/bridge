import Archethic, { Crypto, Utils } from "archethic"
import config from "./config.js"

if (!config.poolSeed || !config.endpoint || !config.userSeed) {
  console.log("Invalid config !")
  console.log("Config needs poolSeed, endpoint and userSeed")
  process.exit(1)
}

const args = []
process.argv.forEach(function(val, index, _array) { if (index > 1) { args.push(val) } })

if (args.length != 3) {
  console.log("Missing arguments")
  console.log("Usage: node deploy_htlc.js [htlcSeed] [endTime] [amount]")
  process.exit(1)
}

main(config.poolSeed, config.endpoint, config.userSeed)

async function main(poolSeed, endpoint, userSeed) {
  const seed = args[0]
  const endTime = parseInt(args[1])
  const amount = parseFloat(args[2])

  const poolGenesisAddress = Utils.uint8ArrayToHex(Crypto.deriveAddress(poolSeed, 0))
  const userAddress = Utils.uint8ArrayToHex(Crypto.deriveAddress(userSeed, 0))

  const archethic = new Archethic(endpoint)
  await archethic.connect()

  const htlcCode = await getHtlcCode(endpoint, poolGenesisAddress, userAddress, endTime, amount)

  const storageNonce = await archethic.network.getStorageNoncePublicKey()
  const { encryptedSeed, authorizedKeys } = encryptSeed(seed, storageNonce)

  const htlcGenesisAddress = Utils.uint8ArrayToHex(Crypto.deriveAddress(seed, 0))
  console.log("Signed HTLC genesis address:", htlcGenesisAddress)
  const index = await archethic.transaction.getTransactionIndex(htlcGenesisAddress)

  const content = getHTLCContent(userAddress, endTime, amount)
  // Get faucet before sending transaction
  // await requestFaucet(endpoint, poolGenesisAddress)

  const tx = archethic.transaction.new()
    .setType("contract")
    .setCode(htlcCode)
    .setContent(content)
    .addRecipient(poolGenesisAddress)
    .addOwnership(encryptedSeed, authorizedKeys)
    .build(seed, index)
    .originSign(Utils.originPrivateKey)

  tx.on("fullConfirmation", (_confirmations) => {
    const txAddress = Utils.uint8ArrayToHex(tx.address)
    console.log("Transaction validated !")
    console.log("Address:", txAddress)
    console.log(endpoint + "/explorer/transaction/" + txAddress)
    process.exit(0)
  }).on("error", (context, reason) => {
    console.log("Error while sending transaction")
    console.log("Contest:", context)
    console.log("Reason:", reason)
    process.exit(1)
  }).send()
}

function encryptSeed(seed, storageNonce) {
  const aesKey = Crypto.randomSecretKey()
  const encryptedSeed = Crypto.aesEncrypt(seed, aesKey)
  const encryptedAesKey = Crypto.ecEncrypt(aesKey, storageNonce)
  const authorizedKeys = [{ encryptedSecretKey: encryptedAesKey, publicKey: storageNonce }]
  return { encryptedSeed, authorizedKeys }
}

async function getHtlcCode(endpoint, poolAddress, userAddress, endTime, amount) {
  return new Promise((resolve, reject) => {
    const body = {
      "jsonrpc": "2.0",
      "id": 1,
      "method": "contract_fun",
      "params": {
        "contract": poolAddress,
        "function": "get_signed_htlc",
        "args": [endTime, userAddress, poolAddress, "UCO", amount]
      }
    }

    fetch(endpoint + "/api/rpc", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },
      body: JSON.stringify(body),
    })
      .then(async (response) => {
        const res = await response.json()
        resolve(res.result)
      })
      .catch((err) => {
        console.log(err)
        reject(err)
      });
  })
}

function getHTLCContent(userAddress, endTime, amount) {
  return JSON.stringify({
    "action": "request_secret_hash",
    "endTime": endTime,
    "userAddress": userAddress,
    "amount": amount
  })
}
