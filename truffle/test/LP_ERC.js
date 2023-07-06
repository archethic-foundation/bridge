const DummyToken = artifacts.require("DummyToken")
const LiquidityPool = artifacts.require("LP_ERC")
const HTLC = artifacts.require("SignedHTLC_ERC")

const { randomBytes, createHash } = require("crypto")
const { generateECDSAKey, hexToUintArray, createEthSign, increaseTime } = require("./utils")

contract("ERC LiquidityPool", (accounts) => {

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
        const DummyTokenInstance = await DummyToken.deployed()
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
    
        assert.equal(await instance.reserveAddress(), accounts[4])
        assert.equal(await instance.safetyModuleAddress(), accounts[3])
        assert.equal(await instance.safeModuleFee(), 5)
        assert.equal(await instance.archethicPoolSigner(), archPoolSigner.address)
        assert.equal(await instance.poolCap(), 20000)
        assert.equal(await instance.locked(), true)
        assert.equal(await instance.token(), DummyTokenInstance.address)
    })

    it("should update the reserve address", async () => {
        const DummyTokenInstance = await DummyToken.deployed()
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
        await instance.setReserveAddress(accounts[8])
        assert.equal(await instance.reserveAddress(), accounts[8])
    })

    it("should update the safety module address", async () => {
        const DummyTokenInstance = await DummyToken.deployed()
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
        await instance.setSafetyModuleAddress(accounts[8])
        assert.equal(await instance.safetyModuleAddress(), accounts[8])
    })

    it("should update the safety module fee", async () => {
        const DummyTokenInstance = await DummyToken.deployed()
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
        await instance.setSafetyModuleFee(300)
        assert.equal(await instance.safeModuleFee(), 300)
    })

    it("should update the archethic pool signer address", async () => {
        const DummyTokenInstance = await DummyToken.deployed()
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)

        const { privateKey } = generateECDSAKey()
        const { address } = web3.eth.accounts.privateKeyToAccount(`0x${privateKey.toString('hex')}`);

        await instance.setArchethicPoolSigner(address)
        assert.equal(await instance.archethicPoolSigner(), address)
    })

    it("should update the pool cap", async () => {
        const DummyTokenInstance = await DummyToken.deployed()
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
        await instance.setPoolCap(50000)
        assert.equal(await instance.poolCap(), 50000)
    })

    it("should unlock pool", async () => {
        const DummyTokenInstance = await DummyToken.deployed()
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
        await instance.unlock()
        assert.equal(false, await instance.locked())
    })

    it("should lock pool after unlocked", async () => {
        const DummyTokenInstance = await DummyToken.deployed()
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
        await instance.unlock()
        assert.equal(false, await instance.locked())
        await instance.lock()
        assert.equal(true, await instance.locked())
    })

    it("should update owner", async () => {
        const DummyTokenInstance = await DummyToken.deployed()
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
        await instance.transferOwnership(accounts[3])
        assert.equal(accounts[3], await instance.owner())
    })

    it("should update token", async () => {
        const DummyTokenInstance = await DummyToken.deployed()
        const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
        
        const AnotherDummyTokenInstance = await DummyToken.new(2000000)

        await instance.setToken(AnotherDummyTokenInstance.address)
        assert.equal(AnotherDummyTokenInstance.address, await instance.token())
    })

    describe("provisionHTLC", () => {
        it("should send ERC20 to the HTLC contract after verifying the signature", async () => {
            const DummyTokenInstance = await DummyToken.deployed()
            const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
            await instance.unlock()
            await DummyTokenInstance.transfer(instance.address, web3.utils.toWei('2'))

            const sigHash = hexToUintArray("9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08")

            const { r, s, v } = createEthSign(sigHash, archPoolSigner.privateKey)

            await instance.provisionHTLC("0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08", web3.utils.toWei('1'), 60, `0x${r}`, `0x${s}`, v)
            const htlcAddress = await instance.provisionedSwaps("0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08")
            const balanceHTLC = await DummyTokenInstance.balanceOf(htlcAddress)
            assert.equal(web3.utils.toWei('1'), balanceHTLC)

            const HTLCInstance = await HTLC.at(htlcAddress)

            assert.equal(await HTLCInstance.pool(), instance.address)
            assert.equal(await HTLCInstance.hash(), "0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08")
            assert.equal(await HTLCInstance.recipient(), accounts[0]);
            assert.equal(await HTLCInstance.amount(), web3.utils.toWei('1'))
            assert.equal(await HTLCInstance.lockTime(), 60)
            assert.equal(await HTLCInstance.token(), DummyTokenInstance.address)
        })

        it("should return an error when the signature is invalid", async() => {
            const DummyTokenInstance = await DummyToken.deployed()
            const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
            await instance.unlock()
            await DummyTokenInstance.transfer(instance.address, web3.utils.toWei('2'))

            const sigHash = randomBytes(32)

            const { r, s, v } = createEthSign(sigHash, archPoolSigner.privateKey)

            try {
                await instance.provisionHTLC("0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08", web3.utils.toWei('1'), 60, `0x${r}`, `0x${s}`, v)

            }
            catch(e) {
                assert.equal("Invalid signature - Archethic Pool key does not match signature", e.reason)
            }
        })

        it("should return an error when the pool doesn't have enough funds to provide HTLC contract", async() => {
            const DummyTokenInstance = await DummyToken.deployed()
            const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
            await instance.unlock()

            const sigHash = hexToUintArray("9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08")

            const { r, s, v } = createEthSign(sigHash, archPoolSigner.privateKey)


            try {
                await instance.provisionHTLC("0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08", web3.utils.toWei('1'), 60, `0x${r}`, `0x${s}`, v)
            }
            catch(e) {
                assert.equal("Pool doesn't have enough funds to provision the swap", e.reason)
            }
        })
    })
})

