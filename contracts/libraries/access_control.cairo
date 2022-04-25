%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

@storage_var
func AccessControl_minter() -> (minter: felt):
end

@storage_var
func AccessControl_burner() -> (burner: felt):
end

func AccessControl_initializer{
        syscall_ptr : felt*, 
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(minter: felt, burner: felt):
    AccessControl_minter.write(minter)
    AccessControl_burner.write(burner)
    return ()
end

func AccessControl_set_minter{
        syscall_ptr : felt*, 
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(minter: felt):
    # TODO: only owner
    AccessControl_minter.write(minter)
    return ()
end

func AccessControl_only_minter{
        syscall_ptr : felt*, 
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }():
    let (minter) = AccessControl_minter.read()
    let (caller) = get_caller_address()
    with_attr error_message("AccessControl: caller is not the minter"):
        assert minter = caller
    end
    return ()
end

func AccessControl_set_burner{
        syscall_ptr : felt*, 
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(minter: felt):
    # TODO: only owner
    AccessControl_burner.write(minter)
    return ()
end

func AccessControl_only_burner{
        syscall_ptr : felt*, 
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }():
    let (burner) = AccessControl_burner.read()
    let (caller) = get_caller_address()
    with_attr error_message("AccessControl: caller is not the burner"):
        assert burner = caller
    end
    return ()
end

