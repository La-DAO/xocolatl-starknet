%lang starknet

####################
# INTERFACE
####################

@contract_interface
namespace IERC1155:
    func balanceOf(user: felt, id: felt) -> (balance: felt):
    end
end

