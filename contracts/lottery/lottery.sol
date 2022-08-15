// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract lottery {

    address public deployer; 
    address payable[] public participants;

    constructor(){
        deployer = msg.sender;
    }

    receive() external payable
    {
        require(msg.sender != deployer);
        require(msg.value == 2 ether);
        participants.push(payable(msg.sender));
    }

    function winning() external view returns(uint balance){
        return uint((participants.length-1)*2);
    }

    function total_partipants() external view returns(uint){
        return participants.length;
    }

    function draw() external {
        require(msg.sender == deployer);
        require(participants.length>3);

        uint index = random() % participants.length;
        participants[index].transfer(uint((participants.length-1)*2)*1000000000000000000);
        participants = new address payable[](0);
        //delete participants;
    }

    function random() internal view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, participants.length)));
    }

}