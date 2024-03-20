// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {PetCare} from "../src/PetCare.sol";

contract Local is Script {
    PetCare petcare;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);

        petcare = new PetCare();
        console2.log("PetCare address: ", address(petcare));

        vm.stopBroadcast();
    }
}