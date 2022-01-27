pragma solidity ^0.8.0;

contract IsContract{
    function isContract(address addr) view external returns(bool){
        uint codeSize;
        assembly{
            codeSize:=extcodesize(addr)
        }

        return codeSize ==0;
    }
}