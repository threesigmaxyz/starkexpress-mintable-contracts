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

# Select deployment network
echo "Select an network:"
network=$(select_option "goerli" "mainnet")
echo -e "Selected network: $network\n"

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

# Run the deployment script
forge script script/Deploy_${token}Mintable.s.sol:Deploy_${token}Mintable \
    -f $network \
    --broadcast \
    -vvvv \
    --private-key $PRIVATE_KEY \
    --verify \
    --delay 20 \
    --retries 10 \