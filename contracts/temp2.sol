// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Temp2{

    struct employee{

        string name;
        string department;
        uint age;
    }
    mapping(uint=>employee) public employees;
    function setter(uint _id,string memory _name, string memory _department, uint _age) public
    {
        employees[_id]= employee(_name, _department, _age); 
    }

    function demo() public view returns(uint block_no, uint timestamp, address deployer)
    {
        return(block.number, block.timestamp, msg.sender);
    }

    // function viewemploee(uint _roll) public view returns(employee memory)
    // {
    //     return employees[_roll];
    // }
}