# SPDX-License-Identifier: MIT
%lang starknet

####################
# INTERFACE
####################

from starkware.cairo.common.uint256 import Uint256

@contract_interface
namespace IHouse_of_reserve:
    func reserve_asset() -> (asset: felt):
    end
    func backed_asset() -> (asset: felt):
    end
    func reserve_token_id() -> (id: Uint256):
    end
    func collateral_ratio() -> (numerator: Uint256, denominator: Uint256):
    end 
end
