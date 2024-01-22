#!/bin/bash
set -e # Abort the script at first error
set -u # Treat unset variables as an error

# Function to log and save output
log_and_save() {
    echo "$1" >> setup_info.txt
    echo "$1"
}

# Get Ethereum Private Key from environment variable
ethPrivateKey="${PRIV_KEY}"

# Check if the Ethereum Private Key is not empty
if [ -z "$ethPrivateKey" ]; then
    echo "Error: Ethereum Private Key (PRIV_KEY) is not set."
    exit 1
fi

# Set environment for Rust
source "$HOME/.cargo/env"

# Check Rust and Cargo versions
rustc_version=$(rustc --version)
cargo_version=$(cargo --version)
log_and_save "Rust version: $rustc_version"
log_and_save "Cargo version: $cargo_version"

# Install Solana CLI
echo "Installing Solana CLI..."
sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
export PATH="/root/.local/share/solana/install/active_release/bin:$PATH"
solana config set --url https://testnet.dev2.eclipsenetwork.xyz
solana_keygen_output=$(solana-keygen new --no-passphrase)
log_and_save "$solana_keygen_output"
pubKey=$(echo "$solana_keygen_output" | grep 'pubkey' | awk '{print $2}')

# Fetch the repository
echo "Fetching the testnet-deposit repository..."
git clone https://github.com/Eclipse-Laboratories-Inc/testnet-deposit.git
cd testnet-deposit
yarn install

# Execute the script
echo "Executing deposit.js script..."
transaction_output=$(node deposit.js $pubKey 0x7C9e161ebe55000a3220F972058Fb83273653a6e 15000000 10000 $ethPrivateKey https://rpc.sepolia.org)
log_and_save "Transaction output: $transaction_output"


# Fetch helloworld application
echo "Fetching helloworld application..."
git clone https://github.com/solana-labs/example-helloworld
cd example-helloworld
npm install
npm run build:program-rust

# Deploy helloworld
echo "Deploying helloworld..."
deploy_output=$(solana program deploy dist/program/helloworld.so)
log_and_save "Deploy output: $deploy_output"

# Test the result
echo "Testing the application..."
test_result=$(npm run start)
log_and_save "Test result: $test_result"

echo "Setup completed. All information is saved in setup_info.txt."
