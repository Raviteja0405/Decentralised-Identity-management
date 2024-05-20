# Identity Management DApp

## Overview

The Identity Management DApp is a decentralized application built on the Ethereum blockchain that allows institutions to manage and verify digital identities. The project utilizes smart contracts to store and verify identities securely, ensuring that only authorized entities can add or remove identities.

## Features

- **Add Identity**: Authorized institutions can add new identities to the blockchain.
- **Remove Identity**: Authorized institutions can remove identities from the blockchain.
- **Verify Identity**: Users can verify the details of an identity to ensure its authenticity.
- **Secure and Immutable**: Identities are stored on the blockchain, making them secure and tamper-proof.

## Technologies Used

- **Solidity**: Smart contract programming language.
- **Hardhat**: Development environment for compiling, deploying, testing, and debugging Ethereum software.
- **Ethers.js**: Library to interact with the Ethereum blockchain and its ecosystem.
- **React**: JavaScript library for building user interfaces.
- **MetaMask**: Browser extension for interacting with the Ethereum blockchain.

## Prerequisites

- Node.js and npm installed
- MetaMask extension installed on your browser
- Local Ethereum node running (e.g., Hardhat, Ganache)

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/Raviteja0405/Decentralised-Identity-management
cd Decentralised-Identity-management
```

### Install Dependencies

Navigate to both the `backend` and `frontend` directories and install the required dependencies.

```bash
# For backend
cd backend
npm install

# For frontend
cd ../frontend
npm install
```

### Compile and Deploy Smart Contracts

Make sure your local Ethereum node is running. Then, compile and deploy the smart contracts using Hardhat.

```bash
# Navigate to backend directory
cd backend

# Compile the contracts
npx hardhat compile

# Deploy the contracts
npx hardhat run scripts/deploy.js --network localhost
```

### Configure Frontend

Copy the deployed contract address and ABI to the frontend directory.

```bash
cp artifacts/contracts/IdentityManagement.sol/IdentityManager.json ../frontend/src/abi/
```

Ensure that the `contract-address.json` file is created in `frontend/src/abi/` with the correct deployed contract address.

### Run the Frontend

Navigate to the `frontend` directory and start the development server.

```bash
cd ../frontend
npm start
```

### Interact with the DApp

Open your browser and navigate to `http://localhost:3000`. Make sure your MetaMask is connected to your local Ethereum node.

## Project Structure

```plaintext
my-dapp
├── .gitignore
├── backend
│   ├── artifacts
│   ├── cache
│   ├── contracts
│   │   ├── IdentityManagement.sol
│   │   └── Lock.sol
│   ├── hardhat.config.js
│   ├── package.json
│   ├── scripts
│   │   └── deploy.js
│   └── test
│       └── Lock.js
├── frontend
│   ├── .env
│   ├── package.json
│   ├── public
│   │   └── index.html
│   └── src
│       ├── abi
│       │   ├── contract-address.json
│       │   └── IdentityManager.json
│       ├── components
│       │   └── App.js
│       ├── index.css
│       └── index.js
```

## Smart Contract Details

### IdentityManagement.sol

This contract allows institutions to add, remove, and verify identities on the blockchain.

#### Functions

- `addIdentity(string memory _fingerprint, string memory _signature, bool _verified)`: Adds a new identity.
- `removeIdentity(string memory _fingerprint)`: Removes an existing identity.
- `getIdentity(string memory _fingerprint)`: Retrieves the details of an identity.
- `removeContract()`: Destroys the contract (only for the owner).

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes.

## License

This project is licensed under the MIT License.
