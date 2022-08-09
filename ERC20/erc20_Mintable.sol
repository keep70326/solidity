pragma solidity ^0.4.24;

import './erc20.sol';

contract mintable is erc20{

    address private owner;
    mapping (address => bool) minters ; //誰可以挖幣

    constructor() public{
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    function addMinter(address addr) public onlyOwner returns(bool){
        minters[addr] = true;
        return (true);
    }

    modifier onlyMinter(){
        require(minters[msg.sender]);
        _;
    }

    function mint(address to , uint256 tokens) public onlyMinter returns(bool) {

        //增加total suplly
        _totalSuplly = _totalSuplly.add(tokens);
        //轉移新增出來的tokens到某人身上
        _blance[to] =  _blance[to].add(tokens);
        emit Transfer(address(0), to, tokens); //address(0)表示從無到有，挖到的
        return(true);
    }
}
