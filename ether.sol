// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherTransfer {
    address public owner;
    
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 amount
    );
    event Deposit(address indexed from, uint256 amount);
    event Withdrawal(address indexed to, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() payable {
    owner = msg.sender;
}

    // Accept ETH deposits
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // Send ETH to any address
    function sendEther(address payable _to, uint256 _amount)
        public payable
    {
        require(_to != address(0), "Invalid address");
        require(
            address(this).balance >= _amount,
            "Insufficient balance"
        );
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Transfer failed");
        emit Transfer(address(this), _to, _amount);
    }

    // Deposit ETH into contract
    function deposit() public payable {
        require(msg.value > 0, "Send some SCAI");
        emit Deposit(msg.sender, msg.value);
    }

    // Owner withdraws all ETH
    function withdraw() public onlyOwner {
        uint256 bal = address(this).balance;
        require(bal > 0, "Nothing to withdraw");
        (bool success, ) = owner.call{value: bal}("");
        require(success, "Withdrawal failed");
        emit Withdrawal(owner, bal);
    }

    // Check contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
