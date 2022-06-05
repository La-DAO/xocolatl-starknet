%lang starknet

from starkware.cairo.common.math_cmp import is_le
from starkware.cairo.common.pow import pow
from contracts.interfaces.IOracle import IOracle

const ORACLE_PROXY_ADDRESS = 0x013befe6eda920ce4af05a50a67bd808d67eee6ba47bb0892bef2d630eaf1bba
const KEY = 28556963468900462  # str_to_felt("eth/mxn")
const AGGREGATION_MODE = 120282243752302 # str_to_felt("median")

@view
func check_eth_mxn_threshold{
    syscall_ptr : felt*,
    range_check_ptr
}(threshold : felt) -> (is_above_threshold : felt):
    alloc_locals

    let (decimals) = IOracle.get_decimals(ORACLE_PROXY_ADDRESS, KEY)
    let (multiplier) = pow(10, decimals)

    let (eth_price, timestamp) = IOracle.get_value(ORACLE_PROXY_ADDRESS, KEY, AGGREGATION_MODE)

    let shifted_threshold = threshold * multiplier
    let (is_above_threshold) = is_le(shifted_threshold, eth_price)
    return (is_above_threshold)
end

@view
func check_eth_mxn_price{
    syscall_ptr : felt*,
    range_check_ptr
}() -> (price : felt):
    alloc_locals
    let (eth_price, timestamp) = IOracle.get_value(ORACLE_PROXY_ADDRESS, KEY, AGGREGATION_MODE)
    return (eth_price)
end