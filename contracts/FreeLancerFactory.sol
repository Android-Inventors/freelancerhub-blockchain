// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./FreeLancer.sol";

contract FreelancerFactory {
    mapping(string => address) public freelancerContracts; // Mapping from ID to contract address
    address[] public allFreelancers;

    event FreelancerRegistered(
        string indexed freelancerId,
        address freelancerContract
    );

    function registerFreelancer(
        string memory _id, // Freelancer ID from frontend
        string memory _name,
        string memory _skills,
        uint256 _experienceYears
    ) public {
        require(
            freelancerContracts[_id] == address(0),
            "Freelancer already registered with this ID"
        );

        // Deploy a new Freelancer contract
        Freelancer freelancer = new Freelancer(
            msg.sender,
            _name,
            _skills,
            _experienceYears
        );

        freelancerContracts[_id] = address(freelancer);
        allFreelancers.push(address(freelancer));

        emit FreelancerRegistered(_id, address(freelancer));
    }

    function getAllFreelancers() public view returns (address[] memory) {
        return allFreelancers;
    }

    function getFreelancerContract(
        string memory _id
    ) public view returns (address) {
        return freelancerContracts[_id];
    }
}
