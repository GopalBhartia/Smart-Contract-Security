// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/ReentrancyGuard.sol";

/*  
    The following contract has a reentrancy bug but with send() function, 
    we can only send 2300 gas which is not enough to perform any further operations.
    therefore the issue is not very serious here, but in contract Fund2 its serious.
*/

contract Fund1 {
    mapping(address => uint256) shares;

    function withdraw() public {
        if (payable(msg.sender).send(shares[msg.sender]))
            shares[msg.sender] = 0;
    }
}

/*  
    The following contract has a serious reentrancy bug because it uses call() which passes the entire remaining gas amount further.
    If msg.sender is a attacker contract, it can exploit this reentrancy  bug to withdraw the entire balance.
    To prevent this, we can follow Checks-Effects-Interactions pattern in our contract as shown in contract - Fund3. 
*/
contract Fund2 {
    mapping(address => uint256) shares;

    function withdraw() public {
        (bool success, ) = msg.sender.call{value: shares[msg.sender]}("");
        if (success) shares[msg.sender] = 0;
    }
}

/*  
    The following contract follows the Checks-Effects-Interactions pattern and thus it can prevent reentrancy attacks.
    There is one more way to prevent this attack, by using OpenZeppelin's ReentrancyGuard as shown in contract - Fund4.
*/
contract Fund3 {
    mapping(address => uint256) shares;

    function withdraw() public {
        uint256 share = shares[msg.sender];
        shares[msg.sender] = 0;
        payable(msg.sender).transfer(share);
    }
}

/*  
    The following contract implements the ReentrancyGuard and its nonReentrant modifier and thus it can prevent reentrancy attacks.
*/
contract Fund4 is ReentrancyGuard {
    mapping(address => uint256) shares;

    function withdraw() public nonReentrant {
        uint256 share = shares[msg.sender];
        shares[msg.sender] = 0;
        payable(msg.sender).transfer(share);
    }
}
