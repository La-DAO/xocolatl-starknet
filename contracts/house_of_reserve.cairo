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
from contracts.interfaces.erc1155 import IERC1155

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

@constructor
func contructor{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(
    reserve_asset: felt,
    backed_asset: felt,
    accountant: felt,
    _ticker_usdfiat: felt
    


