// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;


import "forge-std/Test.sol";
import "forge-std/console.sol";
import {CareerZen6551Account} from "../src/CareerZenERC6551Account.sol";
import {CareerZen6551Registry} from "../src/CareerZenRegistry.sol";

contract CareerzenTest is Test {
    CareerZen6551Registry public czRegistry;
    CareerZen6551Account public czAccount; 
    address public address1 = vm.addr(10);

    function setUp() public {
        vm.prank(address1);
        czRegistry = new CareerZenRegistry();
        console.log(address(czRegistry));
    }
}