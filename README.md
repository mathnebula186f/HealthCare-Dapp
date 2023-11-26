# Healthcare App

Welcome to the Healthcare App, a blockchain-based application designed for secure and transparent healthcare data management. This application utilizes the Ethereum blockchain, with the backend implemented in Solidity and the frontend built using React. To interact with the blockchain, the MetaMask browser extension is required. The local blockchain for development and testing is provided by Ganache.

## Features

1. **Blockchain-Based:** Ensures the security and integrity of health data through blockchain technology.

2. **Solidity Backend:** The smart contracts and backend logic are implemented in Solidity.

3. **React Frontend:** The user interface is developed using the React library.

4. **Ganache Local Blockchain:** The app uses Ganache as a local blockchain for development and testing.

5. **MetaMask Extension:** Interaction with the blockchain is facilitated through the MetaMask browser extension.

## How to Run

Follow these steps to run the healthcare app:

1. Navigate to the client directory:

    ```bash
    cd client
    ```

2. Start the React frontend:

    ```bash
    npm start
    ```

3. Navigate back to the root directory:

    ```bash
    cd ..
    ```

4. Deploy the smart contracts:

    ```bash
    truffle migrate
    ```

    This will generate a `Contract.json` file in the `build` folder.

5. Copy the `Contract.json` file to the client directory.

6. Open your web browser and ensure that the MetaMask extension is installed.

7. Access the app through the React frontend running at [http://localhost:3000/](http://localhost:3000/).

## Important Note

Make sure that Ganache is running and MetaMask is configured to connect to your local blockchain.

