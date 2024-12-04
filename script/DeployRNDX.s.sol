// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {RNDXTOKEN} from "../src/RNDX.sol";

contract DeployRNDX is Script {
    uint256 public constant INITIAL_SUPPLY = 1000000 ether;

    function run() external returns (RNDXTOKEN) {
        vm.startBroadcast();
        RNDXTOKEN token = new RNDXTOKEN(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return token;
    }
}
