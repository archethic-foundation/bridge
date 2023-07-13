const LiquidityPool = artifacts.require("ETHPool")
const ETHPool_HTLCDeployer = artifacts.require("ETHPool_HTLCDeployer")

const { deployProxy } = require('@openzeppelin/truffle-upgrades');

module.exports = async function(deployer, network, accounts) {
    let reserveAddress, safetyModuleAddress, archethicPoolSigner, poolCap
    const safeteModuleFeeRate = 5

    await deployer.deploy(ETHPool_HTLCDeployer)
    await deployer.link(ETHPool_HTLCDeployer, LiquidityPool)

    if (network == "development") {
        reserveAddress = accounts[4]
        safetyModuleAddress = accounts[5]
        archethicPoolSigner = accounts[6]
        poolCap = web3.utils.toWei('200')
    }

    const instance = await deployProxy(LiquidityPool, [reserveAddress, safetyModuleAddress, safeteModuleFeeRate, archethicPoolSigner, poolCap], { deployer });

    if (network == "development") {
        await instance.unlock()
    }
}