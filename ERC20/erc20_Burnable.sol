pragma solidity ^0.4.24;

import './erc20.sol';

contract burnable is erc20{

    event Burn(address account, uint256 tokens);

    function burn(uint256 tokens) public returns(bool){
        // 檢查夠不夠燒
        require(tokens <= _blance[msg.sender]);

        //減少total suplly
        _totalSuplly = _totalSuplly.sub(tokens);

        //減少msg.sender blance
        _balance[msg.sender] = _blance[msg.sender].sub(tokens);

        emit Burn(msg.sender, tokens);
        emit Transfer(msg.sender, address(0), tokens);//從自己回歸虛無
        return true;

    }
}
