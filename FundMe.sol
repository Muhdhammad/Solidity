// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {PriceConverter} from "./priceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minUSD = 5e18;

    address[] public funders;

    mapping(address funders => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        // function to allow users to send funds
        // lets say min 5$

        require(msg.value.getConversionRate() >= minUSD, "You did'nt send enough ETH" );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        // 1 Ether = 10 ** 18 wei
    }

    
}
