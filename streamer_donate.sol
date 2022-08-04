pragma solidity ^0.4.24;

contract Donation{

    event logDonate(address streamer, address donor, string nickname, uint value, string message);

    function donate(address _streamer, string _nickname, string _message) public payable{
        _streamer.transfer(msg.value);
        emit logDonate(_streamer, msg.sender, _nickname, msg.value, _message);
    }
}