module 0xa2ebf6349b00112c696676ad9a9cc26c1f146f7a86c0485ef8629e310a3f2424::ACTest {
    use std::signer;
    use std::debug; 
    use std::string; 
    use 0xa2ebf6349b00112c696676ad9a9cc26c1f146f7a86c0485ef8629e310a3f2424::AccessControlModule;


    #[test(caller = @0xdeadbeef)]
    #[expected_failure]
    public fun test_access_control(caller: &signer) {
        let message: vector<u8> = b"Signer check function";
        debug::print(&string::utf8(message));
        AccessControlModule::check_signer(caller);
    }//0xdeadbeef is not the owner, so abort

    #[test(caller = @0xdeadbeef)]
    #[expected_failure]
    public fun test_capability_one(caller: &signer) {
        let message: vector<u8> = b"Capability check function one";
        debug::print(&string::utf8(message));
        let user_addr = signer::address_of(caller);
        AccessControlModule::check_capability(user_addr);
    }//0xdeadbeef has no capability, so abort

    #[test(caller = @0xdeadbeef)]
    public fun test_capability_two(caller: &signer) {
        let message: vector<u8> = b"Capability check function two";
        debug::print(&string::utf8(message));

        AccessControlModule::grant_capability(caller);
        let user_addr = signer::address_of(caller);
        AccessControlModule::check_capability(user_addr);
    }//0xdeadbeef has now capability because he was given it, so pass

    #[test(firstacc = @0xcafebabe)]
    #[expected_failure]
    public fun test_owner_of_resource(firstacc: &signer) {

        let message: vector<u8> = b"Owner check function";
        debug::print(&string::utf8(message));

        AccessControlModule::create_resource(firstacc);
        let exists = AccessControlModule::check_resource(signer::address_of(firstacc));
        assert!(exists, 1); //abort if not exist

        AccessControlModule::check_owner(@0xcafebabe, signer::address_of(firstacc)); //OK
        AccessControlModule::check_owner(@0xbaadf00d, signer::address_of(firstacc)); //Here it aborts, becaise 0xbaadf00d is not the owner

    }

}