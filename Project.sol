// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChemistrySimulationGame {
    string public name = "Chemistry Simulation Token";
    string public symbol = "CST";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    address public owner;
    
    // Mapping from address to balance
    mapping(address => uint256) public balanceOf;
    
    // Events for transfers and minting
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    
    constructor(uint256 initialSupply) {
        owner = msg.sender;
        totalSupply = initialSupply * 10 ** uint256(decimals);
        balanceOf[owner] = totalSupply;
    }
    
    // Transfer function to send tokens to others
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(recipient != address(0), "Recipient address cannot be the zero address");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        
        emit Transfer(msg.sender, recipient, amount);
        
        return true;
    }

    // Function to mint new tokens
    function mint(uint256 amount) public onlyOwner {
        totalSupply += amount * 10 ** uint256(decimals);
        balanceOf[owner] += amount * 10 ** uint256(decimals);
        
        emit Mint(owner, amount);
    }

    // Modifier to restrict certain actions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
}
