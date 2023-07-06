const LiquidityPool = artifacts.require("ETHLiquitidyPool")
const HTLC = artifacts.require("ETHSwapHTLC")

const { generateECDSAKey, hexToUintArray, createEthSign } = require("./utils")

contract("ETH LiquidityPool", (accounts) => {

    let archPoolSigner = {}

    before(() => {
        const { privateKey } = generateECDSAKey()
        const { address } = web3.eth.accounts.privateKeyToAccount(`0x${privateKey.toString('hex')}`);
        archPoolSigner = {
            address: address,
            privateKey: privateKey
        }
    })

    it("should create contract", async () => {
        
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000)
    
        assert.equal(await instance.reserveAddress(), accounts[4])
        assert.equal(await instance.safetyModuleAddress(), accounts[3])
        assert.equal(await instance.safeModuleFee(), 5)
        assert.equal(await instance.archethicPoolSigner(), archPoolSigner.address)
        assert.equal(await instance.poolCap(), 20000)
        assert.equal(await instance.locked(), true)
    })

    it("should update the reserve address", async () => {
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000)
        await instance.setReserveAddress(accounts[8])
        assert.equal(await instance.reserveAddress(), accounts[8])
    })

    it("should update the safety module address", async () => {
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000)
        await instance.setSafetyModuleAddress(accounts[8])
        assert.equal(await instance.safetyModuleAddress(), accounts[8])
    })

    it("should update the safety module fee", async () => {
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000)
        await instance.setSafetyModuleFee(300)
        assert.equal(await instance.safeModuleFee(), 300)
    })

    it("should update the archethic pool signer address", async () => {
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000)

        const { privateKey } = generateECDSAKey()
        const { address } = web3.eth.accounts.privateKeyToAccount(`0x${privateKey.toString('hex')}`);

        await instance.setArchethicPoolSigner(address)
        assert.equal(await instance.archethicPoolSigner(), address)
    })

    it("should update the pool cap", async () => {
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000)
        await instance.setPoolCap(50000)
        assert.equal(await instance.poolCap(), 50000)
    })

    it("should unlock pool", async () => {
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000)
        await instance.unlock()
        assert.equal(false, await instance.locked())
    })

    it("should lock pool after unlocked", async () => {
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000)
        await instance.unlock()
        assert.equal(false, await instance.locked())
        await instance.lock()
        assert.equal(true, await instance.locked())
    })

    it("should update owner", async () => {
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000)
        await instance.transferOwnership(accounts[3])
        assert.equal(accounts[3], await instance.owner())
    })

    describe("provisionHTLC", () => {
        it("should send ETH to the HTLC contract after verifying the signature", async () => {
            const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000)
            await instance.unlock()
            // await web3.eth.sendTransaction({ from: accounts[1], to: HTLCInstance.address, value: web3.utils.toWei(2) });

            const recipientEthereum = accounts[2]

            const HTLCInstance = await HTLC.new(
                recipientEthereum,
                web3.utils.toWei("1"),
                "0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08",
                1
            )

            const sigHash = await HTLCInstance.signatureHash()
            const hashedData = hexToUintArray(sigHash.substring(2))

            const { r, s, v } = createEthSign(hashedData, archPoolSigner.privateKey)
            await instance.provisionHTLC(HTLCInstance.address, `0x${r}`, `0x${s}`, v)
        })
    })
})

