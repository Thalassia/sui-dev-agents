# [Your Project Name] - SUI Move Project

## Project Overview
<!-- Describe your project's purpose and main features -->
A SUI Move smart contract project for [brief description].

## Project Structure
```
sources/          # Move modules
tests/           # Move test files
Move.toml        # Package configuration
```

## SUI Move Coding Conventions

### Module Structure
- One primary module per file
- Use `sui::object::UID` for all objects
- Always include `has key` for owned objects, `has key, has store` for tradeable objects
- Use `sui::tx_context::TxContext` for transaction context

### Naming Conventions
- Modules: snake_case (e.g., `my_module`)
- Structs: PascalCase (e.g., `MyNFT`)
- Functions: snake_case (e.g., `mint_nft`)
- Constants: SCREAMING_SNAKE_CASE (e.g., `MIN_STAKE_AMOUNT`)

### Error Handling
- Define error constants: `const ENotAuthorized: u64 = 0;`
- Use `assert!()` for validations
- Document error meanings in comments

### Object Ownership Patterns
- Owned objects: `transfer::transfer(obj, recipient)`
- Shared objects: `transfer::share_object(obj)`
- Frozen objects: `transfer::freeze_object(obj)`

### Capabilities Pattern
- Use capability objects for admin/privileged operations
- Transfer capabilities carefully (usually to deployer only)

## sui-dev-agents Plugin Commands

This project supports the following Claude Code skills:

### Code Quality
- `/move-code-quality` - Static analysis and best practices check
- `/move-security-audit` - Security vulnerability scanning

### Development
- `/move-build` - Build the Move package
- `/move-test` - Run all tests with verbose output
- `/move-publish` - Publish to network (prompts for network selection)

### Documentation
- `/move-docs` - Generate module documentation

## Testing Workflow

### Local Testing
```bash
sui move test
sui move test --filter test_name
sui move test -v  # verbose output
```

### Test Organization
- Unit tests in `tests/` directory
- Use `#[test]` for normal tests
- Use `#[test_only]` for test helper functions
- Test error cases with `#[expected_failure]`

## Deployment Checklist

### Pre-deployment
- [ ] Run `sui move build` successfully
- [ ] All tests pass: `sui move test`
- [ ] Security audit completed
- [ ] Code quality check passed
- [ ] Update Move.toml version
- [ ] Document all public functions

### Deployment Steps
1. Select target network (devnet/testnet/mainnet)
2. Ensure sufficient SUI balance for gas
3. Run `/move-publish` or `sui client publish --gas-budget 100000000`
4. Save package ID and object IDs
5. Verify deployment on SUI Explorer

### Post-deployment
- [ ] Test core functions on-chain
- [ ] Update README with package ID
- [ ] Document deployed object addresses
- [ ] Set up monitoring/alerts if needed
