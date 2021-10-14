pragma solidity 0.5.6;

contract SelfDestruct {
    int public a;
    address payable public owner;
    bool public destructed;
    
    function setA() public payable {
        require(destructed != false, "Contract has been destroyed");
        a=20;
        owner = msg.sender;
    }
    function implode() public {
        require(destructed != false);
        require(owner == msg.sender);
        destructed = true;
        // selfdestruct(owner);
    }
    function () payable external {
        msg.sender.transfer(msg.value);
    }
}

