# Starter DeFi - SUI Move AMM Example

A minimal constant product AMM (Automated Market Maker) implementation on SUI.

## What's Included

- **Liquidity Pool**: Two-token constant product pool (x * y = k)
- **Add Liquidity**: Provide tokens and receive LP tokens
- **Swap**: Exchange one token for another with 0.3% fee
- **LP Tokens**: Fungible tokens representing pool ownership
- **Tests**: Example test cases for core functions

## Directory Structure

```
starter-defi/
├── Move.toml           # Package configuration
├── sources/
│   └── pool.move      # AMM pool module
└── tests/
    └── pool_tests.move # Test cases (optional)
```

## Quick Start

### Build
```bash
sui move build
```

### Test
```bash
sui move test
```

### Deploy
```bash
sui client publish --gas-budget 100000000
```

## Key Components

### Pool Struct
- Holds reserves of two token types
- Tracks total LP token supply
- Implements constant product formula

### Functions
- `create_pool<X, Y>()` - Initialize a new liquidity pool
- `add_liquidity<X, Y>(pool, coin_x, coin_y)` - Add liquidity and mint LP tokens
- `swap_x_to_y<X, Y>(pool, coin_x)` - Swap token X for token Y
- `swap_y_to_x<X, Y>(pool, coin_y)` - Swap token Y for token X
- `remove_liquidity<X, Y>(pool, lp_token)` - Burn LP tokens and withdraw liquidity

## Fee Structure

- 0.3% swap fee (30 basis points)
- Fees are added to pool reserves
- LP token holders benefit from accumulated fees
