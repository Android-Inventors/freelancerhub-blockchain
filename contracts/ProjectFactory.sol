// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "./ProjectEscrow.sol";

contract ProjectFactory {
    event ProjectCreated(
        string indexed projectId,
        address projectAddress,
        address client,
        address freelancer
    );

    struct Project {
        address projectAddress;
        address client;
        address freelancer;
    }

    mapping(string => Project) public projects;

    function createProject(
        string memory _projectId,
        address _freelancer
    ) public {
        require(
            projects[_projectId].projectAddress == address(0),
            "Project ID already exists"
        );

        // Deploy a new ProjectEscrow contract
        ProjectEscrow newProject = new ProjectEscrow(msg.sender, _freelancer);
        projects[_projectId] = Project(
            address(newProject),
            msg.sender,
            _freelancer
        );

        emit ProjectCreated(
            _projectId,
            address(newProject),
            msg.sender,
            _freelancer
        );
    }

    function getProject(
        string memory _projectId
    ) public view returns (Project memory) {
        require(
            projects[_projectId].projectAddress != address(0),
            "Project not found"
        );
        return projects[_projectId];
    }
}
