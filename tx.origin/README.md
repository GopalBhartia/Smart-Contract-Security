# Basic Sample Hardhat Project

This project demonstrates a how an attacker can exploit the tx.origin and drain out the victim's balances.

The SmallWallet contract has used tx.origin to set the owner of the contract. It also uses tx.origin to check for authorizations.

contract SmallWallet {
    address public owner;

    constructor() {
        owner = tx.origin;
    }

    function withdrawAll(address _recipient) external {
        require(tx.origin == owner, "Caller not authorized");
        payable(_recipient).transfer(address(this).balance);
    }

    receive() external payable {}
}

We also have a Attacker contract which has a receive() function. The attacker wants to manipulate the SmallWallet owner in such a way that
the SmallWallet owner sends some ethers to the Attacker contract. The attacker has set up the receive function in such a way that it can exploit the tx.origin and drain out all the balance of SmallWallet owner as shown below:

receive() external payable {
        smallWallet.withdrawAll(owner());
    }

To prevent such exploitations, use msg.sender instead of tx.origin in our smart contracts.

---------------------- NEVER USE tx.origin AS THE OWNER OF A CONTRACT AND FOR AUTHORIZATIONS CHECK --------------------------



