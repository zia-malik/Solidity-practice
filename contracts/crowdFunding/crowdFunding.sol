// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract crowdFunding {

    mapping(address=>uint) public contributers;
    string public currentCampaign;
    address public manager;
    uint public minimumContriution;
    uint public startingTime;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributers;

    constructor() {
        manager = msg.sender;
    }

    function startCampaign(string memory _campaignName, uint _target, uint _deadline, uint _minimumContribution) 
    external 
    {
        require(block.timestamp>deadline);
        require(_deadline>block.timestamp);
        require(_target!=0 && _deadline!=0);

        currentCampaign = _campaignName;
        minimumContriution = _minimumContribution;
        startingTime = block.timestamp;
        deadline = _deadline;
        target = _target;

    }

    function sendEth() external payable {
        require(deadline!=0);
        require(block.timestamp<deadline);
            
    }
}
