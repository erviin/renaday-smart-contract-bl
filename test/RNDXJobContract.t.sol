// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {DeployRNDXJobContract} from "../script/DeployRNDXJobContract.s.sol";
import {RNDXJobContract} from "../src/RNDXJobContract.sol";
import {MockCurrency} from "./mocks/MockCurrency.sol";

contract RNDXJobContractTest is Test {
    DeployRNDXJobContract deployer;
    RNDXJobContract sc;
    uint256 public STARTING_BALANCE = 100 ether;
    address public user1 = address(0x456);
    address public owner = address(0x123);
    string userId = "user1";
    string projectId = "11";
    address _currencyAddr;
    MockCurrency _currency;

    function setUp() public {
        deployer = new DeployRNDXJobContract();
        sc = deployer.run();
        vm.startPrank(owner);

        // init currency
        _currency = new MockCurrency("IDRT Token", "IDRT");
        _currencyAddr = address(_currency);
        _currency.mint(user1, STARTING_BALANCE);
        vm.stopPrank();
    }

    function testJobContractOnChain() public {
        vm.startPrank(owner);

        sc.createContract(userId, projectId, _currency.decimals(), user1, _currencyAddr);
        (address jobOwner, uint256 totalFund, uint256 createdAt, uint8 decimals, bool exists) =
            sc.JobContracts(userId, projectId);

        console.log(" total fund", totalFund);
        assertEq(jobOwner, user1);
        assertEq(totalFund, 0);
        assertGt(createdAt, 0);
        assertEq(decimals, 18);
        assertTrue(exists);
        vm.stopPrank();
    }

    function testUser1Balance() public view {
        uint256 balance = _currency.balanceOf(user1);
        console.log(" balance of erv wallet", balance);
        assertEq(balance, STARTING_BALANCE);
    }

    function testNonExistentContract() public {
        string memory uid = "randomString";
        string memory pid = "999999";
        vm.expectRevert("Job Contract is not exists");
        sc.getProjectTotalFund(uid, pid);
    }

    function testSetAllowanceToContract() public {
        vm.startPrank(user1);

        uint256 allowance = 30 ether;
        _currency.approve(address(sc), allowance);

        // check allowance in the smart contract
        uint256 allowanceContract = sc.getAllowance(user1, _currencyAddr);
        console.log("allowance in the contract", allowanceContract);
        assertEq(allowanceContract, allowance);

        vm.stopPrank();
    }

    function testFundTheContract() public {
        testJobContractOnChain();

        vm.startPrank(user1);

        uint256 amount = 20 ether;

        _currency.approve(address(sc), 30 ether); // Approve the contract to spend tokens

        sc.fundContract(userId, projectId, amount);

        // check fund in the contract
        uint256 getAmount = sc.getProjectTotalFund(userId, projectId);
        console.log("fund in the contract", getAmount);
        assertEq(getAmount, amount);

        // allowance should descreased to 10
        uint256 allowanceContract = sc.getAllowance(user1, _currencyAddr);
        console.log("allowance after fund", allowanceContract);
        assertEq(allowanceContract, 10 ether);
        vm.stopPrank();
    }
}
