//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.6/contracts/access/Ownable.sol";

contract SimpleToken is Ownable {
    mapping(address => uint256) public balanceOf;
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) public {
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;
    }

    function transfer(address _to, uint256 _amount) public {
        require(balanceOf[msg.sender] - _amount >= 0, "Not enough tokens");
        balanceOf[msg.sender] = balanceOf[msg.sender] - _amount;
        balanceOf[_to] = balanceOf[_to] + _amount;
    }

    function mint(uint256 amount) external {
        totalSupply = totalSupply + amount;
        balanceOf[owner()] = balanceOf[owner()] + amount;
    }
}
