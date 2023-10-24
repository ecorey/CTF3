// Using the Isolution3 interface write a function that unpacks our data that was 
// packed using abi.encodePacked(a, b, c).
// Where a is type uint16, b is type bool and c is type bytes6.

//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

interface Isolution3 {
    function solution(bytes memory packed) external returns (uint16 a, bool b, bytes6 c);
}

contract CTF3 is Isolution3 {


    function decode(bytes memory packed) public pure returns (uint16 a, bool b, bytes6 c) {
        // The first 2 bytes are for uint16, next 1 byte is for bool, and the last 6 bytes are for bytes6
        (a, b, c) = abi.decode(packed, (uint16, bool, bytes6));
    }


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


  

}



/**
 * SIZE OF VARIABLES IN SOLIDITY
 * Static:
 *  bool - 1 byte
 *  uint8 - 1 byte
 *  uint256 - 32 bytes
 *  address - 20 bytes
 *  bytes1 [1] - 1 byte
 *  bytes32 [1] - 32 bytes
 *  
 * Dynamic // unfixed number of bytes: (dynamic arrays use tails in abi.encode where static uses length of array)
 *  bytes 
 *  string 
 *  [] 
 *  structs  
 */