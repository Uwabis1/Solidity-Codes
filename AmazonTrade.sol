pragma solidity 0.6.12;

/* Idea: 
A contract that allows sellers register products by entering details of the product.

Buyers can buy product using the id of the product. 

Once delivery of product is confirmed by the buyer, the the money is transfered to seller. 
*/


contract Amazon {
    uint public counter = 1;
    bool public destroyed = false; //using a bool to know if a contract has been destroyed is a better way to do this. 
    struct Product {
        uint productId;
        string desc;
        string title;
        address payable seller;
        address buyer;
        bool delivered;
        uint price; // in ether
    }
    Product[] public products;
    //events
    event registered(string title,uint productId);
    event bought(uint productId, address buyer);
    event delivery(uint productId);
    
    //destruction
   modifier isNotDestroyed {
       require(!destroyed, "contract has been destroyed"); 
       _;
   }
    // Seller has to register and create product
    function register(string memory _title,string memory _desc, uint _price) public isNotDestroyed{
        require(_price > 0,"Price cannot be less than equal to 0");
        Product memory tempProduct;
        tempProduct.title = _title;
        tempProduct.desc = _desc;
        tempProduct.price = _price;
        tempProduct.seller = msg.sender;
        tempProduct.productId = counter;
        products.push(tempProduct);
        counter++; // counter = counter +1;
        emit registered(tempProduct.title,tempProduct.productId);
    }
    // Buyer will pay and buy the product
    function buy(uint _productId) payable public isNotDestroyed{
        // seller should not buy himself
        require(products[_productId - 1].seller != msg.sender,"Seller cannot buy");
        // buyer should transfer the price of the product
        require(msg.value == products[_productId - 1].price * 10**18);
        products[_productId - 1].buyer = msg.sender;
        emit bought(_productId,msg.sender);
    }
    // Buyer confirms delivery and contract will pay to seller
    function delivered(uint _productId) public isNotDestroyed{
        //only buyer can call this function
        Product memory tempProduct = products[_productId - 1];
        require(tempProduct.buyer == msg.sender,"Only buyer should call this");
        tempProduct.delivered = true;
        products[_productId-1]=tempProduct;
        tempProduct.seller.transfer(tempProduct.price * 10**18);
        emit delivery(_productId);
    }
    
    /*
    //selfdestruct pattern wroks, but its not a secure pattern, if a customer isnt aware and sends money to the account after the selfdestruct is called, he can loss his money
    function implode() public {
        selfdestruct(products[0].seller); //it destroys the contract an transfers the entire balnce of the contract to the receipient 
    }
    this function can be better written as seen below
    */
    
    function implode() public isNotDestroyed{
        selfdestruct(products[0].seller); //it destroys the contract an transfers the entire balnce of the contract to the receipient 
        products[0].seller.transfer(address(this).balance); 
        destroyed = true; 
    }
    fallback() payable external {
        msg.sender.transfer(msg.value); 
    }
    
}
