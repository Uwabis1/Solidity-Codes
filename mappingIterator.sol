pragma solidity 0.6.12;

contract Mapping {
    mapping(address => uint8) public feedback;
    
    address[] public addresses; //By declaring an arrray of the keys helps you loop through the addresses
    
    function giveFeedback(uint8 _feedback) public {
        feedback[msg.sender] = _feedback;
        addresses.push(msg.sender);
    }
    
    function count() public view returns(uint) {
        return addresses.length;
    }
    
    function returnAddresses() public view returns(address[] memory ) {
        return addresses;
    }
}

