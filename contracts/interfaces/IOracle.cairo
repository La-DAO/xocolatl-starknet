%lang starknet

struct Entry:
    member key : felt  # UTF-8 encoded lowercased string, e.g. "eth/usd"
    member value : felt
    member timestamp : felt
    member publisher : felt
end

@contract_interface
namespace IOracle:
    #
    # Getters
    #

    func get_admin_address() -> (admin_address : felt):
    end

    func get_publisher_registry_address() -> (publisher_registry_address : felt):
    end

    func get_active_oracle_implementation_addresses() -> (
            oracle_addresses_len : felt, oracle_addresses : felt*):
    end

    func get_oracle_implementation_address(idx : felt) -> (oracle_implementation_address : felt):
    end

    func get_primary_oracle_implementation_address() -> (
            primary_oracle_implementation_address : felt):
    end

    #
    # Setters
    #

    func set_admin_address(new_address : felt):
    end

    func update_publisher_registry_address(publisher_registry_address : felt):
    end

    func add_oracle_implementation_address(oracle_implementation_address : felt):
    end

    func update_oracle_implementation_active_status(
            oracle_implementation_address : felt, is_active : felt):
    end

    func set_primary_oracle_implementation_address(primary_oracle_implementation_address : felt):
    end

    #
    # Oracle Implementation Controller Functions
    #

    func get_decimals(key : felt) -> (decimals : felt):
    end

    func get_entries(key : felt) -> (entries_len : felt, entries : Entry*):
    end

    func get_value(key : felt, aggregation_mode : felt) -> (
            value : felt, last_updated_timestamp : felt):
    end

    #
    # Setters
    #

    func set_decimals(key : felt, decimals : felt):
    end

    func submit_entry(new_entry : Entry):
    end

    func submit_many_entries(new_entries_len : felt, new_entries : Entry*):
    end
end