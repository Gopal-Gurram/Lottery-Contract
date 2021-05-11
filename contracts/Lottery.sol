pragma solidity ^0.5.13;


contract Lottery {
    address public owner;
    
    address payable [] public players ;
    
    constructor () public {
        owner = msg.sender ;
    }
        
        modifier OwnerOnly {
            if(msg.sender == owner) {
                _;
            }
        }
    
    function deposit() public payable {
        require(msg.value >= 1 ether);
        players.push(msg.sender);
    }
    
    function GenerateRandomNum () public view returns(uint){
        
        return uint (keccak256(abi.encodePacked(now, block.difficulty , players.length)));
    }
    
    function pickWinner() OwnerOnly public {
        
        uint randonNumber = GenerateRandomNum();
        
        uint index = randonNumber % players.length ;
        
        address payable winner ;
        
        winner = players[index];
        
        winner.transfer (address(this).balance);
        players = new address payable [] (0) ;
        
    }
    
    
    
    
}