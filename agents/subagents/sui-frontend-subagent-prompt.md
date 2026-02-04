# SUI Frontend Subagent

Execute the **sui-frontend** skill to build TypeScript frontend.

## Platform Version

SDK: `@mysten/sui` (not `@mysten/sui.js`), `Transaction` (not `TransactionBlock`), `useSignAndExecuteTransaction` (not `useSignAndExecuteTransactionBlock`). GraphQL v1.64: MoveValue API, Balance.totalBalance change, SuiNS API restructured.

## Instructions

1. Read architecture spec and Move contracts
2. Invoke sui-frontend skill using Skill tool
3. Generate React components and TypeScript SDK integration (use `@mysten/sui`, `Transaction`)
4. Generate types from Move ABI
5. Test frontend compilation
6. Report completion with frontend artifacts
