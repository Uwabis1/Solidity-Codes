pragma solidity 0.6.12;

contract Richest {
    address payable richest;
    uint mostSent;
    mapping(address => uint) public investors;
    constructor () public payable {
        richest = msg.sender; //why i am doing this directly? so that when the contract is deployed, i (as the first person) would be d rishest
        mostSent = msg.value;
        richest.transfer(msg.value); //this returns the money back to the person. i dont want to store the money in the contract, just want to make sure they are the rishest. 
    }
    function invest() payable public {
        require(msg.value > mostSent,"Not enough money to become richest");
        richest = msg.sender;
        mostSent = msg.value;
        // richest.transfer(msg.value); - dont transfer within the function itself.
        investors[msg.sender] = msg.value;
    }
    function withdraw() public {
        uint amount = investors[msg.sender];
        investors[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
}
contract B {
    fallback () payable external {
        revert();
    }
}

