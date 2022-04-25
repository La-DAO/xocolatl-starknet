%lang starknet

####################
# INTERFACE
####################

@contract_interface
namespace IHouseOfReserve:
    func reserve_asset() -> (asset: felt):
    end
    func backed_asset() -> (asset: felt):
    end
    func collateral_ratio() -> (numerator: felt, denominator: felt):
    end
    func reserve_token_id() -> (id: felt):
    end
end

