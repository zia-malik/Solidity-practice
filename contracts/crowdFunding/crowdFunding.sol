// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract CrowdFunding {

    address payable[] contributersAddresses;
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
        require(msg.sender!=manager, "As a manager you can not contribute in the campaign.");
        require(deadline!=0, "There is no active campaign at the moment.");
        require(block.timestamp<deadline, "Deadline is over.");
        require(msg.value>=minimumContriution, "minimum contribution is not met.");

        if(contributers[msg.sender]==0)
        {
            noOfContributers+=1;
        }
        contributers[msg.sender]+=msg.value;
        contributersAddresses.push(payable(msg.sender));
        raisedAmount += msg.value;
    }

    function getContractBalance() external view returns(uint)
    {
        return address(this).balance;
    }

    function refund() external
    {
        require(raisedAmount==0, "No funds available.");
        require(noOfContributers<=5, "Number of contributors are greater then 3.");
        require(msg.sender == manager || contributers[msg.sender]!=0 , "You are not authorized to call this function.");
        require(deadline!=0, "There is no active campaign.");
        require(deadline<block.timestamp, "You can'nt refund before the deadline.");

        if(msg.sender==manager)
        {
            for(uint i=0; i<contributersAddresses.length; i++)
            {
                contributersAddresses[i].transfer(contributers[contributersAddresses[i]]);
                contributers[contributersAddresses[i]] = 0;
            }
            delete contributersAddresses;
            raisedAmount = 0;
            noOfContributers = 0;
        }
        else
        {
            payable(msg.sender).transfer(contributers[msg.sender]);
            for(uint i=0; i<contributersAddresses.length; i++)
            {
                if(contributersAddresses[i] == msg.sender)
                {
                    contributersAddresses[i] = contributersAddresses[contributersAddresses.length - 1];
                    contributersAddresses.pop();
                }
            }
            raisedAmount-=contributers[msg.sender];
            contributers[msg.sender] = 0;
            noOfContributers-=1;
        }
    }

    function stopCampaign() external
    {
        require(msg.sender==manager, "You are not authorized to call this funtion.");
        require(deadline!=0, "There is no active campaign.");
        require(contributersAddresses.length==0, "There are still some contributers in the campaign.");

        delete currentCampaign;
        deadline = 0;
        minimumContriution = 0;
        startingTime = 0;
        target = 0; 
    }

    function timeleft() external view returns(uint)
    {
            uint timeLeft;
        if(block.timestamp>deadline)
        timeLeft=0;
        else
        timeLeft = deadline - block.timestamp;
        return timeLeft;
    }
}
