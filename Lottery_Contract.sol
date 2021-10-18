pragma solidity 0.6.12; 
/* AIM: 

1. A player (Investors) with an ehtereum wallet account can invest a mimimum 1.3 ether in the scheme.  

2. Events are logged.

2.  Assertain current balance of account (total ether staked).  

3. //Assertain Total number of players 

3. Manager can't invest in the scheme!
        

4. Randomly select an index within the index range of enlisted players/Investors.

5. Pay player: pay ramdomly selected number. 

*/
contract test {
    address public manager; //operator of account 
    address payable [] public players; //enlisted players of the scheme
    mapping (address=>uint) wallet;  
    
//define manager 
    constructor() public {
       manager = msg.sender; 
    }
   
   //track investor transactions  
   event trackInvestors(address _player, uint _value); 
   event trackWinner(address _winner, uint _value);
   
   
   
   modifier onlyManager (){
       require(manager == msg.sender, 'Only Manager can perform this function'); 
       _;
       
   }
  
    //add players function 
    function addInvestor() payable public {
        //we dont want manager to enage in the scheme 
        require(msg.sender != manager,'Manager can not bet');
        
       
        for( uint a = 0; a < players.length; a ++){
            if (players[a] == msg.sender){
                revert('Cant bet twice');
            
            }
        }
       
        
        //cannot enter scheme with less than 1.3 ehter
        require(msg.value> 1 ether,'must be 2 ether'); 
        
        
        //add player (palyers are added as the enter the scheme)
        players.push(msg.sender);
        wallet[msg.sender] = msg.value; 
        
        //log 
        emit trackInvestors(msg.sender, msg.value); 
    } 
    
    //get balance of scheme 
    function getBalance() public view returns(uint){
        return address(this).balance; 
        
    }
    
    //get number of players  
    function NumberOfPlayers() public view returns(uint){
        return players.length; 
    }
    
    //checks how much each investor bet 
    function getAmountBet(address _investor) public view onlyManager returns(uint) {
        return wallet[_investor]; 
    }
    
    //generate ramdom number 
    function random() private view returns (uint){
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length)));
    }
    
    
    //ramdonly select and pay winner 
    function selectWinner() public payable onlyManager returns(bool success){
        
        //pass generated random number 
       uint R = random(); 
        //select a random number - pseudo random number - do not use this in production
        // Use ORACLES to find a random number
        // first take some global variables, encode it, hash it, convert to uint //select a random number - pseudo random number - do not use this in production
        
        
        //modulo it with number of players
        uint i = R % players.length;  
        
        
        //map address to index numbe in array 
        address payable winner = players[i]; 
        
        //log
        emit trackInvestors(winner, address(this).balance); 
        
        //transfer all the money in the contract to the address in the array
        winner.transfer(address(this).balance);
        
        
        //then make the array empty
        players = new address payable [](0) ; 
        
        return true; 
    }
    
    
    
}
