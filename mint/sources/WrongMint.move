module 0x120faaaa8517b0b155c3aa5f1ffed804449e7541543053f7896dc9cc8f54e2a1::VulnerableMintModule {
    use std::signer;
    //use std::assert;

    struct Minted has key {
        amount: u64,
    }

    const ERROR_NOT_FOUND: u64 = 1;

    // Function to mint tokens, but stores in the user's account instead of the contract's account
    public entry fun mint(account: &signer, amount: u64) acquires Minted {
        let user_address = signer::address_of(account);

        if (exists<Minted>(user_address)) {
            let minted = borrow_global_mut<Minted>(user_address);
            minted.amount = minted.amount + amount;
        } else {
            move_to(account, Minted { amount: amount });
        }
    }

    // Function to check the balance, incorrectly assuming it's stored in the contract's storage
    public fun balance(account: address): u64 acquires Minted {
        if (exists<Minted>(@0x120faaaa8517b0b155c3aa5f1ffed804449e7541543053f7896dc9cc8f54e2a1)) {
            let minted = borrow_global<Minted>(@0x120faaaa8517b0b155c3aa5f1ffed804449e7541543053f7896dc9cc8f54e2a1);
            minted.amount
        } else {
            0
        }
    }


}
