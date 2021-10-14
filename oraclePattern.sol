pragma solidity ^0.6.12;
import "https://github.com/provable-things/ethereum-api/blob/master/provableAPI_0.6.sol";

contract ExampleContract is usingProvable {

   string public ETHUSD;
   event LogConstructorInitiated(string nextStep);
   event LogPriceUpdated(string price);
   event LogNewProvableQuery(string description);

   function Constructor() payable public {
       emit LogConstructorInitiated("Constructor was initiated. Call 'updatePrice()' to send the Provable Query.");
   }

   function __callback(bytes32 myid, string memory result) override public {
       if (msg.sender != provable_cbAddress()) revert();
       ETHUSD = result;
       emit LogPriceUpdated(result);
   }

   function updatePrice() payable public {
       if (provable_getPrice("URL") > address(this).balance) {
           emit LogNewProvableQuery("Provable query was NOT sent, please add some ETH to cover for the query fee");
       } else {
           emit LogNewProvableQuery("Provable query was sent, standing by for the answer..");
           provable_query("URL", "json(https://api.pro.coinbase.com/products/ETH-USD/ticker).price");
       }
   }
}
//this can only be run in test network (injected web3)
