pragma solidity 0.6.12; 
//sending money from one contract to another contract. here u deploy B; this will deploy contract A and call the pay function in contract B
contract A {
    function pay() payable public {
        
    }
    function getBalance() public view returns (uint) {
        return address(this).balance; 
    }
}

contract B {
    A public addressA = new A(); 
    function pay() payable public {
        addressA.pay{value: msg.value}(); 
       
    }
    function getBalance() public view returns (uint) {
        return address(this).balance; 
    }
}
