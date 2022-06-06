# SPDX-License-Identifier: MIT
%lang starknet

#
# title: The house of reserves contract.
# notice: Custodies all deposits, to allow minting of the backedAsset.
# Users can only deposit and withdraw from this contract.
# A HouseOfReserve is required to back a specific backedAsset.
#
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.math import assert_not_zero
from starkware.cairo.common.bool import TRUE, FALSE

from openzeppelin.token.erc20.interfaces.IERC20 import IERC20
from contracts.interfaces.IAccountant import IAccountant

from starkware.starknet.common.syscalls import get_caller_address

@storage_var
func reserve_asset() -> (address: felt):
end

@storage_var
func backed_asset() -> (address: felt):
end

@storage_var
func reserve_token_id() -> (id: Uint256):
end

@storage_var
func backed_token_id() -> (id: Uint256):
end

@storage_var
func collateral_ratio() -> (numerator: felt, denominator: felt):
end

@storage_var
func accountant() -> (address: felt):
end

@storage_var
func house_oracle() -> (address: felt):
end

@constructor
func contructor{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(
    _reserve_asset: felt,
    _backed_asset: felt,
    _accountant: felt,
    _ticker_usdfiat: felt
    ):
    reserve_asset.write(_reserve_asset)
    backed_asset.write(_backed_asset)
    accountant.write(_accountant)
end

#
# Public Setters
#
@external
func deposit{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(
        _amount: felt
    ):
    # Validate input amount.
    # Check ERC20 approval of msg.sender.
    # Check that deposit limit for this reserve has not been reached.
    # Transfer reserveAsset amount to this contract.
    # Mint in accountant the deposit amount.
    # Increase total deposits in this house of reserve.
    # Emit a deposit event.
end

@external
func withdraw{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(
        _amount: felt
    ):
    # Validate input amount is greater than zero, user has reserve deposits, and withdraw amount is less than msg.sender reserve deposits.
    # Compute msg.sender max withdrawal amount
    # Check max withdrawal amount is greater than or equal to the withdraw amount.
    # Burn withdraw amount in accountant.
    # Transfer amount to msg.sender
end

#
# Admin Setters
#


#
# Getters
#
    


