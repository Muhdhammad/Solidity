// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {PriceConverter} from "./priceConverter.sol";

error notOwner();

contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant MIN_USD = 5e18;

    address[] public funders;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    mapping(address funders => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        // function to allow users to send funds
        // lets say min 5$

        require(msg.value.getConversionRate() >= MIN_USD, "You did'nt send enough ETH" );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        // 1 Ether = 10 ** 18 wei
    }

    function withdraw() public onlyOwner{
        // resetting mapping
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // resetting array
        funders = new address[] (0);

        /* (03) ways to send: 
        transfer: gas limit 2300, automatically reverts the transaction
        send: gas limit 2300, returns boolean(true or false) to indicate if transfer was successfull
        call: forwards all gas or gas set (no limit), alse returns boolean

        => transfer
        payable(msg.sender).transfer(address(this).balance);

        => send
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed!");
        */

        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed!");
        
    }

    modifier onlyOwner() {
        //require(msg.sender == i_owner, "not owner!");
        if(msg.sender != i_owner) {revert notOwner();}
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}

// not constant - 2512 gas        constant - 303 gas
// not immutable - 2552 gas       immutable -424 gas
