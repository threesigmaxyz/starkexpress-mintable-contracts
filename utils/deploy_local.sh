#!/usr/bin/env bash

# Load environment variables
source .env

select_option() {
  local options=("$@")
  local selected_option=

  while true; do
    select option in "${options[@]}"; do
      if [[ -n "$option" ]]; then
        selected_option=$option
        break
      fi
      echo "Invalid option. Please select again."
    done

    read -p "Is this correct? [y/n]: " confirm
    if [[ $confirm =~ ^[Yy]$ ]]; then
      break
    fi
  done

  echo "$selected_option"
}

# Select token to deploy
echo "Select an token:"
token=$(select_option "ERC20" "ERC721" "ERC1155")
echo -e "Selected token: $token\n"

# Prompt user for additional variables based on selected token
echo "Select token parameters:"
case "$token" in
  "ERC20")
    read -p "Enter token name: " name
    read -p "Enter token symbol: " symbol
    echo -e "Deploying ERC20 token with name '$name' and symbol '$symbol' in '$network'\n"
    ;;
  "ERC721")
    read -p "Enter token name: " name
    read -p "Enter token symbol: " symbol
    read -p "Enter metadata URL: " metadata_url
    echo -e "Deploying ERC721 token with name '$name', symbol '$symbol', and metadata URL '$metadata_url' in '$network'\n"
    ;;
  "ERC1155")
    read -p "Enter token name: " name
    read -p "Enter token symbol: " symbol
    read -p "Enter metadata URI: " metadata_uri
    echo -e "Deploying ERC1155 token with name '$name', symbol '$symbol', and metadata URI '$metadata_uri' in '$network'\n"
    ;;
  *)
    echo "Invalid token selected."
    exit 1
    ;;
esac

# Export script variales
export STARKEXPRESS_MINTABLE_TOKEN_NAME=$name
export STARKEXPRESS_MINTABLE_TOKEN_SYMBOL=$symbol
export STARKEXPRESS_MINTABLE_TOKEN_URI=$uri

# Load deployer account
cast rpc --rpc-url http://localhost:8545 anvil_setBalance 0xBA5ED0f7622041FA6Ae4F7040f6865303ff6DbeD 0x99999999999999999999

# We specify the anvil url as http://localhost:8545
# We need to specify the sender for our local anvil node
forge script script/Deploy_${token}Mintable.s.sol:Deploy_${token}Mintable \
    --fork-url http://localhost:8545 \
    --broadcast \
    -vvvv \
    --sender 0xBA5ED0f7622041FA6Ae4F7040f6865303ff6DbeD \
    --private-key 0x43196f4dfd3c8dc66c7845313b8e025d567f6e53f921f48a8667ad123a40b501