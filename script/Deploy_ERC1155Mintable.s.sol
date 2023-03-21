// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Script } from "@forge-std/Script.sol";

import { ERC1155Mintable } from "../src/erc1155/ERC1155Mintable.sol";

contract Deploy_ERC1155Mintable is Script {
    string private _name;
    string private _symbol;
    string private _uri;
    address private _starkEx;

    function setUp() public {
        _name = vm.envString("STARKEXPRESS_MINTABLE_TOKEN_NAME");
        _symbol = vm.envString("STARKEXPRESS_MINTABLE_TOKEN_SYMBOL");
        _uri = vm.envString("STARKEXPRESS_MINTABLE_TOKEN_URI");
        _starkEx = vm.envAddress("STARKEXPRESS_STARKEX_ADDRESS");
    }

    /// @dev You can send multiple transactions inside a single script.
    function run() public {
        vm.startBroadcast();

        // deploy contract
        new ERC1155Mintable(_name, _symbol, _uri, _starkEx);

        vm.stopBroadcast();
    }
}
