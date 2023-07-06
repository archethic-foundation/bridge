const DummyToken = artifacts.require("DummyToken")
const LiquidityPool = artifacts.require("ERCLiquitidyPool")
const HTLC = artifacts.require("ERCSwapHTLC")

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

    describe("provisionHTLC", () => {
        it("should send ERC20 to the HTLC contract after verifying the signature", async () => {
            const DummyTokenInstance = await DummyToken.deployed()
            const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
            await instance.unlock()

            const recipientEthereum = accounts[2]

            await DummyTokenInstance.transfer(instance.address, web3.utils.toWei('2'))

            const HTLCInstance = await HTLC.new(
                recipientEthereum,
                DummyTokenInstance.address,
                web3.utils.toWei("1"),
                "0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08",
                1,
            )


            const sigHash = await HTLCInstance.signatureHash()
            const hashedData = hexToUintArray(sigHash.substring(2))

            const { r, s, v } = createEthSign(hashedData, archPoolSigner.privateKey)
            await instance.provisionHTLC(HTLCInstance.address, `0x${r}`, `0x${s}`, v)
            const balance = await DummyTokenInstance.balanceOf(HTLCInstance.address)
            assert.equal(web3.utils.toWei('1'), balance)
        })

        it("should return an error when the HTLC contract use other token", async() => {
            const DummyTokenInstance = await DummyToken.deployed()
            const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
            await instance.unlock()

            const recipientEthereum = accounts[2]
  
            const amount = web3.utils.toWei('1')
            const secret = randomBytes(32)
            const secretHash = createHash("sha256")
                .update(secret)
                .digest("hex")

            const AnotherDummyTokenInstance = await DummyToken.new(2000000)
        
            const HTLCInstance = await HTLC.new(
                recipientEthereum,
                AnotherDummyTokenInstance.address,
                amount,
                `0x${secretHash}`,
                60
            )
            
            const sigHash = await HTLCInstance.signatureHash()
            const hashedData = hexToUintArray(sigHash.substring(2))

            const { r, s, v } = createEthSign(hashedData, archPoolSigner.privateKey)
            
            try {
                await instance.provisionHTLC(HTLCInstance.address, `0x${r}`, `0x${s}`, v)
            }
            catch(e) {
                assert.equal(e.reason, "Invalid swap contract token for this pool")
            }
        })

      

        it("should return an error when the HTLC contract is already finished", async() => {
            const DummyTokenInstance = await DummyToken.deployed()
            const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
            await instance.unlock()

            await DummyTokenInstance.transfer(instance.address, web3.utils.toWei('2'))

            const recipientEthereum = accounts[2]
  
            const amount = web3.utils.toWei('1')
            const secret = randomBytes(32)
            const secretHash = createHash("sha256")
                .update(secret)
                .digest("hex")
        
            const HTLCInstance = await HTLC.new(
                recipientEthereum,
                DummyTokenInstance.address,
                amount,
                `0x${secretHash}`,
                60
            )
            
            await DummyTokenInstance.transfer(HTLCInstance.address, amount)
            await HTLCInstance.withdraw(`0x${secret.toString('hex')}`, { from: accounts[3] })

            const sigHash = await HTLCInstance.signatureHash()
            const hashedData = hexToUintArray(sigHash.substring(2))

            const { r, s, v } = createEthSign(hashedData, archPoolSigner.privateKey)
            
            try {
                await instance.provisionHTLC(HTLCInstance.address, `0x${r}`, `0x${s}`, v)
            }
            catch(e) {
                assert.equal(e.reason, "Swap contract already finished")
            }
        })

        it("should return an error when the HTLC's locktime elapsed", async() => {
            const DummyTokenInstance = await DummyToken.deployed()
            const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)
            await instance.unlock()

            const recipientEthereum = accounts[2]
  
            const amount = web3.utils.toWei('1')
            const secret = randomBytes(32)
            const secretHash = createHash("sha256")
                .update(secret)
                .digest("hex")

            const HTLCInstance = await HTLC.new(
                recipientEthereum,
                DummyTokenInstance.address,
                amount,
                `0x${secretHash}`,
                1
            )

            await increaseTime(2)
            
            const sigHash = await HTLCInstance.signatureHash()
            const hashedData = hexToUintArray(sigHash.substring(2))

            const { r, s, v } = createEthSign(hashedData, archPoolSigner.privateKey)
            
            try {
                await instance.provisionHTLC(HTLCInstance.address, `0x${r}`, `0x${s}`, v)
            }
            catch(e) {
                assert.equal(e.reason, "Swap contract lock time elapsed")
            }
        })


        it("should return an error when the HTLC contract is already provisioned", async() => {
            const DummyTokenInstance = await DummyToken.deployed()
            const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)            
            await instance.unlock()

            const recipientEthereum = accounts[2]

            await DummyTokenInstance.transfer(instance.address, web3.utils.toWei('2'))

            const HTLCInstance = await HTLC.new(
                recipientEthereum,
                DummyTokenInstance.address,
                web3.utils.toWei("1"),
                "0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08",
                1
            )

            const sigHash = await HTLCInstance.signatureHash()
            const hashedData = hexToUintArray(sigHash.substring(2))

            const { r, s, v } = createEthSign(hashedData, archPoolSigner.privateKey)
            
            try {
                await instance.provisionHTLC(HTLCInstance.address, `0x${r}`, `0x${s}`, v)
            }
            catch(e) {
                assert.equal(e.reason, "Swap contract already provisioned")
            }
        })

        it("should return an error when the signature is invalid", async() => {
            const DummyTokenInstance = await DummyToken.deployed()
            const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)            
            await instance.unlock()

            const recipientEthereum = accounts[2]

            await DummyTokenInstance.transfer(instance.address, web3.utils.toWei('2'))

            const HTLCInstance = await HTLC.new(
                recipientEthereum,
                DummyTokenInstance.address,
                web3.utils.toWei("1"),
                "0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08",
                1,
            )

            const sigHash = randomBytes(32)

            const { r, s, v } = createEthSign(sigHash, archPoolSigner.privateKey)

            try {
                await instance.provisionHTLC(HTLCInstance.address, `0x${r}`, `0x${s}`, 30)
            }
            catch(e) {
                assert.equal(e.reason, "ECDSA: invalid signature")
            }

            try {
                await instance.provisionHTLC(HTLCInstance.address, `0x${r}`, `0x${s}`, v)
            }
            catch(e) {
                assert.equal(e.reason, "Invalid signature - Archethic Pool key does not match signature")
            }
        })

        it("should return an error when the pool doesn't have enough funds to provide HTLC contract", async() => {
            const DummyTokenInstance = await DummyToken.deployed()
            const instance = await LiquidityPool.new(accounts[4], accounts[3], 5, archPoolSigner.address, 20000, DummyTokenInstance.address)            
            await instance.unlock()

            const recipientEthereum = accounts[2]

            const HTLCInstance = await HTLC.new(
                recipientEthereum,
                DummyTokenInstance.address,
                web3.utils.toWei("1"),
                "0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08",
                1,
            )


            const sigHash = await HTLCInstance.signatureHash()
            const hashedData = hexToUintArray(sigHash.substring(2))

            const { r, s, v } = createEthSign(hashedData, archPoolSigner.privateKey)

            try {
                await instance.provisionHTLC(HTLCInstance.address, `0x${r}`, `0x${s}`, v)
            }
            catch(e) {
                assert.equal(e.reason, "Pool doesn't have enough funds to provision the swap")
            }
        })
    })
})

