pragma solidity ^0.4.24;

contract donate{

    struct donorInfo{
        address[] donors;
        mapping (address => uint) ledger //乾爹 ＝> 已經抖內多少錢
    }
    mapping (address => donorInfo) donationHistory;// 實況主地址＝> 抖內訊息

    event logDonate(address streamer, address donor, string nickname, uint value, string message);

    function donate(address _streamer,string _nickname, string _message) public payable {
        require(msg.value > 0);
        streamer.transfer(msg.value);
        
        if (donationHistory[_streamer].ledger[msg.sender] == 0){
            donationHistory[_streamer].donors.push(msg.sender);
        }
        donationHistory[_streamer].ledger[msg.sender] += msg.value; //ledger[msg.sender是抖內多少錢
        
        emit logDonate(_streamer, msg.sender, _nickname, msg.value, _message);
    }

    function getDonateList() public view returns(address[]){
        return (donationHistory[_streamer].donors);
    }

    event logListDonorInfo()

    function listDonorInfo() public {

    }
}