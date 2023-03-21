# StarkExpress Mintable Contracts [![Github Actions][gha-badge]][gha] [![Foundry][foundry-badge]][foundry] [![License: MIT][license-badge]][license]

[gha]: https://github.com/threesigmaxyz/starkexpress-mintable-contracts/actions
[gha-badge]: https://github.com/threesigmaxyz/starkexpress-mintable-contracts/actions/workflows/ci.yml/badge.svg
[foundry]: https://getfoundry.sh/
[foundry-badge]: https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg
[license]: https://opensource.org/licenses/MIT
[license-badge]: https://img.shields.io/badge/License-MIT-blue.svg

This repository contains the source code, test suit and deployment scripts for the mintable token smart contracts to be used in [StarkExpress](https://starkexpress.io).

## What's Inside
- [MintableERC20](https://threesigmaxyz.github.io/starkexpress-mintable-contracts/src/erc20/ERC20Mintable.sol/contract.ERC20Mintable.html): A mintable token according to the [ERC20](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/) fungible token standard.
- [MintableERC721](https://threesigmaxyz.github.io/starkexpress-mintable-contracts/src/erc721/ERC721Mintable.sol/contract.ERC721Mintable.html): A mintable token according to the [ERC721](https://ethereum.org/en/developers/docs/standards/tokens/erc-721/) non-fungible token standard.
- [MintableERC1155](https://threesigmaxyz.github.io/starkexpress-mintable-contracts/src/erc1155/ERC1155Mintable.sol/contract.ERC1155Mintable.html): A mintable token according to the [ERC1155](https://ethereum.org/en/developers/docs/standards/tokens/erc-1155/) multi-token standard.

The documentation for all contracts in this repository can be found [here](https://threesigmaxyz.github.io/starkexpress-mintable-contracts/).

# Getting Started
## Requirements
In order to run the tests and deployment scripts you must install the following:

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) - A distributed version control system
- [Foundry](https://book.getfoundry.sh/getting-started/installation) - A toolkit for Ethereum application development.

Additionaly, you should have [make](https://man7.org/linux/man-pages/man1/make.1.html) installed.

## Installation
```sh
git clone https://github.com/threesigmaxyz/starkexpress-mintable-contracts
cd starkexpress-mintable-contracts
make all
```

## Testing
To run all tests execute the following commad:
```
make test
```
Alternatively, you can run specific tests as detailed in this [guide](https://book.getfoundry.sh/forge/tests).

# Deployment
The deployment script performs the following actions:
- Deploys the mintable token contract;
- Verifies the contracts source on [Etherscan](https://etherscan.io);

## Setup
Prior to deployment you must configure the following variables in the `.env` file:

- `PRIVATE_KEY`: The private key for the deployer wallet.
- `STARKEXPRESS_STARKEX_ADDRESS`: The StarkEx contract used by StarkExpress.

## Local Deployment
By default, Foundry ships with a local Ethereum node [Anvil](https://github.com/foundry-rs/foundry/tree/master/anvil) (akin to Ganache and Hardhat Network). This allows us to quickly deploy to our local network for testing.

To start a local blockchain, with a determined private key, run:
```
make anvil
```

Afterwards, you can deploy to it via:
```
make deploy-local
```

## Remote Deployment
In order to deploy contracts to a remote chain you must configure the corresponding RPC endpoint as an environment variable. Additionaly, to verify the contracts another variable must be set with a block explorer API key. The following table details which variables to configure depending on the target network:

| Network ID | RPC Variable | API Variable | Description
| --- | --- | --- | --- |
| goerli | `RPC_URL_GOERLI` | `ETHERSCAN_KEY` | Testnet (uses test data) |
| mainnet | `RPC_URL_MAINNET` | `ETHERSCAN_KEY` | Mainnet (uses live data) |

Note that a fresh `ETHERSCAN_KEY` can take a few minutes to activate, you can query any [endpoint](https://api-goerli.etherscan.io/api?module=block&action=getblockreward&blockno=2165403&apikey=ETHERSCAN_API_KEY) to check its status.
Additionaly, if you need testnet ETH for the deployment you can request it from the following [faucet](https://faucet.paradigm.xyz/).

To execute the deployment run:
```
make deploy-remote
```

Forge is going to run our script and broadcast the transactions for us. This can take a little while, since Forge will also wait for the transaction receipts.

# About Us
[Three Sigma](https://threesigma.xyz/) is a venture builder firm focused on blockchain engineering, research, and investment. Our mission is to advance the adoption of blockchain technology and contribute towards the healthy development of the Web3 space.

If you are interested in joining our team, please contact us [here](mailto:info@threesigma.xyz).

---

<p align="center">
  <img src="https://threesigma.xyz/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fthree-sigma-labs-research-capital-white.0f8e8f50.png&w=2048&q=75" width="75%" />
</p>
