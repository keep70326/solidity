pragma solidity ^0.4.24;

contract Donate{

    struct donorInfo{
        address[] donors;
        mapping (address => uint) ledger; //該名乾爹＝>已抖內該實況主多少
    }
    mapping (address => donorInfo) donationHistory;


    event logDonate(address streamer, address donor, string nickname, uint value, string message);

    function donate(address _streamer, string _nickname, string _message) public payable {
        require(msg.value > 0, '別想白嫖，要互動請抖內') ;
        _streamer.transfer(msg.value);

        if (donationHistory[_streamer].ledger[msg.sender] == 0){
            donationHistory[_streamer].donors.push(msg.sender);
        } 
        donationHistory[_streamer].ledger[msg.sender] += msg.value;

        emit logDonate(_streamer, msg.sender, _nickname, msg.value, _message);
    }
    
    //實況主呼叫方法查詢乾爹人數
    function getDonorList() public view returns(address[]){ 
        return (donationHistory[msg.sender].donors);
    }

    //實況主呼叫方法查詢各乾爹抖內多少
    event logListDonorInfo(address streamer, address donors, uint value);
    function listDonorInfo() public {
        for (uint i=0; i < donationHistory[msg.sender].donors.length; i++){
            address daddy = donationHistory[msg.sender].donors[i];
            emit logListDonorInfo(msg.sender, daddy, donationHistory[msg.sender].ledger[daddy]);
        }
    }
}