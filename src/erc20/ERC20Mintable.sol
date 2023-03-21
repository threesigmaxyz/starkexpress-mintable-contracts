// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ERC20 } from "@openzeppelin/token/ERC20/ERC20.sol";

import { Mintable } from "src/Mintable.sol";
import { IERC20Mintable } from "src/erc20/IERC20Mintable.sol";

contract ERC20Mintable is ERC20, Mintable, IERC20Mintable {
    //==============================================================================//
    //=== Errors                                                                 ===//
    //==============================================================================//

    /// @notice Thrown when an invalid mint amount is requested.
    error InvalidMintAmountError();

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
