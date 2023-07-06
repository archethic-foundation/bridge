const DummyToken = artifacts.require("DummyToken")

module.exports = async function(deployer, network) {
    if (network == "test") {
        deployer.deploy(DummyToken, web3.utils.toWei('1000'))
    }
};
