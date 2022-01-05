# Basic Sample Hardhat Project

This project demonstrates a simple smart contract vulnerability that occurs when someone stores sensitive data on private variables such as passwords and private keys thinking that they are secured and no one will be able to see them. But in reality, nothing is private on the blockchain. The visibility of private variables apply to other smart contracts only. The private variables can be retrieved easily from the storage and exploited.

This project has a vault smart contract that stores password as a private variable. It also has a test script that clearly shows that an attacker can easily retrieve the password from the storage and withdraw all the funds.

----------MAKE SURE TO NEVER STORE SENSITIVE INFORMATIONS IN THE SMART CONTRACT----------