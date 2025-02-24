// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC165 } from "@openzeppelin/interfaces/IERC165.sol";
import { ERC165 } from "@openzeppelin/utils/introspection/ERC165.sol";

import { IMintable } from "./IMintable.sol";

/// @title Mintable
/// @author StarkExpress Team
/// @notice Base abstract class for mintable StarkExpress tokens.
/// @dev All mintable assets in the StarkExpress platform must extend this class.
abstract contract Mintable is ERC165, IMintable {
    //==============================================================================//
    //=== Errors                                                                 ===//
    //==============================================================================//

    /// @notice An unauthorized operation was requested.
    error NotAuthorizedError();

    /// @notice An argument with a non-zero value is passed as zero.
    error ZeroValueError();

    //==============================================================================//
    //=== State Variables                                                        ===//
    //==============================================================================//

    /// @notice The StarkEx contract address.
    address public immutable starkEx;

    //==============================================================================//
    //=== Modifiers                                                              ===//
    //==============================================================================//

    /// @notice Throws if called by any account other than the StarkEx contract.
    modifier onlyStarkEx() {
        if (msg.sender != starkEx) {
            revert NotAuthorizedError();
        }
        _;
    }

    //==============================================================================//
    //=== Constructor                                                            ===//
    //==============================================================================//

    /// @notice Constructor for the `Mintable` contract.
    /// @param starkEx_ The StarkEx contract address.
    constructor(address starkEx_) {
        if (starkEx_ == address(0)) revert ZeroValueError();

        starkEx = starkEx_;
    }

    //==============================================================================//
    //=== Read API                                                               ===//
    //==============================================================================//

    /// @dev See {IERC165-supportsInterface}.
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return interfaceId == type(IMintable).interfaceId || super.supportsInterface(interfaceId);
    }
}
