// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;



contract MyToken {
    uint256[5] private supplies;

    
    uint256 private count = supplies.length;
    mapping(address => uint256) private depositor_slab;
   

    mapping(address => uint256) private balances;

    event Transfer(address to, address from, uint256 _amount);
    event Deposit(address from ,uint _amount,uint index);

    /// not having enough balance
    error insuffient_balance();

    

   

    function deposit(uint256 _amount) external {
        if (supplies[count - 1] + _amount < count * 100) {
            supplies[count - 1] += _amount;
            depositor_slab[msg.sender] = count;
            balances[msg.sender]+=_amount;
            emit Deposit(msg.sender,_amount,count);

        } else {
            uint256 rem = (count * 100) - supplies[count - 1];

            supplies[count - 1] += rem;
            balances[msg.sender]+=rem;
            if (depositor_slab[msg.sender] == 0) {
                depositor_slab[msg.sender] = count;
                  emit Deposit(msg.sender,rem,count);
            }
            count--;
        }
    }

    function tranfer(address _to, uint256 _amount) external returns (bool) {
       
        if(balances[msg.sender] < _amount){
             revert insuffient_balance();
        }
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        supplies[depositor_slab[msg.sender]]-=_amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }
 
    function getSupplies(uint index) external  view returns (uint){
        return supplies[index-1];
    }

   function getSlab(address _depositor) external view  returns(uint){
     return  depositor_slab[_depositor];
   }
  
}
