// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {SimpleStorage} from "./SimpleStorage.sol";

contract addTenToNumber is SimpleStorage{ //Inheritance 
    //keywords: override and virtual 
    //virtual is used with base class function

    function store (uint256 _newFavoriteNumber) public override{
        myFavoriteNumber = _newFavoriteNumber + 10;
    }
}