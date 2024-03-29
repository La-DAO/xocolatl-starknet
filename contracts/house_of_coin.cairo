%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256

from starkware.starknet.common.syscalls import get_caller_address

from contracts.interfaces.house_of_reserve import IHouseOfReserve
from contracts.interfaces.oracle import IOracle
from contracts.interfaces.erc1155 import IERC1155

struct Oracle:
    member address : felt
    member key : felt
end

@storage_var
func backed_asset_storage() -> (name: felt):
end

@storage_var
func accountant_storage() -> (symbol: felt):
end

@storage_var
func backed_token_id_storage(reserve_asset: felt, backed_asset: felt) -> (id: felt):
end

@storage_var
func next_backed_token_id_storage() -> (id: felt):
end

@storage_var
func oracle_storage() -> (oracle: (felt, felt)):
end

@constructor
func constructor{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(
        backed: felt,
        accountant: felt
    ):
    backed_asset_storage.write(backed)
    accountant_storage.write(accountant)
    oracle_storage.write((0x039d1bb4904cef28755c59f081cc88a576ecdf42240fb73dd44ddd003848ce33, 28556963469423460))
    next_backed_token_id_storage.write(1)
    return ()
end

#
# Getters
#

@view
func backed_asset{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }() -> (backed_asset: felt):
    let (backed_asset: felt) = backed_asset_storage.read()
    return (backed_asset)
end

@view
func backed_token_id{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(reserve_asset: felt, backed_asset: felt) -> (id: felt):
    let (id: felt) = backed_token_id_storage.read(reserve_asset=reserve_asset, backed_asset=backed_asset)
    return (id)
end

#
# Externals
#

@external
func set_backed_token_id{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(
        reserve_asset: felt,
        backed_asset: felt
     ):
    let (id) = backed_token_id_storage.read(reserve_asset=reserve_asset, backed_asset=backed_asset)

    if id == 0:
        let (next_id) = next_backed_token_id_storage.read()
        let next_id_plus_one = next_id + 1
        next_backed_token_id_storage.write(next_id_plus_one)
        tempvar syscall_ptr = syscall_ptr
        tempvar pedersen_ptr = pedersen_ptr
        tempvar range_check_ptr = range_check_ptr
    else:
        tempvar syscall_ptr = syscall_ptr
        tempvar pedersen_ptr = pedersen_ptr
        tempvar range_check_ptr = range_check_ptr
    end

    return ()
end

@external
func mint_coin{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(
        reserve_asset: felt,
        house_of_reserve: felt,
        amount: Uint256
     ):
    alloc_locals
    let (caller) = get_caller_address()

    # verify backed_asset is a valid asset

    let (reserve_token_id) = IHouseOfReserve.reserve_token_id(contract_address=house_of_reserve)
    let (backed_asset) = backed_asset_storage.read()
    let (backed_token_id) = backed_token_id_storage.read(reserve_asset, backed_asset)

    let (numertor, denominator) = IHouseOfReserve.collateral_ratio(contract_address=house_of_reserve)

    # fetch price
    let (oracle) = oracle_storage.read()
    let (price, timestamp) = IOracle.get_value(contract_address=oracle[0], key=oracle[1])



    return ()
end

func _balances{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(
        user: felt,
        reserve_token_id: felt,
        backed_token_id: felt
    ) -> (reserve_bal: felt, minted_coin_bal: felt):
    let (accountant) = accountant_storage.read()
    let (reserve_bal) = IERC1155.balanceOf(accountant, user, reserve_asset_id)
    let (minted_coin_bal) = IERC1155.balanceOf(accountant, user, backed_asset_id)

    return (reserve_bal, minted_coin_bal)
end

func _check_remaining_minting_power{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(
        user: felt,
        reserve_token_id: felt,
        backed_token_id: felt
        collat_ratio: (felt, felt),
        price: felt
     ):

     let (reserve_bal, minted_coin_bal) = _balances(user, reserve_token_id, backed_token_id)

     let reserve_bal_reduced_by_factor = (reserve_bal * collat_ratio[1]) / collat_ratio[0]

     let max_mintable_amount - reserve_bal_reduced_by_factor * price / 1e18

     return ()
end
