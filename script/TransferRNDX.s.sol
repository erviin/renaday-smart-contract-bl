// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TransferRNDX is Script {
    function run() external {
        address token = ""; // Replace with your token address
        address recipient = ""; // Replace with recipient address
        uint256 amount = 10 ether; // Amount to transfer (adjust to your token decimals)

        // Start the broadcast to send the transaction
        vm.startBroadcast();

        IERC20(token).transfer(recipient, amount);

        vm.stopBroadcast();
    }
}
