const LiquidityPool = artifacts.require("LP_ETH")

module.exports = async function(deployer, network, accounts) {
    let reserveAddress, safetyModuleAddress, archethicPoolSigner, poolCap
    const safeteModuleFeeRate = 5

    if (network == "development") {
        reserveAddress = accounts[4]
        safetyModuleAddress = accounts[5]
        archethicPoolSigner = accounts[6]
        poolCap = web3.utils.toWei('200')
    }
    await deployer.deploy(LiquidityPool, reserveAddress, safetyModuleAddress, safeteModuleFeeRate, archethicPoolSigner, poolCap);

    if (network == "development") {
        const LPInstance = await LiquidityPool.deployed()
        await LPInstance.unlock()
    }
}