# SUI gRPC API Reference

> **Status:** GA (Generally Available) as of SUI v1.65
> **JSON-RPC:** Deprecated, will be removed April 2026
> **Default port:** 8443 (TLS) or 8080 (plaintext)

## Overview

SUI full nodes now expose gRPC as the primary API interface, replacing the deprecated JSON-RPC. The gRPC API provides 7 services covering all blockchain interaction needs.

## gRPC Services

### 1. TransactionExecutionService
Execute and submit transactions to the network.

```protobuf
service TransactionExecutionService {
  rpc ExecuteTransaction(ExecuteTransactionRequest) returns (ExecuteTransactionResponse);
  rpc SimulateTransaction(SimulateTransactionRequest) returns (SimulateTransactionResponse);
}
```

**Replaces:** `sui_executeTransactionBlock`, `sui_dryRunTransactionBlock`

### 2. LedgerService
Query blockchain ledger data (checkpoints, transactions, epochs).

```protobuf
service LedgerService {
  rpc GetCheckpoint(GetCheckpointRequest) returns (Checkpoint);
  rpc GetTransaction(GetTransactionRequest) returns (TransactionResponse);
  rpc GetEpoch(GetEpochRequest) returns (EpochInfo);
  rpc GetLatestCheckpoint(Empty) returns (Checkpoint);
}
```

**Replaces:** `sui_getCheckpoint`, `sui_getTransactionBlock`, `sui_getLatestCheckpointSequenceNumber`

### 3. StateService
Query on-chain state (objects, balances, coins, dynamic fields).

```protobuf
service StateService {
  rpc GetObject(GetObjectRequest) returns (ObjectResponse);
  rpc MultiGetObjects(MultiGetObjectsRequest) returns (MultiGetObjectsResponse);
  rpc GetOwnedObjects(GetOwnedObjectsRequest) returns (OwnedObjectsResponse);
  rpc GetCoins(GetCoinsRequest) returns (CoinsResponse);
  rpc GetBalance(GetBalanceRequest) returns (BalanceResponse);
  rpc GetDynamicFields(GetDynamicFieldsRequest) returns (DynamicFieldsResponse);
}
```

**Replaces:** `sui_getObject`, `sui_multiGetObjects`, `suix_getOwnedObjects`, `suix_getCoins`, `suix_getBalance`, `suix_getDynamicFields`

### 4. SubscriptionService
Real-time streaming for events and transactions.

```protobuf
service SubscriptionService {
  rpc SubscribeEvents(SubscribeEventsRequest) returns (stream EventResponse);
  rpc SubscribeTransactions(SubscribeTransactionsRequest) returns (stream TransactionResponse);
}
```

**Replaces:** WebSocket `suix_subscribeEvent`, `suix_subscribeTransaction`

### 5. MovePackageService
Query Move packages, modules, and ABIs.

```protobuf
service MovePackageService {
  rpc GetPackage(GetPackageRequest) returns (MovePackage);
  rpc GetNormalizedModule(GetNormalizedModuleRequest) returns (NormalizedMoveModule);
  rpc GetNormalizedFunction(GetNormalizedFunctionRequest) returns (NormalizedMoveFunction);
}
```

**Replaces:** `sui_getNormalizedMoveModule`, `sui_getNormalizedMoveFunction`

### 6. SignatureVerificationService
Verify transaction signatures off-chain.

```protobuf
service SignatureVerificationService {
  rpc VerifySignature(VerifySignatureRequest) returns (VerifySignatureResponse);
}
```

### 7. NameService
Resolve SuiNS names.

```protobuf
service NameService {
  rpc ResolveName(ResolveNameRequest) returns (ResolveNameResponse);
  rpc ReverseResolve(ReverseResolveRequest) returns (ReverseResolveResponse);
}
```

**Replaces:** `suix_resolveNameServiceAddress`, `suix_resolveNameServiceNames`

## Connection

### Endpoint URLs

| Network | gRPC Endpoint |
|---------|--------------|
| Mainnet | `grpc.mainnet.sui.io:443` |
| Testnet | `grpc.testnet.sui.io:443` |
| Devnet  | `grpc.devnet.sui.io:443` |
| Local   | `localhost:8080` (plaintext) |

### grpcurl Examples

