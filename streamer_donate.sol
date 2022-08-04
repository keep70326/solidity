pragma solidity ^0.4.24;

contract Donation{

    event logDonate(address streamer, address donor, string nickname, uint value, string message);

    function donate(address streamer, string nickname, string message) public payable{
        streamer.transfer(msg.value);
        emit logDonate(streamer, msg.sender, nickname, msg.value, message);
    }
}