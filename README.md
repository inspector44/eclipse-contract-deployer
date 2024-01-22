# Eclipse Builders Hello-World Smart Contract Deployer

This repository provides a Docker environment for Eclipse Builders, designed to facilitate the deployment and interaction with the `hello-world` smart contract.

## Features

- Integrated Node.js and Yarn for efficient JavaScript package management.
- Rust environment setup, crucial for compiling and deploying Rust-based blockchain applications.
- Solana CLI for seamless interaction with the Solana blockchain.
- Ethereum private key integration for conducting Ethereum transactions.
- Special focus on deploying and testing the `hello-world` smart contract.

## Getting Started

### Prerequisites

- Ensure Docker is installed on your system.
- Familiarity with Docker, Ethereum, Solana, and smart contract concepts is recommended.

### Build Instructions

1. Clone the Eclipse Builders repository:

    ```bash
    git clone https://github.com/inspector44/eclipse-contract-deployer.git
    ```

2. Navigate to the cloned directory:

    ```bash
    cd eclipse-contract-deployer
    ```

3. Build the Docker image:

    ```bash
    docker build -t eclipse-builders-hello-world .
    ```

### Running the Container

- Execute the container using Docker:

    ```bash
    docker run --env PRIV_KEY=[Your Ethereum Private Key] eclipse-builders-hello-world
    ```

    Replace `[Your Ethereum Private Key]` with your actual private key.

### Setup Script

The `setup_script.sh` script automates the following tasks:

- Validates and logs Rust and Cargo versions.
- Installs and configures the Solana CLI.
- Executes the `testnet-deposit` script for Ethereum transactions.
- Clones, builds, and deploys the `hello-world` smart contract in the Solana ecosystem.
- Records the output of all operations in `setup_info.txt`.

## Contributing

Feel free to submit pull requests or open issues for improvements or bug fixes.

