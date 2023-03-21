// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Ownable } from "@openzeppelin/access/Ownable.sol";
import { ERC721 } from "@openzeppelin/token/ERC721/ERC721.sol";

import { IMintable } from "../core/IMintable.sol";
import { Mintable } from "../core/Mintable.sol";
import { ByteUtils } from "../utils/ByteUtils.sol";

/// @title ERC721Mintable
/// @author StarkExpress Team
/// @notice Base implementation for StarkExpress ERC-721 mintable tokens.
contract ERC721Mintable is ERC721, Mintable, Ownable {
    //==============================================================================//
    //=== Errors                                                                 ===//
    //==============================================================================//

    /// @notice Thrown when an invalid mint amount is requested.
    error InvalidMintAmountError();

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
    //=== State Variables                                                        ===//
    //==============================================================================//

    /// @notice The token's URI.
    string private _uri;

    //==============================================================================//
    //=== Constructor                                                            ===//
    //==============================================================================//

    /// @notice Constructor for the `ERC721Mintable` contract.
    /// @param name_ The token's name.
    /// @param symbol_ The token's symbol.
    /// @param uri_ The token's URI.
    /// @param starkEx_ The StarkEx contract address.
    constructor(string memory name_, string memory symbol_, string memory uri_, address starkEx_)
        ERC721(name_, symbol_)
        Mintable(starkEx_)
    {
        setUri(uri_);
    }

    //==============================================================================//
    //=== Read API                                                               ===//
    //==============================================================================//

    /// @inheritdoc Mintable
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, Mintable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    //==============================================================================//
    //=== Write API                                                              ===//
    //==============================================================================//

    /// @notice Sets the token's URI.
    /// @dev Only callable by the owner.
    /// @param uri_ The new token URI.
    function setUri(string memory uri_) public onlyOwner {
        _uri = uri_;

        emit LogSetUri(uri_);
    }

    /// @inheritdoc IMintable
    /// @dev Only callable by the StarkEx contract.
    function mintFor(address to_, uint256 amount_, bytes calldata mintingBlob_) external override onlyStarkEx {
        // validate mint amount
        if (amount_ != 1) {
            revert InvalidMintAmountError();
        }

        // parse minting blob
        uint256 tokenId_ = ByteUtils.toUint256(mintingBlob_, 0);

        // emit event
        emit LogMintedERC721(to_, tokenId_);

        // mint ERC721 token
        _safeMint(to_, tokenId_);
    }

    //==============================================================================//
    //=== Internals                                                              ===//
    //==============================================================================//

    /// @dev See {IERC721Metadata-tokenURI}.
    function _baseURI() internal view override returns (string memory) {
        return _uri;
    }
}
