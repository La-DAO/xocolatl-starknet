# SPDX-License-Identifier: MIT
%lang starknet

####################
# INTERFACE
####################

from starkware.cairo.common.uint256 import Uint256

@contract_interface
namespace IERC1155:
    func balanceOf(user: felt, id: Uint256) -> (balance: Uint256):
    end
end

