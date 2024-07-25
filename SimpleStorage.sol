// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract SimpleStorage {

    uint256 myFavoriteNumber;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    // Dynamic Array
    Person[] public listOfPeople;

    // Hammad -> 10
    mapping(string => uint256) public nameToFavoriteNumber;

    //Person public anyPerson = Person({favoriteNumber: 7, name: "Hammad"});

    function store(uint256 _favoriteNumber) public virtual{ //virtual is used because this function is inherited and overriden by child contract
        myFavoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256){
        return myFavoriteNumber;
    }

    /* memory, calldata, storage
        -> memory: temporary variable that can be changed
        -> calldata: temporary variable that can't be changed (immutable)
        -> storage: permanent variable
    */

    function addPerson(string memory _name, uint256 _favoriteNumber ) public {
    //    _name = "Hammad"; this line will only work when we use memory, but if we use calldata it wont work because the var can't be changed (immutable) 
        listOfPeople.push( Person(_favoriteNumber, _name) );
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }


}