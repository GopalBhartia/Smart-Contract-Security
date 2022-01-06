The simple and traditional way of providing randomness to our smart contracts is by applying keccak256 to the block properties.
But these methods of providing randomness can be manipulated by the miners.

Please check the Lottery and LotteryAttacker smart contracts to understand the example.
The function below generates a random number using the block.timestamp:

function pseudoRandNumGen() private view returns (uint8) {
  return uint8(uint256(keccak256(abi.encode(block.timestamp))) % 254) + 1;
}

The miners has a time window of approx 15 secs between 2 blocks being mined. A malicious miner can include his own smart contract with a similar function as above in the same block to predict the generated random number as shown below:

function getWinningNumber() private view returns (uint8) {
  return uint8(uint256(keccak256(abi.encodePacked(block.timestamp))) % 254) +1;
}

After that, the miner just need to include his contract first in the block and get the winning number and use it to place a bit and win the lottery. This is called Replicated Logic Attack.

To have a fair source of randomness in our contracts, we can make use of Chainlink's VRF. To learn more about VRF follow the below link : 
  
https://docs.chain.link/docs/chainlink-vrf/

The LotteryV2 smart contract makes use of this VRF to provide a secure and safe randomness to the lottery to ensure fair results.
  
