pragma solidity ^0.8.0;

contract Proxy{
    address implementation;
    address admin; 

    constructor() {
        admin = msg.sender;
    }

    function update(address _implementation) external{
        implementation = _implementation;
    }

    fallback() external{
        require(implementation != address(0));
        address impl = implementation;
        assembly{
            let ptr:=mload(0x40) //0x40 is the first available slot in memory
            //copy calldata into memory
            //first param is location in memory to copy to
            // second param is offset
            // third param is size of data. calldatasize() returns size of calldata
            calldatacopy(ptr, 0, calldatasize()) 
            //first param is gas allocation. gas() is the full amount of gas available
            // second param is address of contract to forward function call to
            //third param is the function data (function and params)
            //fourth param is the size of the data in the third param
            //last two params are memory location and size of return data
            let result:=delegatecall(gas(), impl, ptr, calldatasize(),0,0)
            //returndatasize() returns size of the return data
            let size:=returndatasize()
            //returndatacopy copies return data to specified location
            // first param is location to copy data to. Since we don't need the calldata anymore we can use the same ptr
            // second param is offset
            // third is the size of the data
            returndatacopy(ptr, 0, size)

            switch result
            //revert if result is 0, indicates failure
            case 0 {revert(ptr,size)}
            //if succesful, return data to user, first param location, second param size
            default{return(ptr, size)}
            
        }
    }
}