[![Platform](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev)

# AE Bridge

## Main features


## Security
- Security access with your Archethic Wallet

## Application Initial Screen

## Pre-requisites

- Flutter 3.10+
- Dart 3+

# Note

*** This Application is currently in active development so it might fail to build. Please refer to issues or create new issues if you find any. Contributions are welcomed.

## Truffle smart contracts

There are different kind of EVM smart contracts:
- HTLC contracts
- Liquidity pools

All the contract have their own type depending on the token used: native or ERC, because transfers/balance verification acts differently.

### HTLC contracts

Those contract provide the atomic swap logic.

There are few types 

- Signed: contract where a signature from the Archethic's pool is required to provision the contract or to withdraw funds
- Chargeable: contract where a fee is defined and in which the pool is assigning the recipient

```mermaid
classDiagram
    HTLC <|-- HTLC_ERC
    HTLC <|-- HTLC_ETH
    HTLC_ERC <|-- SignedHTLC_ERC
    HTLC_ERC <|-- ChargeableHTLC_ERC
    HTLC_ETH <|-- SignedHTLC_ETH
    HTLC_ETH <|-- ChargeableHTLC_ETH
```

### Liquidity pools contracts

```mermaid
classDiagram
    Pool <|-- LP_ERC
    Pool <|-- LP_ETH
```

### Development

You need to have [Truffle](https://trufflesuite.com/docs/truffle/) installed

To contribute, you need to go on the truffle directory 
```bash
cd truffle
```

For tests you can use unit tests:
```bash
truffle test
```

To use the pool in a local environment you can use migrations with:
```bash
truffle deploy
```

This will create two pools for ETH and ERC.
It will also create a dummy token, accessible via `LP_ERC.token()`

In order to test the signature from the LP Archethic pool you can use this tool to generate the signature:
```bash
node signing_tool.js 0x[DIGEST] 0x00d171013047636e2af5c7645377ed3e82f07d8ffe95a2aa65520306046be93f
```

The last parameter being the private key of the accounts[6] configured as the signer key in the migrations for the development network on Ganache



