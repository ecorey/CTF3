Using the Isolution4 interface write a function that unpacks our data that was packed using abi.encodePacked(a, b, c).
Where a is type uint16, b is type bool and c is type bytes6.

    interface Isolution3 {
        function solution(bytes memory packed) external returns (uint16 a, bool b, bytes6 c);
        }

Deploy:

// To Deploy and Run script just add private key with no double quotes
forge create --rpc-url https://sepolia.gateway.pokt.network/v1/lb/ae75c2b1 --private-key xxxx src/CTF3.sol:CTF3
