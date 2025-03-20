// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ProjectEscrow contract manages payments between a client and a freelancer
contract ProjectEscrow {
    address public client;
    address public freelancer;
    uint256 public contractBalance;
    bool public workCompleted;

    event FundsDeposited(address indexed client, uint256 amount);
    event WorkMarkedCompleted(address indexed freelancer);
    event PaymentReleased(address indexed freelancer, uint256 amount);

    modifier onlyClient() {
        require(msg.sender == client, "Only client can call this");
        _;
    }

    modifier onlyFreelancer() {
        require(msg.sender == freelancer, "Only freelancer can call this");
        _;
    }

    constructor(address _client, address _freelancer) {
        client = _client;
        freelancer = _freelancer;
    }

    // Client deposits funds into the contract
    function deposit() public payable onlyClient {
        require(msg.value > 0, "Must send ETH");
        contractBalance += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    receive() external payable {
        require(msg.value > 0, "Must send ETH");
        contractBalance += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    fallback() external payable {
        require(msg.value > 0, "Must send ETH");
        contractBalance += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    // Freelancer marks work as completed
    function markWorkCompleted() public onlyFreelancer {
        workCompleted = true;
        emit WorkMarkedCompleted(msg.sender);
    }

    // Client releases payment to freelancer
    function releasePayment() public onlyClient {
        require(workCompleted, "Work not marked as completed");
        require(contractBalance > 0, "No funds available");

        uint256 amount = contractBalance;
        contractBalance = 0;

        payable(freelancer).transfer(amount);
        emit PaymentReleased(freelancer, amount);
    }

    // Get contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
