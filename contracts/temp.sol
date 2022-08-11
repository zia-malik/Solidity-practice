// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Temp {

    string private name = "zia";
    uint private age = 23;

    constructor() public {
    }

    function setname(string memory n) public {
        name = n;
    }
    function setage(uint a) public {
        age = a;
    }
}