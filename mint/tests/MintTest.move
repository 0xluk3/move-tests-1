module 0x120faaaa8517b0b155c3aa5f1ffed804449e7541543053f7896dc9cc8f54e2a1::MintTest {
    use 0x120faaaa8517b0b155c3aa5f1ffed804449e7541543053f7896dc9cc8f54e2a1::VulnerableMintModule as vulnmint;
    use std::signer;
    use std::debug; 
    use std::string;


    #[test(acc = @0xb0b0)]
    #[expected_failure]
        public fun test_vulnerable_mint(acc: &signer) {
        
        // User mints tokens
        vulnmint::mint(acc, 100);
        let bal = vulnmint::balance(signer::address_of(acc));
        //assert!(bal > 0, 1);
        if (bal == 0) { abort 0x1234 } //also revert, but written differently

    }
    
}
