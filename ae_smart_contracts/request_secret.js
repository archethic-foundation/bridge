import Archethic, { Crypto, Utils } from "archethic"

const args = []
process.argv.forEach(function(val, index, _array) { if (index > 1) { args.push(val) } })

if (args.length != 4) {
  console.log("Missing arguments")
  console.log("Usage: node deploy_htlc.js [seed] [poolGenesisAddress] [htlcGenesisAddress] [endpoint]")
  process.exit(1)
}

main(args)

async function main(args) {
  const seed = args[0]
  const poolGenesisAddress = args[1]
  const htlcGenesisAddress = args[2]
  const endpoint = args[3]

  const archethic = new Archethic(endpoint)
  await archethic.connect()

  const htlcAddressBefore = await getLastAddress(archethic, htlcGenesisAddress)

  const genesisAddress = Utils.uint8ArrayToHex(Crypto.deriveAddress(seed, 0))
  const index = await archethic.transaction.getTransactionIndex(genesisAddress)

  const content = getTxContent(htlcGenesisAddress)

  // Get faucet before sending transaction
  // await requestFaucet(endpoint, poolGenesisAddress)

  const tx = archethic.transaction.new()
    .setType("data")
    .setContent(content)
    .addRecipient(poolGenesisAddress)
    .build(seed, index)
    .originSign(Utils.originPrivateKey)

  tx.on("fullConfirmation", (_confirmations) => {
    console.log("Secret request succesfully sent !")
    console.log("Waiting for HTLC contract to withdraw ...")
    wait(htlcAddressBefore, htlcGenesisAddress, endpoint, archethic)
  }).on("error", (context, reason) => {
    console.log("Error while sending transaction")
    console.log("Contest:", context)
    console.log("Reason:", reason)
    process.exit(1)
  }).send()
}

function getTxContent(htlcGenesisAddress) {
  return JSON.stringify({
    "action": "request_secret",
    "htlcGenesisAddress": htlcGenesisAddress
  })
}

async function getLastAddress(archethic, address) {
  return new Promise(async (resolve, reject) => {

    const query = `
    {
      lastTransaction(address: "${address}") {
        address
      }
    }
    `

    archethic.network.rawGraphQLQuery(query)
      .then(res => resolve(res.lastTransaction.address))
      .catch(err => reject(err))
  })
}

async function wait(htlcAddressBefore, htlcGenesisAddress, endpoint, archethic, i = 0) {
  const htlcAddressAfter = await getLastAddress(archethic, htlcGenesisAddress)
  if (i == 5) {
    console.log("HTLC didn't withdrawn")
    process.exit(1)
  } else if (htlcAddressBefore == htlcAddressAfter) {
    setTimeout(() => wait(htlcAddressBefore, htlcGenesisAddress, endpoint, archethic, i + 1), 500)
  } else {
    console.log("HTLC succesfully withdraw !")
    console.log("Address:", htlcAddressAfter)
    console.log(endpoint + "/explorer/transaction/" + htlcAddressAfter)
    process.exit(0)
  }
}
