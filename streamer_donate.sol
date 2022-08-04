pragma solidity ^0.4.24;

contract donate{

    struct donorInfo{
        address[] donors;
        mapping (address => uint) ledger //乾爹 ＝> 已經抖內多少錢
    }
    mapping (address => donorInfo) donationHistory;// 實況主地址＝> 抖內訊息

    event logDonate(address streamer, address donor, string nickname, uint value, string message);

    function donate(address _streamer,string _nickname, string _message) public payable {
        _streamer.transfer(msg.value);
        
        donationHistory[_streamer].ledger[msg.sender] += msg.value;
        donationHistory[_streamer].donors.push(msg.sender);

        emit logDonate(_streamer, msg.sender, _nickname, msg.value, _message);
    }

    function getDonateList() public view returns(address[]){

    }

    function listDonorInfo() public {

    }
}