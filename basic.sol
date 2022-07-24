pragma solidity ^0.4.24;

contract class30{

    address public owner;
    uint public integer_1;

    constructor() public{
    owner = msg.sender;
    integer_1 = 0;
    }

    modifier onlyOwner{
        require(msg.sender != owner);
        _;
    }

    function Add_check_Sender(uint x)public onlyOwner{
        integer_1 += x;
    }
}