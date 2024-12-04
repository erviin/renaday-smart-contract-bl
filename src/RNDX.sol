// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RNDXTOKEN is ERC20 {
    constructor(uint256 initialSupply) ERC20("RENADAY TOKEN", "RNDX") {
        _mint(msg.sender, initialSupply);
    }
}
