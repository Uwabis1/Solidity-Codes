pragma solidity 0.6.12;
// factory patterns helps you always have records of the contracts that have been deployed from a parent contract. so that you dont lose 
// the tracability of any of the sub contracts. e.g; you can always retrive them from the carsManufactured, in the below psuedo case. 

contract Toyota {
    Car[] public carsManufactured;
    function manufacture() public {
        carsManufactured.push(new Car());
    }
}

contract Car {
    
}

