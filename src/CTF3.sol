// Using the Isolution3 interface write a function that unpacks our data that was 
// packed using abi.encodePacked(a, b, c).
// Where a is type uint16, b is type bool and c is type bytes6.

//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

interface Isolution3 {
    function solution(bytes memory packed) external returns (uint16 a, bool b, bytes6 c);
}

contract CTF3 is Isolution3 {

    function solution (bytes memory packed) external override returns (uint16 a, bool b, bytes6 c){
      
        require(packed.length >= 8, "Invalid packed data length");
        
        // Unpacking uint16
        a = uint16(uint8(packed[0])) * 256 + uint16(uint8(packed[1]));
        
        // Unpacking bool
        b = packed[2] != 0;
        
        // Unpacking bytes6
        bytes memory temp = new bytes(6);
        for (uint i = 0; i < 6; i++) {
            temp[i] = packed[3 + i];
        }
        c = bytes6(temp);
        
        return (a, b, c);
    }


    //  function solution(bytes memory packed) external override returns (uint16 a, bool b, bytes6 c) {
    //     require(packed.length >= 8, "Invalid packed data length");
        
    //     assembly {
    //         // Unpacking uint16
    //         a := and(mload(add(packed, 32)), 0xFFFF)
            
    //         // Unpacking bool
    //         b := and(mload(add(packed, 33)), 0x1)
            
    //         // Unpacking bytes6
    //         c := and(mload(add(packed, 34)), 0xFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000)
    //         c := shr(208, c)  // shift right to align the bytes6 data
    //     }
    // }

}
