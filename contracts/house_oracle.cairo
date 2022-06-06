# SPDX-License-Identifier: MIT
%lang starknet

from contracts.interfaces.IOracle import IOracle
from starkware.cairo.common.math import assert_not_zero

# const ORACLE_PROXY_ADDRESS = 0x013befe6eda920ce4af05a50a67bd808d67eee6ba47bb0892bef2d630eaf1bba
const ETH_MXN_KEY = 28556963468900462  # str_to_felt("eth/mxn")
const AGGREGATION_MODE = 120282243752302 # str_to_felt("median")

@storage_var
func oracle_proxy_address() -> (address: felt):
end

#
# Admin setters
#
@external
func set_oracle_proxy_address{
        syscall_ptr : felt*,
        range_check_ptr
    }(
        _address: felt
    ):
    with_attr error_message("Invalid input!"):
        assert_not_zero(_address)
    end
    oracle_proxy_address.write(_address);
end

#
# Getters
#
@view
func check_eth_mxn_price{
    syscall_ptr : felt*,
    range_check_ptr
}() -> (price : felt):
    alloc_locals
    let (proxy) = oracle_proxy_address.read()
    let (price, timestamp) = IOracle.get_value(proxy, ETH_MXN_KEY, AGGREGATION_MODE)
    let (decimals) = IOracle.get_decimals(proxy, ETH_MXN_KEY)
    return (price, decimals)
end