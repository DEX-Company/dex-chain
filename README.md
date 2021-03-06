# Datacraft-chain

This repo now installs the Datacraft contracts, and also runs datacraft block chain network for testing.

## Development
To develop any contract you need to install the supported packages.

```
npm install
```

To compile the contracts, you need to type:
```
npm run compile
```

## Installing
Currently this repo only installs contracts to a local private block chain.
So first you need to open a new terminal and start the private block chain.

```
./scripts/run_local_network.sh
```

Then you can deploy all of the contracts to the local private network by typing:
```
npm run deploy:local
```

## Local Private Network
The local private network has the following accounts pre-loaded with Ethereum balances of ETH 10000000000000000000000000000000000000000:

Index | Address
------|--------
 0    | 0x19C2a80BE6f5fA50d4274FecdF7F4b441fB852c8
 1    | 0xF3dc3d005F3e854Ce904A7bbF1e09dCe286caF64
 2    | 0xd520Bc7A6024C0CAB5B02c32e760bAfBe10d58ea
 3    | 0x84dED6e0Ac0EfAe6bE17deCeC62C9B11d5E71d34
 4    | 0xF4AB160944ce422874Ccc0412A800b0a313e773D
 5    | 0x34aB9eE46a97b64EC2aBF284A639b07d2daF9D54
 6    | 0x4abC6c82dBe05db16eBea42d60525d34cF663494
 7    | 0x0B332137759e7Dd36e7b4b6397B18d49214D193c
 8    | 0x56277c18ef103cDBBa7Fc0FB2CE8dC215Dc7dE7a
 9    | 0xf481E5FAda62e15D7d52B7cE79458Ce485c08663
 10   | 0x2Ae56bCf4DFA07Df811f5533079c15BCcF0d8Aa6
 11   | 0xF9a9aDC648A620eEf3969dB607128002ee263237
 12   | 0x07295bA44C2FF409255DB296408a64c995b6048d
 13   | 0x92760a24E7B7A59881b371364Dee07FdB0c268eA
 14   | 0xF61C69eb778B11893aA9D865f74a3BEdd9094dc1
 15   | 0x76a87d8059C7D6a08e16703F7732770B947eA24e
 16   | 0x3DC7c3DA2a641925479Db976E5890146eb21f7fb
 17   | 0x0E896770E716751eaAc8dFa689AA7a19e21634fB
 18   | 0xe3a802289Eff3d89AD211B5EC6BE8019BDdC5836
 19   | 0x8001A6Da1A2Cb86E2232F16AB50b1BC99dA70bE3


The first three accounts have been unlocked on the local node (this may be removed later).

Each account has a keystore [file](https://github.com/datacraft-dsc/datacraft-chain/tree/release/networks/local/keystore)
where the password is set too **datacraft-secret**.

Or using a Hierarchical Deterministic Wallet, you can obtain the private key for each account using the following mnemonic:

    winner soccer news orphan banner vicious swarm obtain dash cradle print outer


## Building Java artifacts template files
To build the Java runtime, you need to the run:

```
./scripts/build_java_artifacts.sh
```
The template files will be writtern to the `build/src/` folder.

## Run the local private network for testing
If you have `geth` and `node` already installed, then you can run and deploy the contracts for testing as follows:
```
./scripts/run_local_network.sh deploy
```

Or you can run the docker file, which will do the same but you do not need to install any of the packages/software to run the private network.
```
docker run -t datacraft-chain -p 8545:9545 -p 8550:8550 './scripts/run_local_network.sh' deploy
```

## Contract Artifact Packages

### Building Contract Artifact Packages
As each deployed contract the truffle migration script will create an artifact file. At the end of the deployment the script will then add all of the artifact files to the artifact packages.

The deploy steps for any network are as follows:

+   Deploy the contract on the network.

+   Write an artifact file with the contract address into the folder:

        artifacts/<contractName>.<networkId>.json

+   At the end of the deployment, create two artifact package files:

    `artifacts/artifacts.json.gz` : This file contains all of the published contracts in public/test networks except the local private network ( 1337 ).

    `artifacts/artifacts.<networkId>.json.gz` : This contains all of the contracts currently deployed on the network with the id **networkId**.


### Using Contract Artifact Packages
So there are three methods for a starfish library to load the contract ABI files and contract addresses via the artifact files.

1. Load the ABI files using a template library ( Java ).

2. Copy artifact files directly from the artifact folder on the network chain, at start of runtime.

3. Include the `artifacts.json.gz` with the starfish library and use this for accessing contracts, by gunzip the files data and reading the JSON object.


### Local Private Network
With the Local Private Network, there is an issue in obtaining the correct contract address. Since the contracts have just been deployed the addresses will always be different. So instead of copying the artifact files directly or using a pre-build artifact package file, the Local Private Network runs a simple http server at **http://localhost:8550** that provides the following uri's:

+   /           GET       - return the status of the network, networkId and datacraft-chain version.

+   /artifacts  GET       - If deployed returns a JSON object with all of the deployed artifacts. If not deployed returns an empty object.

The starfish library can the just request this server for the latest artifacts to be included into the library.

### Artifacts Package Structure
The Artifacts package contains the following structure:

    {
        'version': '<datacraft-chain-version>',
        'artifacts': {
            '<networkId1>': {
                '<contractName1>': { // artifact data  },
                '<contractName..n>': { // artifact data  }
            }
            '<networkId..n>': {
                '<contractName1>': { // artifact data  },
                '<contractName..n>': { // artifact data  }
            }
        }
    }

