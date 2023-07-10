const LiquidityPool = artifacts.require("LP_ERC")
const DummyToken = artifacts.require("DummyToken")

module.exports = async function(deployer, network, accounts) {
    let reserveAddress, safetyModuleAddress, archethicPoolSigner, poolCap, tokenAddress
    const safeteModuleFeeRate = 5

    if (network == "development") {
        reserveAddress = accounts[4]
        safetyModuleAddress = accounts[5]
        archethicPoolSigner = accounts[6]
        poolCap = web3.utils.toWei('200')

        await deployer.deploy(DummyToken, web3.utils.toWei('200000'))

        const tokenInstance = await DummyToken.deployed()
        tokenAddress = tokenInstance.address

        console.log(`Deployed token: ${tokenAddress}`)
    }

    await deployer.deploy(LiquidityPool, reserveAddress, safetyModuleAddress, safeteModuleFeeRate, archethicPoolSigner, poolCap, tokenAddress);
}