pragma solidity >= 0.7.0 < 0.9.0; 

contract Coin {
    address public minter; 
    mapping(address=>uint) public balances; 
    
    event Sent(address from, address to, uint amount); 
    error insufficentFunds( uint requested, uint avaiable); 
    
    constructor() public {
        minter = msg.sender; 
    }
    
    function mint(address receiver, uint amount) public {
        if (minter == msg.sender) {
            balances[receiver] += amount; 
        }
    }
    
    function send(address receiver, uint amount) public {
        if (balances[msg.sender] < amount) {
            revert insufficentFunds({
                requested: amount, 
                avaiable: balances[msg.sender]
            }); 
        }
        
        balances[msg.sender] -= amount;
        balances[receiver] += amount; 
        emit Sent(msg.sender, receiver, amount); 
    }
    
    function getR(address AccHolder) public view returns(uint){
        return balances[AccHolder]; 
    }
      
}
