pragma solidity ^0.4.24;

import 'IERC20.sol';


contract TokenExchange{
    //from => userA,TokenA
    address fromAddress;
    address fromToken; //A Token合約地址
    uint256 fromAmount; 
    //to => userB,TokenB
    address toToken;
    uint256 toAmount;

    //假設userA已經 Approve
    //Ａtoken幾個 換 Ｂtoken幾個
    function CreateExchange(address _fromToken, uint256 _fromAmount, address _toToken, uint256 _toAmount) public {
        // A tokens的合約地址所擁有的tokens 轉 Ａ個tokens(_fromAmount)到這裡來
        require(IERC20(_fromToken).transferFrom(msg.sender, this, _fromAmount)); //require為確認是否approve
        fromAddress = msg.sender;
        fromToken = _fromToken;
        fromAmount = _fromAmount;
        toToken = _toToken;
        toAmount = _toAmount;
    }

    function DoChange() public {
        require(IERC20(toToken).transferFrom(msg.sender, this, toAmount));
        IERC20(fromToken).transfer(msg.sender, fromAmount); //B拿Ａ 的token(fromToken)拿Ａ個(fromAmount)
        IERC20(toToken).transfer(fromAddress, toAmount); //Ａ拿Ｂ 的token(toToken)拿B個(toAmount)
    }
}