```bash
# List services
grpcurl grpc.testnet.sui.io:443 list

# Get latest checkpoint
grpcurl grpc.testnet.sui.io:443 sui.ledger.v1.LedgerService/GetLatestCheckpoint

# Get object
grpcurl -d '{"object_id": "0x..."}' grpc.testnet.sui.io:443 sui.state.v1.StateService/GetObject

# Subscribe to events (streaming)
grpcurl -d '{"filter": {"move_event_type": "0x2::coin::CoinEvent"}}' \
  grpc.testnet.sui.io:443 sui.subscription.v1.SubscriptionService/SubscribeEvents
```

### TypeScript (via @mysten/sui)

The `@mysten/sui` SDK abstracts the transport layer. When using `SuiClient`, the SDK handles gRPC/JSON-RPC selection automatically based on the endpoint:

```typescript
import { SuiClient } from '@mysten/sui/client';

// SDK handles transport automatically
const client = new SuiClient({ url: getFullnodeUrl('testnet') });

// Same API, gRPC transport under the hood
const object = await client.getObject({ id: '0x...' });
```

> **Note:** For custom RPC endpoints, ensure your node exposes gRPC. The SDK will use gRPC when available.

## Migration: JSON-RPC → gRPC

### Quick Reference

| JSON-RPC Method | gRPC Service.Method |
|----------------|-------------------|
| `sui_getObject` | `StateService.GetObject` |
| `sui_multiGetObjects` | `StateService.MultiGetObjects` |
| `suix_getOwnedObjects` | `StateService.GetOwnedObjects` |
| `suix_getCoins` | `StateService.GetCoins` |
| `suix_getBalance` | `StateService.GetBalance` |
| `suix_getDynamicFields` | `StateService.GetDynamicFields` |
| `sui_executeTransactionBlock` | `TransactionExecutionService.ExecuteTransaction` |
| `sui_dryRunTransactionBlock` | `TransactionExecutionService.SimulateTransaction` |
| `sui_getTransactionBlock` | `LedgerService.GetTransaction` |
| `sui_getCheckpoint` | `LedgerService.GetCheckpoint` |
| `sui_getNormalizedMoveModule` | `MovePackageService.GetNormalizedModule` |
| `suix_subscribeEvent` (WS) | `SubscriptionService.SubscribeEvents` (streaming) |
| `suix_subscribeTransaction` (WS) | `SubscriptionService.SubscribeTransactions` (streaming) |
| `suix_resolveNameServiceAddress` | `NameService.ResolveName` |

### Key Differences

1. **Streaming replaces WebSocket:** `subscribeEvent` WebSocket is replaced by gRPC server-streaming. No separate WS connection needed.
2. **Binary encoding:** gRPC uses protobuf (smaller, faster) vs JSON-RPC's JSON encoding.
3. **Multiplexing:** Multiple gRPC calls share one HTTP/2 connection.
4. **Type safety:** Protobuf definitions provide strong typing.

### SDK Users

If you use `@mysten/sui` SDK, **no code changes required** for most operations. The SDK handles transport selection. However:

- **`subscribeEvent` via WebSocket** is deprecated. The SDK now uses gRPC streaming internally.
- **Custom RPC middleware** that intercepts JSON-RPC payloads will need updating.
- **Direct `fetch()` calls** to JSON-RPC must be migrated.

## Data Access Architecture (v1.65+)

```
┌─────────────┐     ┌──────────────┐     ┌──────────────┐
│   gRPC      │     │  GraphQL     │     │  Indexer      │
│  (Primary)  │     │  (Beta)      │     │  (Custom)     │
├─────────────┤     ├──────────────┤     ├──────────────┤
│ Full node   │     │ Frontend     │     │ Analytics     │
│ Direct      │     │ Relay-style  │     │ Historical    │
│ Streaming   │     │ Flexible     │     │ Aggregation   │
│ Low-latency │     │ queries      │     │ Custom views  │
└─────────────┘     └──────────────┘     └──────────────┘
```

**Choose:**
- **gRPC** — Backend services, real-time subscriptions, transaction execution
- **GraphQL** — Frontend queries, complex object graphs, Relay integration
- **Indexer** — Historical analytics, custom aggregations, complex filters

## Indexing Changes (v1.65)

- Checkpoint data encoding changed from BCS to **zstd-compressed protobuf**
- Custom indexers using raw checkpoint data must update their deserialization
- Official indexer framework handles this automatically
