// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Vault is Ownable {
    bytes32 private pass;

    constructor(bytes32 _pass) {
        pass = _pass;
    }

    modifier checkPass(bytes32 _pass) {
        require(
            pass == _pass,
            "Invalid Password!! Please check your credentials..."
        );
        _;
    }

    function deposit() external payable onlyOwner {}

    function withdraw(bytes32 _pass) external checkPass(_pass) {
        payable(msg.sender).transfer(address(this).balance);
    }
}
