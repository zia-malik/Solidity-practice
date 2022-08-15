// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Temp {

    enum state{present,absent,leave,half_leave,in_meeting}

    struct employee{
        string name;
        state status;
    }

    mapping(uint=>employee) public employees;

    function add_employee(uint id,string memory _name, state _status) public {
        employees[id].name = _name;
        employees[id].status = _status;
    }

    function view_employee(uint id) view public returns(employee memory){
        return employees[id];
    }
    
}