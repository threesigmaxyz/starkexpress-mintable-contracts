// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20 } from "@openzeppelin/interfaces/IERC20.sol";

import { IMintable } from "src/IMintable.sol";

interface IERC20Mintable is IERC20, IMintable {
    //==============================================================================//
    //=== Events                                                                 ===//
    //==============================================================================//

    /// @notice Emitted when ERC20 tokens are minted.
    /// @param to_ The minted tokens recipient.
    /// @param amount_ The minted tokens amount.
    event LogMintedERC20(address indexed to_, uint256 amount_);
}
