pragma solidity ^0.4.24;

import './SafeMath.sol';
import './IERC20.sol';

contract ERC20 is IERC20{
    using SafeMath for uint256;

    string public constant name = 'meme token';
    uint8 public constant decimals = 18;
    string public constant symbol = 'MET';

    uint256 private _totalSupply;
    mapping(address => uint) _balance;
    mapping(address => mapping(address=>uint256)) _approve; //授權的tokens

    // 所有存在的 Token 數量
    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }
    
    // 讀取 tokenOwner 這個 address 所持有的 Token 數量
    //address => uint
    function balanceOf(address tokenOwner) external view returns (uint256 balance){
        return _balance[tokenOwner];
    }
    
    // 從 msg.sender 轉 tokens 個 Token 給 to 這個 address
    function transfer(address to, uint256 tokens) external returns (bool success){
        return _transfer(msg.sender, to, tokens);
    }
    
    // 得到 tokenOwner 授權給 spender 使用的 Token 剩餘數量
    function allowance(address tokenOwner, address spender) external view returns (uint256 remaining){
        return _approve[tokenOwner][spender];
    }
    
    // msg.sender 授權給 spender 可使用自己的 tokens 個 Token
    //tokenOwner -> spender -> tokens
    //address => address => uint256
    function approve(address spender, uint256 tokens) external returns (bool success){
        _approve[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return (true);
    }

    // 將 tokens 個 Token 從 from 轉到合約再轉到 to
    function transferFrom(address from, address to, uint256 tokens) external returns (bool success){
        _approve[from][msg.sender] = _approve[from][msg.sender].sub(tokens);
        return _transfer(from, to, tokens);
    }

    function _transfer(address from, address to, uint256 tokens) internal returns (bool success){
        _balance[from] = _balance[from].sub(tokens);
        _balance[to] = _balance[to].add(tokens);
        emit Transfer(from, to, tokens);
        return (true);
    }
}