const DummyToken = artifacts.require("DummyToken")
const HTLC = artifacts.require("ERCSwapHTLC")


const { increaseTime} = require('./utils')
const { createHash, randomBytes } = require("crypto")

contract("ERC HTLC", (accounts) => {

  it("should create contract", async () => {
    const DummyTokenInstance = await DummyToken.deployed()
    const recipientEthereum = accounts[2]

    const HTLCInstance = await HTLC.new(
      recipientEthereum,
      DummyTokenInstance.address,
      web3.utils.toWei("1"),
      "0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08",
      1
    )

    assert.equal(await HTLCInstance.amount(), web3.utils.toWei("1"))
    assert.equal(await HTLCInstance.hash(), "0x9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08")
    assert.equal(await HTLCInstance.token(), DummyTokenInstance.address)
    assert.equal(await HTLCInstance.recipient(), recipientEthereum)
    assert.equal(await HTLCInstance.finished(), false)
    assert.equal(await HTLCInstance.lockTime(), 1)
  })

  describe("withdraw", () => {
    it("should withdraw the funds with the hash preimage reveal", async () => {
      const DummyTokenInstance = await DummyToken.deployed()
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
  
      assert.ok(await HTLCInstance.canWithdraw())

      const balance1 = await DummyTokenInstance.balanceOf(recipientEthereum)
  
      await HTLCInstance.withdraw(`0x${secret.toString('hex')}`, { from: accounts[2] })
  
      const balance2 = await DummyTokenInstance.balanceOf(recipientEthereum)
      assert.equal(1, web3.utils.fromWei(balance2) - web3.utils.fromWei(balance1))
    })

    it("should refuse the withdraw is the swap is already done", async () => {
      const DummyTokenInstance = await DummyToken.deployed()
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
  
      await HTLCInstance.withdraw(`0x${secret.toString('hex')}`, { from: accounts[2] })
      try {
        await HTLCInstance.withdraw(`0x${secret.toString('hex')}`, { from: accounts[2] })
      }
      catch(e) {
        assert.equal(e.reason, "Swap already done")
      }
    })

    it("should refuse the withdraw is secret is invalid", async () => {
      const DummyTokenInstance = await DummyToken.deployed()
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
  
      try {
        await HTLCInstance.withdraw(`0x${randomBytes(32).toString('hex')}`, { from: accounts[2] })
      }
      catch(e) {
        assert.equal(e.reason, "Wrong secret")
      }
    })

    it("should refuse the withdraw if the contract doesn't get funds", async () => {
      const DummyTokenInstance = await DummyToken.deployed()
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
  
      try {
        await HTLCInstance.withdraw(`0x${secret.toString('hex')}`, { from: accounts[2] })
      }
      catch(e) {
        assert.equal(e.reason, "Not enough funds")
      }
    })

    it("should refuse the withdraw if the locktime passed", async () => {
      const DummyTokenInstance = await DummyToken.deployed()
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

      await DummyTokenInstance.transfer(HTLCInstance.address, amount)

      await increaseTime(2)
      try {
        await HTLCInstance.withdraw(`0x${secret.toString('hex')}`, { from: accounts[2] })
      }
      catch(e) {
        assert.equal(e.reason, "Withdraw delay outdated, use refund")
      }
    })
  })

  describe("refund", () => {
    it("should refund the owner after the lock time", async () => {
      const DummyTokenInstance = await DummyToken.deployed()
      const recipientEthereum = accounts[2]
  
      const amount = web3.utils.toWei('1')
      const secret = randomBytes(32)
      const secretHash = createHash("sha256")
        .update(secret)
        .digest("hex")
  
      const balance1 = await DummyTokenInstance.balanceOf(accounts[0])
  
      const HTLCInstance = await HTLC.new(
        recipientEthereum,
        DummyTokenInstance.address,
        amount,
        `0x${secretHash}`,
        1
      )

      await DummyTokenInstance.transfer(HTLCInstance.address, amount)
      await increaseTime(2)

      assert.ok(await HTLCInstance.canRefund())

      await HTLCInstance.refund()
      const balance2 = await DummyTokenInstance.balanceOf(accounts[0])
      assert.equal(web3.utils.fromWei(balance2), web3.utils.fromWei(balance1))

      assert.equal(await HTLCInstance.finished(), true)
    })

    it ("should return an error if the swap is already finished", async() => {
      const DummyTokenInstance = await DummyToken.deployed()
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

      await DummyTokenInstance.transfer(HTLCInstance.address, amount)

      await increaseTime(2)
      await HTLCInstance.refund()
      assert.equal(false, await HTLCInstance.canRefund())

      try {
        await HTLCInstance.refund()
      }
      catch(e) {
        assert.equal(e.reason, 'Cannot refund a swap already finished')
      }
    })

    it ("should return an error if contract doesn't get funds", async() => {
      const DummyTokenInstance = await DummyToken.deployed()
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

      try {
        await HTLCInstance.refund()
      }
      catch(e) {
        assert.equal(e.reason, 'Not enough funds')
      }
    })

    it ("should return an error if the lock time is not reached", async() => {
      const DummyTokenInstance = await DummyToken.deployed()
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

      await DummyTokenInstance.transfer(HTLCInstance.address, amount)
      try {
        await HTLCInstance.refund()
      }
      catch(e) {
        assert.equal(e.reason, 'Cannot refund before the end of the lock time')
      }
    })
  })
})