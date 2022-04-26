%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from contracts.interfaces.erc1155 import IERC1155

@storage_var
func reserve_asset() -> (name: felt):
end

@storage_var
func backed_asset() -> (name: felt):
end

@storage_var
func reserve_token_id() -> (name: felt):
end

@storage_var
func backed_token_id() -> (name: felt):
end

@storage_var
func collateral_ratio() -> (numerator: felt, denominator: felt):
end


