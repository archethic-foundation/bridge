[![Platform](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev)

# AE Bridge

## Main features
- Bridge native tokens and ERC20 from EVM Blockchain (Ethereum, BSC, Polygon) to Archethic blockchain
- Bridge UCO and wrapped tokens from Archethic Blockchain to EVM Blockchain (Ethereum, BSC, Polygon)
- Refund

## Security
- Security access with your Archethic Wallet and EVM compatible wallet (Metamask, Brave, ...)

## Development

In order to develop and test the application, you need to have some prerequisites:

- [Ganache](https://trufflesuite.com/ganache/) (Simulation of the Ethereum's node)
- [Node.js](https://nodejs.org/)
- [Flutter](https://flutter.dev/)
  - Flutter 3.13+
  - Dart 3.1+
- [Archethic node](https://github.com/archethic-foundation/archethic-node#running-a-node-for-development-purpose) (running in devnet mode)
- [Archethic Wallet](https://github.com/archethic-foundation/archethic-wallet) (Desktop version ie MacOS, Linux, Windows)
- EVM wallet ie Metamask, Brave, ...

### Steps

#### 1) Create an EVM Wallet
  - Launch Ganache and create a new workspace with 
    - Network id 1337 (Server tab)
    - Seed `inflict author desk anxiety music swear acquire achieve link young benefit biology` (Accounts & Keys tab)
    - Generate 10 accounts (Accounts & Keys tab)
  - Start your EVM wallet :
    - Add Ganache network with these properties
      - Network name: Ganache
      - RPC Url: http://127.0.0.1:7545
      - Chain Id: 1337
      - Symbol: ETH
    - Import an account using the private key from the first workspace's account 
  - Click on "Key" icon in the first row on the Accounts tab
  - Copy the private key
  - Paste the private key into your EVM wallet
  
#### 2) Create an Archethic Wallet
  - Start Archethic Node in the devnet environnment (ie local environnment)
    If you want to fill Pool and Factory chains with faucet, you can ,before start the node, update the `Archethic.Bootstrap.NetworkInit` section in `config/dev.exs` Node's file
    ```elixir

    # Faucet
    # Factory: 00006e985f953bba22776b1ce8202789002447f8129a8837db811e5438e5450d0584
    # Pool UCO: 00004ae35d87f8a74f3101a020c26676c3f80c62e4bf49d9ceea7ac5b72587b43aa3
    # Pool aeETH: 000076922e553e45373185ff8fca84aed0036a478864fa19f39133c337a85f0e7ed7
    config :archethic, Archethic.Bootstrap.NetworkInit,
    genesis_pools: [
    %{
      address:
        "00001259AE51A6E63A1E04E308C5E769E0E9D15BFFE4E7880266C8FA10C3ADD7B7A2"
        |> Base.decode16!(case: :mixed),
      amount: 1_000_000_000_000_000
    },
    %{
      address:
        "00006e985f953bba22776b1ce8202789002447f8129a8837db811e5438e5450d0584"
        |> Base.decode16!(case: :mixed),
      amount: 1_000_000_000_000_000_000_000
    },
    %{
      address:
        "00004ae35d87f8a74f3101a020c26676c3f80c62e4bf49d9ceea7ac5b72587b43aa3"
        |> Base.decode16!(case: :mixed),
      amount: 1_000_000_000_000_000_000_000
    },
    %{
      address:
        "000076922e553e45373185ff8fca84aed0036a478864fa19f39133c337a85f0e7ed7"
        |> Base.decode16!(case: :mixed),
      amount: 1_000_000_000_000_000_000_000
    }]```

  - Launch the Archethic Wallet
  - Create a new account in the devnet environnment
  - [Obtain UCO from the faucet for the account](http://localhost:4000/faucet)
  
#### 3) Deploy Archethic Pools
  - Execute the following commands to deploy the contracts
    ```bash
    cd contracts/archethic;npm install;node deploy_factory.js;node deploy_pool.js UCO;node deploy_pool.js WETH;cd -
    ```
    - If you encounter an "Insufficient funds" error:
      - [Obtain UCO tokens from the faucet for the Pool genesis address](http://localhost:4000/faucet) (with 300 UCO)
      - Retry deploying the contracts.

#### 4) Deploy EVM Pools
  - Execute the following commands to install truffle and to deploy the contracts:

    ```bash
    cd contracts/evm;npm install -g truffle;npm install;truffle deploy;cd -
    ```
  More infos: [Truffle](https://trufflesuite.com/docs/truffle/how-to/install/) (Tools for EVM smart contract development)

  - Add ERC Token in your EVM Wallet
    - Search in terminal "info 3_deploy_erc.pool.js/Deployed token" and put the value to EVM Wallet

#### 5) Run AEBridge
  - Execute the following command at the project's root to launch the app with Chrome extension availability:
    ```bash
    flutter run -d web-server 
    ```  
  - Copy/Paste the app URL (ex: http://localhost:49316/) into Chrome 
  NB: The port number could be different

If you want to debug the Flutter app, you should enable chrome extensions:
  - Go to `flutter\bin\cache` and remove a file named: `flutter_tools.stamp`
  - Go to `flutter\packages\flutter_tools\lib\src\web` and open the file `chrome.dart`.
  - Find `--disable-extensions` and `--disable-popup-blocking` and comment these lines
Ref: https://stackoverflow.com/questions/67958169/how-chrome-extensions-be-enabled-when-flutter-web-debugging/71747975#71747975

## Note

*** This Application is currently in active development so it might fail to build. Please refer to issues or create new issues if you find any. Contributions are welcomed.

# Contracts management

To get more details on the contracts, please take a look at the bridge's contract [repository](https://github.com/archethic-foundation/bridge-contracts)
