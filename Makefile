-include .env

all: clean update build

# Clean the repo
clean :;
	@forge clean

# Install dependencies
install :;
	@forge install foundry-rs/forge-std@master && \
	forge install openzeppelin/openzeppelin-contracts@master

# Update dependencies
update :;
	@forge update

# Build the project
build :;
	@forge build

# Format code
format:
	@forge fmt

# Lint code
lint:
	@forge fmt --check

# Run tests
tests :;
	@forge test -vvv

# Run tests with coverage
coverage :;
	@forge coverage

# Run tests with coverage and generate lcov.info
coverage-report :;
	@forge coverage --report lcov

# Run slither static analysis
slither :;
	@slither ./src

documentation :;
	@forge doc --build

# Run local blockchain
anvil :;
	@anvil -m 'test test test test test test test test test test test junk'

deploy-local :;
	@export FOUNDRY_PROFILE=deploy && \
	./utils/deploy_local.sh && \
	export FOUNDRY_PROFILE=default

deploy-remote :;
	@export FOUNDRY_PROFILE=deploy && \
	./utils/deploy_remote.sh && \
	export FOUNDRY_PROFILE=default