module package_a::a {

  use sui::object;
  use sui::tx_context::TxContext;
  use sui::object::UID;
  use sui::transfer;
  use sui::tx_context;

  struct Counter has key {
    id: UID,
    count: u64
  }

  fun init(ctx: &mut TxContext) {
    let sharedCounter = Counter {
      id: object::new(ctx),
      count: 0
    };
    let freezeCounter = Counter {
      id: object::new(ctx),
      count: 100
    };
    let ownedCounter   = Counter {
      id: object::new(ctx),
      count: 200
    };
    transfer::share_object(sharedCounter);
    transfer::freeze_object(freezeCounter);
    transfer::transfer(ownedCounter, tx_context::sender(ctx));
  }

  public fun increment_by(counter: &mut Counter, amount: u64) {
    counter.count = counter.count + amount;
  }
}
