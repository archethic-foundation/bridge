import fs from "fs"
import Archethic, { Crypto, Utils } from "archethic"
import config from "./config.js"

if (!config.poolSeed || !config.endpoint) {
  console.log("Invalid config !")
  console.log("Config needs poolSeed and endpoint")
  process.exit(1)
}

main(config.poolSeed, config.endpoint)

async function main(seed, endpoint) {
  const archethic = new Archethic(endpoint)
  await archethic.connect()

  // Replace genesis pool address
  const poolGenesisAddress = Utils.uint8ArrayToHex(Crypto.deriveAddress(seed, 0))
  console.log("Pool genesis address:", poolGenesisAddress)

  let poolCode = fs.readFileSync("./contracts/uco_pool.exs", "utf8")
  poolCode = poolCode.replaceAll("#POOL_ADDRESS#", "0x" + poolGenesisAddress)

  const storageNonce = await archethic.network.getStorageNoncePublicKey()
  const { encryptedSeed, authorizedKeys } = encryptSeed(seed, storageNonce)

  const index = await archethic.transaction.getTransactionIndex(poolGenesisAddress)

  // Get faucet before sending transaction
  // await requestFaucet(endpoint, poolGenesisAddress)

  const tx = archethic.transaction.new()
    .setType("contract")
    .setCode(poolCode)
    .setContent("{}")
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

// async function requestFaucet(endpoint, address) {
//   return new Promise((resolve, reject) => {
//     fetch(endpoint + "/faucet", {
//       method: "POST",
//       headers: {
//         "Content-Type": "application/json",
//         Accept: "application/json",
//       },
//       body: JSON.stringify({ address: address }),
//     })
//       .then((_response) => {
//         console.log("Faucet request ok")
//         resolve()
//       })
//       .catch((err) => {
//         console.log("Faucet request error: ", err)
//         reject(err)
//       });
//   })
// }
