# Advanced Sample Hardhat Project

A DoS(Denial of Service) attack is a security threat that occurs when an attacker makes it impossible for legitimate users to access a system.

In Blockchain, there are three types of known DoS attacks:

1) Unexpected Revert : When access to a function is blocked by forcing it to revert. For example, if we try to send ethers to a contract
                       that does not have a fallback function, the transaction will be reverted back always.

2) Block Gas Limit : When an attacker floods the execution of a function such that it hits the gas limit of the block. It can happen
                     both intentionally by an attacker and unintentionally.

3) Block Stuffing : When an attacker stuffs a consecutive number of blocks with his/her transactions by paying a very high gas fees 
                    to ensure that their transactions will be mined prior to anyone else's. These types of attacks is typically aimed
                    at contracts that are time dependent and the attacker can benefit by blocking the victim's transactions for a short
                    period of time. 

In this project, Block Gas Limit case is demonstrated in the Auction.sol contract. In hardhat, the gas limit for a block is 30,000,000 by default. If a function consumes more that this gas limit, the fuction will never run successfully.

function refundAll() external onlyOwner nonReentrant {
        for (uint256 i; i < refunds.length; i++) {
            refunds[i].addr.sendValue(refunds[i].amount);
        }
        delete refunds;
    }

In the above refundAll() function, we the length of refunds array is too large such that the execution exceeds the gas limit of a block, the transaction will be reverted back and all the funds will be trapped in the contract forever. This can be done intentionally by an attacker by placing thousands of bids with small differences. It sometimes also happens unintentionally, like in case the Auction contract becomes so much popular that it receives thousands of bids. In such cases also, the funds will be trapped forever unintentionally.

Take a look at AuctionV2.sol for solution to above security vulnerability. Such short comings can be solved by using PULL OVER PUSH technique. In this technique, instead of pushing the funds back to users, a withdraw() function is provided to all the users to manually withdraw their funds by paying some gas fees to ensure the secuity of their funds.