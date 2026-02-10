# SUI Frontend Subagent

Execute the **sui-frontend** skill to build TypeScript frontend.

## Platform Version

SDK: `@mysten/sui` (not `@mysten/sui.js`), `Transaction` (not `TransactionBlock`), `useSignAndExecuteTransaction` (not `useSignAndExecuteTransactionBlock`). v1.65.1 (Protocol 110): gRPC (GA, primary), GraphQL (beta, frontend/indexer), JSON-RPC (**deprecated**, removed April 2026). Balance API split (coinBalance/addressBalance).

## Instructions

1. Read architecture spec and Move contracts
2. Invoke sui-frontend skill using Skill tool
3. Generate React components and TypeScript SDK integration (use `@mysten/sui`, `Transaction`)
4. Generate types from Move ABI
5. Test frontend compilation
6. Report completion with frontend artifacts
