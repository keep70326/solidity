pragma solidity ^0.4.24;

contract test{
    mapping(address => uint) public ledger;
    mapping(address => bool) public donors;
    address[] public donorlist;
    
    function isDonor(address pAddr) internal view returns(bool){
        return donors[pAddr];
    }

    function donate() public payable{
        if (msg.value >= 1 ether){
            if(!isDonor(msg.sender)){
                donors[msg.sender] = true;
                donorlist.push(msg.sender);
            }
            ledger[msg.sender] += msg.value;
        }else{
            revert('請捐款至少1eth');
        }
    }
}