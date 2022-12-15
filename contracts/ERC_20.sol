// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken {
    uint256[5] public supplies;
    uint256 public count = supplies.length;
    mapping(address => uint256) public depositor_slab;
    string public _name;
    string public symbol;

    constructor() {
        symbol = "MTK";
        _name = "MyToken ";
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function deposit(uint256 _amount) external {
        if (supplies[count - 1] + _amount < count * 100) {
            supplies[count - 1] += _amount;
            depositor_slab[msg.sender] = count;
        } else {
            uint256 rem = (count * 100) - supplies[count - 1];

            supplies[count - 1] += rem;
            if (depositor_slab[msg.sender] == 0) {
                depositor_slab[msg.sender] = count;
            }
            count--;
        }
    }
    function tranfer(address _to, uint256 _amount) external returns (bool) {
        require(
            balances[msg.sender] >= _amount,
            "not enough balance to transfer to address"
        );
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }
}
