// Using the Isolution3 interface write a function that unpacks our data that was 
// packed using abi.encodePacked(a, b, c).
// Where a is type uint16, b is type bool and c is type bytes6.



//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;

interface Isolution3 {
    function solution(bytes memory packed) external returns (uint16 a, bool b, bytes6 c);
}

contract CTF3 is Isolution3 {

    // function to encode for examples
    // remove in final with all other examples
    // using the 'packed' verions of encode allows you to pack variables acording to their size
    // for a reference to the size of variables see the bottom
    // bytes6 seriesOfOnes = 0x010101010101;
    // encodeData(1, 1, 0x010101010101) == bytes: 0x000101010101010101
    
    // function encodeData(uint16 a, bool b, bytes6 c) public pure returns (bytes memory) {
    //     return abi.encodePacked(a, b, c);
    // }


    // using the 'packed' verions of encode allows you to pack variables acording to their size
    // for a reference to the size of variables see the bottom
    // there is no direct abi.decodePacked but rather decode is used according to the size of the variables
   
    // uint16 + bool + bytes6 = 2 + 1 + 6 = 9 bytes   for eg.
    // solution(0x000101010101010101) = encodeData(1, 1, 0x010101010101)
    // 0x000101010101010101 = 9 bytes, as each byte is represented by 2 places
    function solution (bytes memory packed) external override pure returns (uint16 a, bool b, bytes6 c){
      
        // requires the byte array to be the correct size
        require(packed.length >= 8, "Invalid packed data length");
        
        // unpacking uint16
        // the first two bytes of the packed array, packed[0], packed[1] are used to recontruct the uint16
        // packed[0] is multiplied by 256 (or shifted left by 8 bits) to account for its position as the higher order byte
        // packed[1] is added to the value from the line above as the lower order byte
        a = uint16(uint8(packed[0])) * 256 + uint16(uint8(packed[1]));
        
        // unpacking bool
        // the third byte of the packed array, packed[2], is used to reconstruct the bool
        // if packed[2] == non-zero then is true, else is false
        b = packed[2] != 0;
        
        // unpacking bytes6
        // to unpack the bytes6 first a temporary bytes array temp of length 6 is created
        // a for loop then iterates from 0 to 5, copying the 4th to 9th bytes of the packed array into temp array
        // the temp is then used to reconstruct the bytes6 value c
        bytes memory temp = new bytes(6);
        for (uint i = 0; i < 6; i++) {
            // starting at 4th position
            temp[i] = packed[3 + i];
        }
        c = bytes6(temp);
        
        // the unpacked uint16, bool, and bytes6 are returned
        return (a, b, c);
    }


}



// uint16 + bool + bytes6 = 2 + 1 + 6 = 9


/**
 * SIZE OF VARIABLES IN SOLIDITY
 * Static:
 *  bool - 1 byte
 *  uint8 - 1 byte
 *  uint16 - 2 bytes
 *  uint256 - 32 bytes
 *  address - 20 bytes
 *  bytes1 - 1 byte
 *  bytes6 - 6 bytes
 *  bytes32 - 32 bytes
 *  
 * Dynamic // unfixed number of bytes: (dynamic arrays use tails in abi.encode where static uses length of array)
 *  bytes 
 *  string 
 *  [] 
 *  structs  
 */