
pragma solidity ^0.6.12; 

//We are going to be able to input our metaMask address, and count thur a period of time to where we can lock the contract (lock the liquidity). we would 
//then be able to withdraw from the liquidity after the lock time has elasped. All these can be view live on etherscan.

contract lock {
    constructor (address owner, uint256 unlockTime) public payable {
        assembly {
            sstore(0x0, owner)
            sstore(0x1, unlockTime)
        }
    }
    
    fallback () external payable{
        assembly {
            switch gt(timestamp(), sload(0x1))
                case 0 {revert(0,0)}
                    case 1 {
                        switch call(gas(), sload(0x0), balance(address()), 0, 0, 0, 0)
                case 0 {revert(0,0)}
                
            }
            
        }
    }
}
