//SPDX-License-Identifier:MIT

pragma solidity 0.8.17;


interface Isolution3 {
        function solution(bytes memory packed) external returns (uint16 a, bool b, bytes6 c);
        }


contract CTF3 is Isolution3 {

    function solution (bytes memory packed) external override returns (uint16 a, bool b, bytes6 c){

    }

}