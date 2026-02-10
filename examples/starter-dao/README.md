# Starter DAO - SUI Move Governance Example

A minimal DAO (Decentralized Autonomous Organization) governance implementation on SUI.

## What's Included

- **Proposal System**: Create and manage governance proposals
- **Voting Mechanism**: Token-weighted voting system
- **Execution**: Automatic execution when threshold is met
- **Membership**: Token-based membership tracking
- **Tests**: Example test cases for governance flow

## Directory Structure

```
starter-dao/
├── Move.toml           # Package configuration
├── sources/
│   └── dao.move       # DAO governance module
└── tests/
    └── dao_tests.move # Test cases (optional)
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

### DAO Struct
- Manages proposals and voting
- Tracks members and voting power
- Enforces execution threshold

### Proposal Lifecycle
1. **Created**: Member submits proposal
2. **Voting**: Members vote for/against
3. **Executed**: Automatically executed if threshold met
4. **Rejected**: Fails if threshold not met by deadline

### Functions
- `create_dao(name, threshold)` - Initialize a new DAO
- `create_proposal(dao, description, action)` - Submit a proposal
- `vote(dao, proposal_id, approve)` - Cast a vote
- `execute_proposal(dao, proposal_id)` - Execute approved proposal

## Voting Rules

- One token = one vote
- Simple majority or custom threshold
- Proposals have execution deadline
- Votes are final (no changes after casting)
