pragma solidity 0.6.12;

//so when you run this, msg.sender will show the address of contract B, meaning that contract B called the function
//while tx.origin will show the callers externally owned address, which is the address of the person calling the function/ origin of the transaction


contract A {
    address public msgSender;
    address public txOrigin;
    function getdetails()  public {
        msgSender = msg.sender; //this will show who/what is the msg.sender
        txOrigin = tx.origin; //this will similarly show  tx.origin
    }
}

contract B {
    A public addressA = new A();
    constructor() public {
        addressA.getdetails();
    }
}

