
This repo demonstrates a simple smart contract vulnerability that occurs when someone tries to store values in a variable which exceeds its limit. In such cases overflow and underflow happens.

For example : 
    
    uint8 a = 255;  // This is the maximum number that a uint8 can store.
    a++;  // This results in overflow and the value of a becomes 0.
    
    uint8 b = 0;   // This is the minimum number that a uint8 can store.
    b--;  // This results in underflow and the value of a becomes 255.

This issue has been fixed in solidity versions >= 0.8.0 , but in older versions, we can make use of OpenZeppelin's SafeMath library to make sure that overflow and underflow issues does not occur in our smart contract.

This repo contains two solidity smart contracts, one which has the overflow bugs and other which uses OpenZeppelin's SafeMath library to solve these bugs.

----------MAKE SURE TO USE OPENZEPPELIN'S SAFEMATH LIBRARY IN THE SMART CONTRACT WITH VERSIONS < 0.8.0 FOR ARITHEMATIC OPERATIONS----------
