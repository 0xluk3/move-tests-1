module 0xa2ebf6349b00112c696676ad9a9cc26c1f146f7a86c0485ef8629e310a3f2424::AccessControlModule {
    use std::signer;

    // Define a Capability struct
    struct DummyCapability has key {}

    // Define a Resource struct with an owner field
    struct Resource has key {
        owner: address,
    }

    const ERROR_CAPABILITY_NOT_FOUND: u64 = 1;
    const ERROR_NOT_OWNER: u64 = 2;
    const ERROR_NOT_SIGNER: u64 = 3;

    // Define the contract owner address
    const CONTRACT_OWNER: address = @0xa2ebf6349b00112c696676ad9a9cc26c1f146f7a86c0485ef8629e310a3f2424;

    // Function to grant capability to an account
    public fun grant_capability(account: &signer) {
        move_to(account, DummyCapability {});
    }

    // Function to create a resource with an owner
    public fun create_resource(account: &signer) {
        let resource = Resource { owner: signer::address_of(account) };
        move_to(account, resource);
    }

    // Capability check function
    public fun check_capability(account: address) {
        assert!(exists<DummyCapability>(account), ERROR_CAPABILITY_NOT_FOUND);
    }

    // Owner check function
    public fun check_owner(account: address, resource_address: address) acquires Resource {
        let resource = borrow_global<Resource>(resource_address);
        assert!(resource.owner == account, ERROR_NOT_OWNER);
    }

    // Signer check function
    public fun check_signer(account: &signer) {
        let address = signer::address_of(account);
        assert!(address == CONTRACT_OWNER, ERROR_NOT_SIGNER);
    }

    public fun check_resource(account: address): bool {
        exists<Resource>(account)
    }

    // Example public entry function demonstrating checks
    public entry fun perform_checks(account: &signer) acquires Resource {
        let address = signer::address_of(account);
        
        // Perform capability check
        check_capability(address);

        // Perform owner check
        check_owner(address, address);

        // Perform signer check
        check_signer(account);
    }


}
