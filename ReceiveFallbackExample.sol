// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract ReceiveFallbackExample {

    uint256 public result;

    // special functions without the function keyword, external and payable
    receive() external payable {
        // This function is executed when a contract receives plain Ether (without data)
        result = 1;
    }

    fallback() external payable {
        // This function is executed if data is supplied but it does'nt match any other function signature (parameter)
        result = 2;
    }

    /* 
    https://solidity-by-example.org/sending-ether
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
    receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()

    */
}