// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Ownable } from "@openzeppelin/access/Ownable.sol";
import { ERC1155 } from "@openzeppelin/token/ERC1155/ERC1155.sol";

import { IMintable } from "../core/IMintable.sol";
import { Mintable } from "../core/Mintable.sol";
import { ByteUtils } from "../utils/ByteUtils.sol";

/// @title ERC1155Mintable
/// @author StarkExpress Team
/// @notice Base implementation for StarkExpress ERC-1155 mintable tokens.
contract ERC1155Mintable is ERC1155, Mintable, Ownable {
    //==============================================================================//
    //=== Errors                                                                 ===//
    //==============================================================================//

    /// @notice Thrown when an invalid mint amount is requested.
    error InvalidMintAmountError();

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
    //=== State Variables                                                        ===//
    //==============================================================================//

    /// @notice The token's name.
    string public name;

    /// @notice The token's symbol.
    string public symbol;

    //==============================================================================//
    //=== Constructor                                                            ===//
    //==============================================================================//

    /// @notice Constructor for the `ERC1155Mintable` contract.
    /// @param name_ The token's name.
    /// @param symbol_ The token's symbol.
    /// @param uri_ The token's URI.
    /// @param starkEx_ The StarkEx contract address.
    constructor(string memory name_, string memory symbol_, string memory uri_, address starkEx_)
        ERC1155(uri_)
        Mintable(starkEx_)
    {
        name = name_;
        symbol = symbol_;

        emit LogSetUri(uri_);
    }

    //==============================================================================//
    //=== Read API                                                               ===//
    //==============================================================================//

    /// @inheritdoc Mintable
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155, Mintable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    //==============================================================================//
    //=== Write API                                                              ===//
    //==============================================================================//

    /// @notice Sets the token's URI.
    /// @dev Only callable by the owner.
    /// @param uri_ The new token URI.
    function setUri(string memory uri_) public onlyOwner {
        _setURI(uri_);

        emit LogSetUri(uri_);
    }

    /// @inheritdoc IMintable
    /// @dev Only callable by the StarkEx contract.
    function mintFor(address to_, uint256 amount_, bytes calldata mintingBlob_) external override onlyStarkEx {
        // validate mint amount
        if (amount_ < 1) {
            revert InvalidMintAmountError();
        }

        // parse minting blob
        uint256 tokenId_ = ByteUtils.toUint256(mintingBlob_, 0);

        // emit event
        emit LogMintedERC1155(to_, tokenId_, amount_);

        // mint ERC1155 token
        _mint(to_, tokenId_, amount_, "");
    }
}
