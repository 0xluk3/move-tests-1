module 0xd0ae523700df49008cebe4cde4463e0c26b76376c21e0b93a6b252bc206ba971::RatingModule {
    use std::vector;

    // Define the Item struct
    struct Item has store, key {
        id: u64,
        rates: vector<u64>,
    }

    // Initialize the ItemHolder resource in the module's storage
    public fun create_item(account: &signer) {
        move_to(account, Item {
            id: 1,
            rates: vector::empty<u64>(),
        });
    }

    // Function to add a rate to the item with id 1
    public fun add_rate(rate: u64) acquires Item {
        let item_holder = borrow_global_mut<Item>(@0xd0ae523700df49008cebe4cde4463e0c26b76376c21e0b93a6b252bc206ba971);
        vector::push_back(&mut item_holder.rates, rate);
    } //TODO od tad jak wlasciwie to wypchnac 

    // Function to list all rates for the item with id 1
    public fun list_rates(): vector<u64> acquires Item {
        let item_ref = borrow_global<Item>(@0xd0ae523700df49008cebe4cde4463e0c26b76376c21e0b93a6b252bc206ba971);
        item_ref.rates
    }

   

}