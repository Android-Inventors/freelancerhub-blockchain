// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Freelancer {
    address public owner; // Freelancer's MetaMask address
    string public name;
    string public skills;
    uint256 public experienceYears;
    uint256 public balance; // Balance of freelancer (ETH stored)

    event FundsDeposited(address indexed client, uint256 amount);
    event FundsWithdrawn(address indexed freelancer, uint256 amount);
    event DetailsUpdated(string name, string skills, uint256 experienceYears);

    constructor(
        address _owner,
        string memory _name,
        string memory _skills,
        uint256 _experienceYears
    ) {
        owner = _owner;
        name = _name;
        skills = _skills;
        experienceYears = _experienceYears;
    }

    // Deposit ETH to the freelancer contract
    function deposit() public payable {
        require(msg.value > 0, "Must send some ETH");
        balance += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    receive() external payable {
        require(msg.value > 0, "Must send some ETH");
        balance += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    fallback() external payable {
        require(msg.value > 0, "Must send some ETH");
        balance += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    // Withdraw ETH from the contract
    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only the freelancer can withdraw");
        require(amount <= balance, "Insufficient balance");

        balance -= amount;
        payable(owner).transfer(amount);

        emit FundsWithdrawn(msg.sender, amount);
    }

    // Update freelancer details (only owner can update)
    function updateDetails(
        string memory _name,
        string memory _skills,
        uint256 _experienceYears
    ) public {
        require(msg.sender == owner, "Only the freelancer can update details");

        name = _name;
        skills = _skills;
        experienceYears = _experienceYears;

        emit DetailsUpdated(_name, _skills, _experienceYears);
    }

    // Get contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
