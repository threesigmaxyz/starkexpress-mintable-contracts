// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC721 } from "@openzeppelin/interfaces/IERC721.sol";

import { IMintable } from "src/IMintable.sol";

interface IERC721Mintable is IERC721, IMintable {
    //==============================================================================//
    //=== Events                                                                 ===//
    //==============================================================================//

    /// @notice Emitted when the token's URI is set.
    /// @param uri_ The new token URI.
    event LogSetUri(string uri_);

    /// @notice Emitted when an ERC721 token is minted.
    /// @param to_ The minted token recipient.
    /// @param tokenId_ The minted token ID.
    event LogMintedERC721(address indexed to_, uint256 tokenId_);

    //==============================================================================//
    //=== Write API                                                              ===//
    //==============================================================================//

    /// @notice Sets the token's URI.
    /// @param uri_ The new token URI.
    function setUri(string memory uri_) external;
}
