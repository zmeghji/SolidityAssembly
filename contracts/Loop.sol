pragma solidity ^0.8.0;

contract Loop{
    function sumSolidity(uint[] memory _data) pure public returns (uint sum){
        for(uint i =0;i< _data.length; i++ ){
            sum+=_data[i];
        }
    }

    function sumAssembly(uint[] memory _data) pure public returns (uint sum){
        assembly{
            //if there are three elements in _data 1,2,3
            //there are actually 4 memory slots used because the first value is the lenght
            // so it looks like this [3,1,2,3]
            let length:=mload(_data)
            let data:= add(_data,0x20) //add 32 bytes to get to the pointer of the next memory slot
            // for
            //     {/*initialization logic*/}
            //     //stopping condition
            //     {/*executed at every pass*/}
            //     {/*body of loop*/}

            for
                {let end:= add(data,mul(0x20,length))}
                lt(data,end)
                {data:=add(_data, 0x20)}
                {sum:= add(sum, mload(data))}

        }

    }

}