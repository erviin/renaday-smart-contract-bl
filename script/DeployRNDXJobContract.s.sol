// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {RNDXJobContract} from "../src/RNDXJobContract.sol";

contract DeployRNDXJobContract is Script {
    function run() external returns (RNDXJobContract) {
        vm.startBroadcast();
        RNDXJobContract rndxJobContract = new RNDXJobContract();
        vm.stopBroadcast();
        return rndxJobContract;
    }
}
