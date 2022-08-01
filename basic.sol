pragma solidity ^0.4.24;

contract basic{

    address public owner;
    uint public integer_1;

    constructor(){
        owner = msg.sender;
        integer_1 = 0;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    function Add_check_Sender(uint x)public onlyOwner{
        integer_1 += x;
    }
}

