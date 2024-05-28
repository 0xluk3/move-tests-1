module 0xd0ae523700df49008cebe4cde4463e0c26b76376c21e0b93a6b252bc206ba971::RatingModuleTest {
    use 0xd0ae523700df49008cebe4cde4463e0c26b76376c21e0b93a6b252bc206ba971::RatingModule;
    use std::vector;
    use std::debug;


     #[test(account = @0xd0ae523700df49008cebe4cde4463e0c26b76376c21e0b93a6b252bc206ba971)]
    public fun test_one(account: &signer) {

        RatingModule::create_item(account);

        let i: u64 = 1;
        while (i <= 100_000) {
            RatingModule::add_rate(i)
        };
        
        let rates = RatingModule::list_rates();
        debug::print(&rates);

    }

}