// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

//ERC Token Standard #20 Interface
interface ERC20Interface{
    function totalSupply() external view returns (uint);
    function balanceOf(address tokenOwner) external view returns (uint balance);
    function allowance(address tokenOwner, address spender) external view returns (uint remaining);

    function transfer(address to, uint tokens) external returns (bool success);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);
 
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
 
//Actual token contract 
contract MEMEToken is ERC20Interface{
    string public symbol = "MEME" ;
    string public  name = "MEME Coin";
    uint8 public decimals = 2;
    uint256 public _totalSupply;
 
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
 
    constructor() {
        _totalSupply = 100000;
        balances[0xa3B2594cC271eDbe14Cec103F06e423e93296858] = _totalSupply;
        emit Transfer(address(0), 0xa3B2594cC271eDbe14Cec103F06e423e93296858, _totalSupply);
    }
 
    function totalSupply() public override view returns (uint256) {
        return _totalSupply;
    }
 
    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }
 
    function transfer(address to, uint tokens) public override returns (bool success) {
        require(tokens <= balances[msg.sender]);

        balances[msg.sender] = balances[msg.sender] - tokens;
        balances[to] = balances[to] + tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }
 
    function approve(address spender, uint256 tokens) public override returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender) public override view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    function transferFrom(address from, address to, uint256 tokens) public override returns (bool success) {
        require(tokens <= balances[msg.sender]);
        require(tokens <= allowed[from][msg.sender]);

        balances[from] = balances[from] - tokens;
        allowed[from][msg.sender] = allowed[from][msg.sender] - tokens;
        balances[to] = balances[to] + tokens;
        emit Transfer(from, to, tokens);
        return true;
    }
} 