/// A simple constant product AMM pool
#[allow(unused_const, lint(self_transfer))]
module starter_defi::pool {
    use sui::balance::{Self, Balance};
    use sui::coin::{Self, Coin};

    // ====== Error Codes ======
    const EInsufficientLiquidity: u64 = 0;
    const EInsufficientAmount: u64 = 1;
    const ESlippageExceeded: u64 = 2;

    // ====== Constants ======
    const FEE_DENOMINATOR: u64 = 10000;
    const FEE_NUMERATOR: u64 = 30; // 0.3% fee

    // ====== Structs ======

    /// Liquidity pool for two token types
    public struct Pool<phantom X, phantom Y> has key {
        id: UID,
        balance_x: Balance<X>,
        balance_y: Balance<Y>,
        lp_supply: u64,
    }

    /// LP token representing pool ownership
    public struct LPToken<phantom X, phantom Y> has key, store {
        id: UID,
        amount: u64,
    }

    // ====== Public Functions ======

    /// Create a new liquidity pool
    public fun create_pool<X, Y>(ctx: &mut TxContext) {
        let pool = Pool<X, Y> {
            id: object::new(ctx),
            balance_x: balance::zero(),
            balance_y: balance::zero(),
            lp_supply: 0,
        };
        transfer::share_object(pool);
    }

    /// Add liquidity to the pool
    public fun add_liquidity<X, Y>(
        pool: &mut Pool<X, Y>,
        coin_x: Coin<X>,
        coin_y: Coin<Y>,
        ctx: &mut TxContext
    ) {
        let amount_x = coin_x.value();
        let amount_y = coin_y.value();

        assert!(amount_x > 0 && amount_y > 0, EInsufficientAmount);

        let lp_amount = if (pool.lp_supply == 0) {
            // First liquidity provider
            (amount_x * amount_y).sqrt()
        } else {
            // Subsequent providers: mint proportional to existing ratio
            let lp_from_x = (amount_x * pool.lp_supply) / pool.balance_x.value();
            let lp_from_y = (amount_y * pool.lp_supply) / pool.balance_y.value();
            if (lp_from_x < lp_from_y) lp_from_x else lp_from_y
        };

        coin::put(&mut pool.balance_x, coin_x);
        coin::put(&mut pool.balance_y, coin_y);
        pool.lp_supply = pool.lp_supply + lp_amount;

        let lp_token = LPToken<X, Y> {
            id: object::new(ctx),
            amount: lp_amount,
        };
        transfer::transfer(lp_token, ctx.sender());
    }

    /// Swap X for Y
    public fun swap_x_to_y<X, Y>(
        pool: &mut Pool<X, Y>,
        coin_x: Coin<X>,
        ctx: &mut TxContext
    ) {
        let amount_in = coin_x.value();
        assert!(amount_in > 0, EInsufficientAmount);

        // Calculate output with fee: y_out = (y * x_in * 9970) / (x * 10000 + x_in * 9970)
        let reserve_x = pool.balance_x.value();
        let reserve_y = pool.balance_y.value();
        let amount_in_with_fee = amount_in * (FEE_DENOMINATOR - FEE_NUMERATOR);
        let amount_out = (reserve_y * amount_in_with_fee) / (reserve_x * FEE_DENOMINATOR + amount_in_with_fee);

        assert!(amount_out > 0 && amount_out < reserve_y, EInsufficientLiquidity);

        coin::put(&mut pool.balance_x, coin_x);
        let coin_out = coin::take(&mut pool.balance_y, amount_out, ctx);
        transfer::public_transfer(coin_out, ctx.sender());
    }

    /// Swap Y for X
    public fun swap_y_to_x<X, Y>(
        pool: &mut Pool<X, Y>,
        coin_y: Coin<Y>,
        ctx: &mut TxContext
    ) {
        let amount_in = coin_y.value();
        assert!(amount_in > 0, EInsufficientAmount);

        let reserve_x = pool.balance_x.value();
        let reserve_y = pool.balance_y.value();
        let amount_in_with_fee = amount_in * (FEE_DENOMINATOR - FEE_NUMERATOR);
        let amount_out = (reserve_x * amount_in_with_fee) / (reserve_y * FEE_DENOMINATOR + amount_in_with_fee);

        assert!(amount_out > 0 && amount_out < reserve_x, EInsufficientLiquidity);

        coin::put(&mut pool.balance_y, coin_y);
        let coin_out = coin::take(&mut pool.balance_x, amount_out, ctx);
        transfer::public_transfer(coin_out, ctx.sender());
    }

    /// Remove liquidity from pool
    public fun remove_liquidity<X, Y>(
        pool: &mut Pool<X, Y>,
        lp_token: LPToken<X, Y>,
        ctx: &mut TxContext
    ) {
        let LPToken { id, amount } = lp_token;
        object::delete(id);

        let reserve_x = pool.balance_x.value();
        let reserve_y = pool.balance_y.value();

        let amount_x = (reserve_x * amount) / pool.lp_supply;
        let amount_y = (reserve_y * amount) / pool.lp_supply;

        pool.lp_supply = pool.lp_supply - amount;

        let coin_x = coin::take(&mut pool.balance_x, amount_x, ctx);
        let coin_y = coin::take(&mut pool.balance_y, amount_y, ctx);

        transfer::public_transfer(coin_x, ctx.sender());
        transfer::public_transfer(coin_y, ctx.sender());
    }

    // ====== View Functions ======

    public fun get_reserves<X, Y>(pool: &Pool<X, Y>): (u64, u64) {
        (pool.balance_x.value(), pool.balance_y.value())
    }

    public fun get_lp_supply<X, Y>(pool: &Pool<X, Y>): u64 {
        pool.lp_supply
    }
}
