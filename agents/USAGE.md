# SUI Agent System - Usage Guide

Complete guide to using the SUI hierarchical agent system.

## Quick Start

### Invoke Supreme Agent

For any SUI development task, start with `sui-supreme`:

```typescript
Task({
  subagent_type: "sui-supreme",
  prompt: "Build an NFT marketplace with Kiosk integration",
  description: "NFT marketplace build"
})
```

The supreme agent will:
1. Analyze your request
2. Decompose into subtasks
3. Route to appropriate category agents
4. Coordinate execution
5. Report completion with artifacts

### Direct Category Agent Invocation

For specific phases, invoke category agents directly:

```typescript
// Architecture only
Task({
  subagent_type: "sui-development-agent",
  prompt: "Generate architecture for a DeFi AMM",
  description: "AMM architecture"
})

// Documentation query
Task({
  subagent_type: "sui-infrastructure-agent",
  prompt: "Query latest Walrus API documentation",
  description: "Walrus docs"
})

// Ecosystem integration
Task({
  subagent_type: "sui-ecosystem-agent",
  prompt: "Integrate zkLogin authentication",
  description: "zkLogin integration"
})
```

## Agent Hierarchy

```
sui-supreme (Use for: Any SUI task, complete projects)
├── sui-core-agent (Use for: Full-stack projects)
├── sui-infrastructure-agent (Use for: Docs, security)
├── sui-development-agent (Use for: Architecture, code, tests, deploy)
└── sui-ecosystem-agent (Use for: Kiosk, Walrus, zkLogin, etc.)
```

## State Management

All agents maintain global state in `.claude/sui-agent-state.json`.

### Initialize State

```typescript
import { StateManager } from './agents/lib/state-manager';

const stateManager = new StateManager();
stateManager.initialize({
  name: 'my-nft-marketplace',
  type: 'NFT',
  phase: 'planning'
});
```

### Read State

```typescript
const state = stateManager.getState();
console.log(`Project: ${state.project.name}`);
console.log(`Phase: ${state.project.phase}`);
console.log(`Agents working: ${Object.keys(state.agents).length}`);
```

### Update State

Agents automatically update state, but you can also update manually:

```typescript
stateManager.updatePhase('development');
stateManager.addArtifact('specs', 'docs/specs/marketplace-spec.md');
stateManager.addIntegration('kiosk');
```

## Agent Communication

Agents communicate via the MessageBroker.

### Send Message to Agent

```typescript
import { MessageBroker } from './agents/lib/message-broker';

const broker = new MessageBroker();

broker.send({
  type: 'service_request',
  from: 'sui-developer-subagent',
  to: 'sui-docs-query-subagent',
  payload: {
    query: 'Latest SUI Kiosk transfer policy API'
  },
  timestamp: new Date().toISOString()
});
```

### Receive Messages

```typescript
const messages = await broker.receive('sui-docs-query-subagent');
messages.forEach(msg => {
  console.log(`From: ${msg.from}, Type: ${msg.type}`);
  console.log(`Payload:`, msg.payload);

  // Process and acknowledge
  broker.acknowledge(msg.id!);
});
```

## Common Workflows

### 1. Complete Project Build

```typescript
// Let sui-supreme orchestrate everything
Task({
  subagent_type: "sui-supreme",
  prompt: `Build a complete DeFi AMM with:
- Token swap functionality
- Liquidity pools
- Farming rewards
- DeepBook integration`,
  description: "DeFi AMM complete build"
})
```

### 2. Security Scan + Fix

```typescript
// Scan for vulnerabilities
Task({
  subagent_type: "sui-infrastructure-agent",
  prompt: "Scan contracts/ directory for security issues (strict mode)",
  description: "Security scan"
});

// After receiving results, fix issues
Task({
  subagent_type: "sui-development-agent",
  prompt: "Fix security vulnerabilities identified in scan report",
  description: "Security fixes"
});
```

## Best Practices

1. **Always use sui-supreme for complex tasks** - It handles task decomposition and coordination
2. **Let agents update state** - Don't manually edit state file
3. **Monitor state file** - Check `.claude/sui-agent-state.json` for progress
4. **Use specific prompts** - "Build NFT marketplace with Kiosk" vs "build app"
5. **Check artifacts** - Verify output files in `state.artifacts`

## Troubleshooting

### Agent Not Found

If you get "Unknown subagent_type" error:

```bash
# Re-register agents
./agents/register-agents.sh

# Verify registration
cat ~/.config/claude-code/custom-agents.json | grep sui-supreme
```

### State File Corrupt

```bash
# Backup corrupt state
mv .claude/sui-agent-state.json .claude/sui-agent-state.json.bak

# Initialize fresh state
# Agents will auto-initialize on next invocation
```

## Reference

- Agent Definitions: `agents/*/`
- State Schema: `agents/supreme/state-schema.json`
- Message Types: `agents/lib/message-broker.ts`
- Integration Tests: `agents/tests/`
