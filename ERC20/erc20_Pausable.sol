pragma solidity ^0.4.24;

contract pausable{
    bool private _paused;
    address private owner;

    constructor() public {
        _paused = false; //初始合約非暫停,要暫停變成true
        owner = msg.sender;
    }

    modifier whenPaused(){
        require(msg.sender == owner);
        require(_paused);
        _;
    }

    modifier whenNotPaused(){
        require(msg.sender == owner);
        require(!_paused);
        _;
    }

    event Pause(address addr);
    event Unpause(address addr);

    function pasue() public whenPaused returns(bool){
        _paused = false;
        emit Unpause(msg.sender);
        return true;
    }

    function unpause() public whenNotPaused returns(bool){
        _paused = true;
        emit Pause(msg.sender);
        return true;
    }

}