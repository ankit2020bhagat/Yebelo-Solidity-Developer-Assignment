// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract MyToken is ERC20 {
    uint[5] public  supplies;
    uint public count=supplies.length ;
    constructor() ERC20("MyToken", "MTK") {}

    mapping (address => uint) public  depositor_slab;

   function deposit(uint _amount)  external {
        if(supplies[count-1]+_amount  < count * 100 ){
            supplies[count-1]+=_amount;
            depositor_slab[msg.sender]=count;
        }
        else {
           uint rem = (count * 100)-supplies[count-1];
           
           supplies[count -1]+= rem;
           if(depositor_slab[msg.sender]==0){
               depositor_slab[msg.sender]=count;
           }
           count--;
          
        }
       
        
    }

   
}