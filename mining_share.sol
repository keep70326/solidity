pragma solidity ^0.4.24;

//挖礦合資：
//招募者：owner，負責拉人、找錢、把人加進來或是踢除的權力
//設定招募時間，記錄投資人增資減資

//投資者：share holders，負責投資和領錢
//查詢投資金額、查詢提領金額、查詢目前收益、出金

import './SafeMath.sol';

contract MiningShare{
    using SafeMath for uint;
    //召集人
    address private owner = 0x0;
    //召集人設定募資時間
    uint private closeBlock = 0;
    //投資者：投資金額、提領金額
    mapping(address => uint) private usersNTD;
    mapping(address => uint) private userWithdraw;
    //參數：總投資金額、被提領總金額
    uint private totalNTD = 0;
    uint private totalWithdraw = 0;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    modifier onlyShareHolders(){
        require(usersNTD[msg.sender] != 0);
        _;
    }

    // 在募資結束之前
    modifier beforeCloseBlock(){
        require(block.number <= closeBlock); 
        _;
    }

    //募資結束後
    modifier afterCloseBlock(){
        require(block.number > closeBlock);
        _;
    }
    
    //召集人功能
    constructor() public {
        owner = msg.sender;
        closeBlock = block.number.add(2000);
    }

    //募資結束前可以增資
    function CapitalIncrease(address account, uint NTD) public onlyOwner beforeCloseBlock{
        usersNTD[account] = usersNTD[account].add(NTD);
        totalNTD = totalNTD.add(NTD);
    }

    //募資結束前可以減資
    function CapitalDecrease(address account, uint NTD) public onlyOwner beforeCloseBlock{
        usersNTD[account] = usersNTD[account].sub(NTD);
        totalNTD = totalNTD.sub(NTD);
    }

    //募資結束後，可查詢自己(投資者)投資金額
    function MyTotalNTD() public constant onlyShareHolders returns(uint){
        return usersNTD[msg.sender];
    }

    //募資結束後，可查詢自己(投資者)提款金額
    function MyToyalWithdraw() public constant onlyShareHolders afterCloseBlock returns(uint){
        return userWithdraw[msg.sender];
    }

    //募資結束後，可查詢總挖礦收益 
    function TotalMined() public constant onlyShareHolders afterCloseBlock returns(uint){
        return totalWithdraw.add(address(this).balance);//總挖礦收益 = 全部被提領金額＋擁有多少錢
    }

    //募資結束後，可出金
    function Withdraw() public onlyShareHolders afterCloseBlock {
        uint totalMined = totalWithdraw.add(address(this).balance);//挖礦總收益
        //還有多少可領 = 挖礦總收益 *（投資金額 / 總投資金額）- 已經領多少
        uint userCanWithdraw = totalMined.mul(usersNTD[msg.sender].div(totalNTD)).sub(userWithdraw[msg.sender]);
        userWithdraw[msg.sender].add(userCanWithdraw); //總提款金額 ＝ 本金＋還有多少可領
        totalWithdraw.add(userCanWithdraw); //被提款總金額 = 被提款金額＋這次提款金額
        msg.sender.transfer(userCanWithdraw);
    }
}