// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.9.0;  // Tells the compiler to use version in between 0.8.18 and 0.9.0

contract FirstStorage {

    // unsigned int variables by default is 256 bits, if not initialized defaults to 0
    //By default variables are internal (are not visible outside this contract unless they are a child contract)
    //When using the public keyword, the smart contract adds a getter and setter
    uint public userID; 
 
    //This is declaring an array with zero indexing, and it is a storage permanent, mutable variable
    uint256[] listOfIds;

    //We are creating our own types here
    struct Person{
        uint256 id;
        string name;
        bool isAdmin;
    }
    //Adding a single Person Struct
    Person public Gustav = Person({id:10, name:"Gustavium", isAdmin:true});

    //Adding an array of people
    Person[] public personsInDB;
    string userName;

    mapping(string => bool) public nameToIsAdmin;

    //This is the actual address of this smart contract
    address addressFirstStorage = 0xd9145CCE52D386f254917e481eB44e9943F39138;

    function storeID(uint _userID) public {
        userID = _userID;
    }

    function storeName(string memory _name) public{
        userName = _name;
        //This call is going to cost us some more gas, eventhough view functions dont cost gas
        //this is because we are calling them in a function that costs gas and we are
        //giving it more work.
        retrieveName();
    }

    //I could've simply skipped this function if I declared userName as public instead of the
    //default internal.
    //Declaring the function as view means you are not going to spend any gas on it i.e no Transaction 
    //Pure is even more strict as it doesn't allow us to even see anything in storage
    function retrieveName () public view returns (string memory){
         return userName;

    }

    //Adding a function to dynamically add people into the personsInDB array
    //The memory keyword means that the variable will be stored in memory and not in storage
    //memory is cheaper than storage, it is temporary, it is different from calldata type because
    //memory variables can be changed
    //We only add memory keyword in structs, strings and arrays, solidity adds it by default to primitive types
    function addPerson(uint256 _id, string memory _name, bool _isAdmin) public{
        //only mutable because it was declared as memory and not call data.
        // _name="John Literal";
        personsInDB.push(Person({id:_id, name:_name, isAdmin:_isAdmin}));

    }
 
}