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

- [Node.js](https://nodejs.org/)
- [Flutter](https://flutter.dev/)
  - Flutter 3.22+
  - Dart 3.4+
- [Archethic node](https://github.com/archethic-foundation/archethic-node#running-a-node-for-development-purpose) (running in devnet mode)
- [Archethic Wallet](https://github.com/archethic-foundation/archethic-wallet) (Desktop version ie MacOS, Linux, Windows)
- EVM wallet ie Metamask, Brave, ...

### Steps

#### 1) Create an EVM Wallet
  - Start your EVM wallet :
    - Add Hardhat network with these properties
      - Network name: Hardhat
      - RPC Url: http://127.0.0.1:8545
      - Chain Id: 31337
      - Symbol: ETH
    - Import an account using the private key from the first workspace's account 
  
#### 2) Create an Archethic Wallet
  - Start Archethic Node in the devnet environnment (ie local environnment)
    If you want to fill Pool and Factory chains with faucet, you can ,before start the node, update the `Archethic.Bootstrap.NetworkInit` section in `config/dev.exs` Node's file
    ```elixir

    # Master Chain (pools' management): 000023ca0313eb76617060ae119b48e98e689f2b2ef030e6df063d426dc0b00f4428
    # Pool UCO: 0000f53a34560bfe06b01689e585d53c07671f6eaa1b31e62659d8f7d5292f066941
    # Faucet: 00001259AE51A6E63A1E04E308C5E769E0E9D15BFFE4E7880266C8FA10C3ADD7B7A2
    config :archethic, Archethic.Bootstrap.NetworkInit,
    genesis_pools: [
      %{
        address:
          "000023ca0313eb76617060ae119b48e98e689f2b2ef030e6df063d426dc0b00f4428"
          |> Base.decode16!(case: :mixed),
        amount: 1_000_000_000_000_000
      },
      %{
        address:
          "0000f53a34560bfe06b01689e585d53c07671f6eaa1b31e62659d8f7d5292f066941"
          |> Base.decode16!(case: :mixed),
        amount: 1_000_000_000_000_000
      },
      %{
        address:
          "00001259AE51A6E63A1E04E308C5E769E0E9D15BFFE4E7880266C8FA10C3ADD7B7A2"
          |> Base.decode16!(case: :mixed),
        amount: 1_000_000_000_000_000
      }
    ]  
    ```

  - Launch the Archethic Wallet in desktop version (Linux, Windows, MacOS)
  - Create a new account in the devnet environnment
  - [Obtain UCO from the faucet for the account](http://localhost:4000/faucet)
  
#### 3) Deploy Archethic Pools
  - Execute the following commands to deploy the contracts
    ```bash
    cd contracts/archethic;npm install;node bridge init_keychain;node bridge deploy_factory;node bridge deploy_pool --token UCO;node bridge deploy_pool --token aeETH;cd -
    ```
    - If you encounter an "Insufficient funds" error:
      - [Obtain UCO tokens from the faucet for the Pool genesis address](http://localhost:4000/faucet) (with 300 UCO)
      - Retry deploying the contracts.

#### 4) Deploy EVM Pools
  - Execute the following commands to install EVM contracts management's dependencies and to start a local node:

    ```bash
    cd contracts/evm;npm install;npx hardhat node;cd -;
    ```
  
  - Execute the following commands in another terminal to deploy the contracts and fill the pools with tokens:
- 
    ```bash
    cd contracts/evm;npm run deploy;npm run fill-eth; npm run fill-erc;cd -;
    ```
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
