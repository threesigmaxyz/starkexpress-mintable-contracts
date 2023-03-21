// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Ownable } from "@openzeppelin/access/Ownable.sol";
import { IERC165 } from "@openzeppelin/interfaces/IERC165.sol";
import { ERC721 } from "@openzeppelin/token/ERC721/ERC721.sol";

import { Mintable } from "src/Mintable.sol";
import { IERC721Mintable } from "src/erc721/IERC721Mintable.sol";
import { ByteUtils } from "src/utils/ByteUtils.sol";

contract ERC721Mintable is ERC721, Mintable, Ownable, IERC721Mintable {
    //==============================================================================//
    //=== Errors                                                                 ===//
    //==============================================================================//

    /// @notice Thrown when an invalid mint amount is requested.
    error InvalidMintAmountError();

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
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, Mintable, IERC165)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    //==============================================================================//
    //=== Write API                                                              ===//
    //==============================================================================//

    /// @inheritdoc IERC721Mintable
    /// @dev Only callable by the owner.
    function setUri(string memory uri_) public override onlyOwner {
        _uri = uri_;

        emit LogSetUri(uri_);
    }

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
