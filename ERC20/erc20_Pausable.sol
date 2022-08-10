pragma solidity ^0.4.24;

contract pausable{
    bool private _pausable;

    constructor() public {
        _pausable = false;
    }

    modifier whenPaused(){
        require(_paused);
        _;
    }

    modifier whenNotPaused(){
        require(!_paused);
        _;
    }

    event Pause(address addr);
    event Unpause(address addr);

    function pasue() public whenPaused returns(bool){
        _pausable = false;
        emit Unpause(msg.sender);
        return true;
    }

    function unpause() public whenNotPaused returns(bool){
        _pausable = true;
        emit Pause(msg.sender);
        return true;
    }

}