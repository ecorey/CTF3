// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {CTF3} from "../src/CTF3.sol";

contract SolutionTest is Test {
    
    CTF3 public ctf3;

  

    function setUp() public {
        ctf3 = new CTF3();
    }

    function test_SortedArray() public {
        

    }
}


