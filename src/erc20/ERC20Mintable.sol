// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "@openzeppelin/token/ERC20/ERC20.sol";

import { IMintable } from "../core/IMintable.sol";
import { Mintable } from "../core/Mintable.sol";

/// @title ERC20Mintable
/// @author StarkExpress Team
/// @notice Base implementation for StarkExpress ERC-20 mintable tokens.
contract ERC20Mintable is ERC20, Mintable {
    //==============================================================================//
    //=== Errors                                                                 ===//
    //==============================================================================//

    /// @notice Thrown when an invalid mint amount is requested.
    error InvalidMintAmountError();

    //==============================================================================//
    //=== Events                                                                 ===//
    //==============================================================================//

    /// @notice Emitted when ERC20 tokens are minted.
    /// @param to_ The minted tokens recipient.
    /// @param amount_ The minted tokens amount.
    event LogMintedERC20(address indexed to_, uint256 amount_);

    //==============================================================================//
    //=== Constructor                                                            ===//
    //==============================================================================//

    /// @notice Constructor for the `ERC20Mintable` contract.
    /// @param name_ The tokens' name.
    /// @param symbol_ The tokens' symbol.
    /// @param starkEx_ The StarkEx contract address.
    constructor(string memory name_, string memory symbol_, address starkEx_)
        ERC20(name_, symbol_)
        Mintable(starkEx_)
    {
        // TODO empty body?
    }

    //==============================================================================//
    //=== Write API                                                              ===//
    //==============================================================================//

    /// @inheritdoc IMintable
    /// @dev Only callable by the StarkEx contract.
    function mintFor(address to_, uint256 amount_, bytes calldata) external override onlyStarkEx {
        // validate mint amount
        if (amount_ < 1) {
            revert InvalidMintAmountError();
        }

        // emit event
        emit LogMintedERC20(to_, amount_);

        // mint ERC20 tokens
        _mint(to_, amount_);
    }
}
