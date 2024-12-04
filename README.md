## Renaday Smart Contract | Corresponding Pelita Bangsa x LISK bootcamp

This Smart Contracts written on Foundry, it's my first smart contract, i'm an ambitious person when it comes to learn something new, i watch many videos to get me here

Let's move on, get your foundry if you don't have it yet
https://book.getfoundry.sh/getting-started/installation

## .env File - Environment it contains RPC_URL and your private key

ANVIL_RPC=YOUR_URL

ANVIL_PRIVATE_KEY=YOUR_PRIVATE_KEY

SEPOLIA_RPC=YOUR_URL

SEPOLIA_PRIVATE_KEY=YOUR_PRIVATE_KEY

MAINNET_RPC=YOUR_URL

MAINNET_PRIVATE_KEY=YOUR_PRIVATE_KEY

WHAT IS ENVIL? Here you go https://book.getfoundry.sh/anvil/

## Makefile - Makes my life easier
Check the Makefile script, you can ask AI what the code is doing, but to make it short
this smart contract use openzeppelin, and use .env 

WHAT IS OPENZEPPELIN? Here you go https://docs.openzeppelin.com/contracts

To install dependencies / library , such as openzeppelin with Makefile, you just need to run this command in terminal

`make install`

after all libs installed you can start to run a test with this command in terminal
`forge test` or `make test`

## WHAT IS THIS PROJECT ABOUT?
Smart contracts in this project will be used for my project which temporarily hosted  https://renaday-njs-rndxs-projects.vercel.app/ will be moved to my domain https://renaday.com [In propagation mode - will be moved once it's ready]

In this stage, this project has 2 smart contracts

1. RNDX.sol which is ERC20 type which i deployed to LISK Sepolia https://sepolia-blockscout.lisk.com/address/0x2C2Fa728700D8a98bB21c69F40c6e28F3e7231EF  you can edit it, and try to deploy as well
2. RNDXJobContract [IN PROGRESS TO FINAL FORM] also on LIST Sepolia https://sepolia-blockscout.lisk.com/address/0xBEd24D0d64d0f97194B79CC3d9B91A97320ce10E?tab=txs  this smart contract is working as decentralized job contract for freelancing platform like upwork, fiverr, and so on why it's needed? simply no one will say what to do, except you and your client

The project continue... 

This project will extends to another type of smart contract which is ERC721 [Non-Fungible Tokens | NFT] NFT is not only about images / pictures without art values but have insane price , read more https://docs.openzeppelin.com/contracts/5.x/erc721 for renaday, it will be used to tokenized a real world job contract

## DEPLOYMENT COMMANDS
You can check Makefile to see what actuall command buy you can run this command in your terminals

LOCALS NODE BLOCKCHAIN - ANVIL, GANACHE etc, I'm using ANVIL in this case, that's why my env is ANVIL_RPC, commands to deploy are:
1. deploy-job-contract | to deploy RNDXJobContract
2. deploy-token | to deploy RNDX.sol ERC20 type of smart contract

PUBLIC TESTNET - LISK SEPOLIA, ETHEREUM SEPOLIA, POLYGON Amoy etc
1. deploy-job-contract-to-sepolia
2. deploy-token-to-sepolia

PUBLIC MAINNET - LISK, ETHEREUM, POLYGON etc
1. deploy-job-contract-to-mainnet
2. deploy-token-to-mainnet


## WHAT IS PRIVATE KEY
## WARNING !!! PRIVATE KEY IS PRIVATE DO NOT SHARE TO ANYONE ELSE!!
you can find the key in you web3 wallet like MetaMask, brave wallet OKX, etc this is how to see it https://support.metamask.io/managing-my-wallet/secret-recovery-phrase-and-private-keys/how-to-export-an-accounts-private-key/  

with ANVIL, you can see it once you run ANVIL on your local
