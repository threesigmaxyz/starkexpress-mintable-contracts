// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC1155 } from "@openzeppelin/interfaces/IERC1155.sol";

import { IMintable } from "src/IMintable.sol";

interface IERC1155Mintable is IERC1155, IMintable {
    //==============================================================================//
    //=== Events                                                                 ===//
    //==============================================================================//

    /// @notice Emitted when the token' URI is set.
    /// @param uri_ The new token URI.
    event LogSetUri(string uri_);

    /// @notice Emitted when ERC1155 tokens are minted.
    /// @param to_ The minted tokens recipient.
    /// @param tokenId_ The minted tokens ID.
    /// @param amount_ The minted tokens amount.
    event LogMintedERC1155(address indexed to_, uint256 tokenId_, uint256 amount_);

    //==============================================================================//
    //=== Write API                                                              ===//
    //==============================================================================//

    /// @notice Sets the token's URI.
    /// @param uri_ The new token URI.
    function setUri(string memory uri_) external;
}
