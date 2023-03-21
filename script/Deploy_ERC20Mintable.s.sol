// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Script } from "@forge-std/Script.sol";

import { ERC20Mintable } from "../src/erc20/ERC20Mintable.sol";

contract Deploy_ERC20Mintable is Script {
    string private _name;
    string private _symbol;
    address private _starkEx;

    function setUp() public {
        _name = vm.envString("STARKEXPRESS_MINTABLE_TOKEN_NAME");
        _symbol = vm.envString("STARKEXPRESS_MINTABLE_TOKEN_SYMBOL");
        _starkEx = vm.envAddress("STARKEXPRESS_STARKEX_ADDRESS");
    }

    /// @dev You can send multiple transactions inside a single script.
    function run() public {
        vm.startBroadcast();

        // deploy contract
        new ERC20Mintable(_name, _symbol, _starkEx);

        vm.stopBroadcast();
    }
}
