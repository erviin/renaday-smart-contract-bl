// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.8.0 <0.9.0;

import {Test} from "forge-std/Test.sol";
import {DeployRNDX} from "../script/DeployRNDX.s.sol";
import {RNDXTOKEN} from "../src/RNDX.sol";

contract RNDXTokenTest is Test {
    RNDXTOKEN public token;
    DeployRNDX public deployer;
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployRNDX();
        token = deployer.run();
        vm.prank(address(msg.sender));
        token.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assertEq(STARTING_BALANCE, token.balanceOf(bob));
    }

    function testAllowances() public {
        uint256 initialAllowance = 100;

        // bob approves allice to spend 100 token
        vm.prank(bob);
        token.approve(alice, initialAllowance);

        uint256 transferAmount = 50;
        vm.prank(alice);
        token.transferFrom(bob, alice, transferAmount);

        assertEq(token.balanceOf(alice), transferAmount);
        assertEq(token.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }
}
