p//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 


contract Ucoin {
    string public name = 'Ucoin';
    string public symbol = 'USDU'; 
    uint256 public totalSupply = 1000000000000000000000000; // 1 million tokens
    uint8 public decimals = 18; 
    address public minter;
 

    event Tfer(
        address indexed _from, 
        address indexed _to, 
        uint256 _value
    ); 

    event Apv(
        address indexed _owner, 
        address indexed _spender, 
        uint256 _value 
    ); 

pragma solidity >= 0.7.0 < 0.9.0; 

contract Test{
    mapping(address=>uint) public checktime; 
    mapping(address=>mapping(address=>uint)) public Dcheck; 
    address public _from; 
    uint public c;
    uint public d; 
    
    
   constructor(){
       _from = msg.sender; 
   }
   
    modifier onlyOwner() {
        require(msg.sender == _from, 'in not owner'); 
        _;
    }
    
    function UpdateTime() public onlyOwner returns (bool success){
         checktime[_from] = block.timestamp; 
         Dcheck[msg.sender][_from]= block.timestamp;
         return true;
    }
   
    function Check(uint a, uint b)public  onlyOwner returns(uint){
        require(checktime[_from] > 0, 'you must first UpdateTime'); 
        require(block.timestamp > checktime[_from] + 20 seconds, 'command not ready'); 
        c = a + b; 
        return c; 
    }
    
    function Check4Two(uint a, uint b,address _from)public  onlyOwner returns(uint){
        require(Dcheck[_from][msg.sender] > 0, 'you must first UpdateTime'); 
        require(block.timestamp > Dcheck[_from][msg.sender] + 20 seconds, 'command not ready'); 
        d = a + b; 
        return d; 
    }
}

