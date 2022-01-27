pragma solidity ^0.8.0;

contract A{
    function foo() public pure {
        assembly{
            let a:= 10
            let b:= 5
            let c:= add(a,b)
            //mload (used to load value at specific memory location)
            //mstore  (store value at specific memory location)
            //sstore (store value to storage of contract)
        }
    }
    function foo2() public pure {
        assembly{
            //if statement
            let a:=10
            if eq(a,10){a:=add(a,10)}
            //switch
            //for loop
        }
    }

    function foo3() public pure {
        assembly{
           //function
           function fn(a,b) -> c{
               c:= add(a,b)
           }
           let d:= fn(1,2)
        }
    }

    function foo4() public pure {
        uint a =10;
        //use variable inside assembly
        assembly{
           a:= add(a,10)
        }
    }

}