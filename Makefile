-include .env

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install foundry-rs/forge-std@v1.8.2 --no-commit && forge install openzeppelin/openzeppelin-contracts@v5.0.2 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

deploy-job-contract:
	@forge script script/DeployRNDXJobContract.s.sol:DeployRNDXJobContract --rpc-url $(ANVIL_RPC) --private-key $(ANVIL_PRIVATE_KEY) --broadcast

deploy-job-contract-to-sepolia:
	@forge script script/DeployRNDXJobContract.s.sol:DeployRNDXJobContract --rpc-url $(SEPOLIA_RPC) --private-key $(SEPOLIA_PRIVATE_KEY) --broadcast

deploy-job-contract-to-mainnet:
	@forge script script/DeployRNDXJobContract.s.sol:DeployRNDXJobContract --rpc-url $(MAINNET_RPC) --private-key $(MAINNET_PRIVATE_KEY) --broadcast

deploy-token:
	@forge script script/DeployRNDX.s.sol:DeployRNDX --rpc-url $(ANVIL_RPC) --private-key $(ANVIL_PRIVATE_KEY) --broadcast

deploy-token-to-sepolia:
	@forge script script/DeployRNDX.s.sol:DeployRNDX --rpc-url $(SEPOLIA_RPC) --private-key $(SEPOLIA_PRIVATE_KEY) --broadcast	

deploy-token-to-mainnet:
	@forge script script/DeployRNDX.s.sol:DeployRNDX --rpc-url $(MAINNET_RPC) --private-key $(MAINNET_PRIVATE_KEY) --broadcast	


transfer-token:
	@forge script script/TransferRNDX.s.sol:TransferRNDX --rpc-url $(ANVIL_RPC) --private-key $(ANVIL_PRIVATE_KEY) --broadcast