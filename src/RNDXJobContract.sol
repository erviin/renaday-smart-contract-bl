// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.8.0 <0.9.0;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RNDXJobContract {
    event FundContract(string indexed uid, string indexed id, address indexed caller, uint256 amount);
    event ContractCreate(string id, address indexed creator, uint256 totalFund, uint256 createdAt);

    struct JobContract {
        address owner;
        uint256 totalFund;
        uint256 createdAt;
        uint8 decimals;
        bool exists;
    }

    struct JobTimeSheet {
        address employee;
        uint32 startedAt;
        uint32 weeklyMax;
        uint256 terminatedAt;
        bool isTerminated;
    }

    address contractOwner;

    mapping(string => mapping(string => JobContract)) public JobContracts;

    mapping(address => address) public contractAdmins;
    // list of for keeping token / cryptocurrency contract address
    mapping(string => mapping(string => address)) public currencyContracts;

    constructor() {
        contractOwner = msg.sender;
    }

    // DEPLOY JOB CONTRACT ON-CHAIN
    // _uid is ID REf of the user on web2
    // _id is ID ref contract on web2
    // _deployer is an address of the person who create the contrac on-chain
    // _currency is token address for the main currency
    function createContract(string memory _uid, string memory _id, uint8 decimals, address _deployer, address _currency)
        external
    {
        require(bytes(_uid).length > 0, "User ID invalid");
        uint256 timeNow = block.timestamp;
        JobContracts[_uid][_id] =
            JobContract({owner: _deployer, totalFund: 0, createdAt: timeNow, decimals: decimals, exists: true});
        currencyContracts[_uid][_id] = _currency;

        emit ContractCreate(_uid, _deployer, 0, timeNow);
    }

    // FUND A Contract ON-CHAIN
    // _uid is ID REf of the user on web2
    // _id is ID ref contract on web2
    function fundContract(string memory _uid, string memory _id, uint256 _amount) external {
        JobContract storage jobContract = JobContracts[_uid][_id];
        require(_amount > 0, "You need to at least send some fund");
        jobContract.totalFund += _amount;
        IERC20 tokenCurrency = IERC20(currencyContracts[_uid][_id]);

        tokenCurrency.transferFrom(msg.sender, address(this), _amount);

        emit FundContract(_uid, _id, msg.sender, _amount);
    }

    function getAllowance(address _wallet, address _currency) public view returns (uint256) {
        IERC20 tokenCurrency = IERC20(_currency);
        return tokenCurrency.allowance(_wallet, address(this));
    }

    // for check total fund of the project
    // _uid is ID REf of the user on web2
    // _id is ID ref contract on web2
    function getProjectTotalFund(string memory _uid, string memory _id) public view returns (uint256) {
        JobContract storage jobContract = JobContracts[_uid][_id];
        require(jobContract.exists, "Job Contract is not exists");
        return jobContract.totalFund;
    }

    function getSmartContractBalance() public view returns (uint256) {
        require(msg.sender == contractOwner, "You are not the owner of this smart contract");
        return address(this).balance;
    }
}
