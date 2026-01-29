# Agent Invocation Tests

Manual tests to verify agents can be invoked via Task tool.

## Test 1: Invoke sui-supreme

**Command:**
```typescript
Task({
  subagent_type: "sui-supreme",
  prompt: "Analyze this request: Build a simple token contract",
  description: "Test sui-supreme routing"
})
```

**Expected:**
- sui-supreme analyzes request
- Determines project type: DeFi (token)
- Routes to sui-development-agent
- Reports task decomposition

## Test 2: Invoke sui-development-agent

**Command:**
```typescript
Task({
  subagent_type: "sui-development-agent",
  prompt: "Generate architecture for a token contract",
  description: "Test sui-development-agent"
})
```

**Expected:**
- Delegates to sui-architect-subagent
- Executes sui-architect skill
- Generates spec file

## Test 3: Invoke sui-infrastructure-agent

**Command:**
```typescript
Task({
  subagent_type: "sui-infrastructure-agent",
  prompt: "Query latest SUI Coin API documentation",
  description: "Test infrastructure service"
})
```

**Expected:**
- Delegates to sui-docs-query-subagent
- Executes sui-docs-query skill
- Returns documentation

## Test 4: State Management

**Setup:**
```bash
# Initialize state
cat > .claude/sui-agent-state.json <<EOF
{
  "project": {
    "name": "test-project",
    "type": "NFT",
    "phase": "planning",
    "started_at": "2026-01-28T10:00:00Z",
    "updated_at": "2026-01-28T10:00:00Z"
  },
  "agents": {},
  "dependencies": { "package_ids": {}, "integrations": [] },
  "artifacts": { "specs": [], "contracts": [], "tests": [], "deployed_packages": [] }
}
EOF
```

**Test:**
```typescript
// Agent should read and update state
const state = StateManager.getState();
StateManager.updateAgent("sui-development-agent", {
  status: "working",
  current_task: "Test task",
  progress: 0.5
});
```

**Verify:**
```bash
cat .claude/sui-agent-state.json | grep "sui-development-agent"
```

Expected: Agent status updated in state file

## Test 5: Message Broker

**Test:**
```typescript
import { MessageBroker } from './agents/lib/message-broker';

const broker = new MessageBroker();

// Send message
broker.send({
  type: 'service_request',
  from: 'sui-developer-subagent',
  to: 'sui-docs-query-subagent',
  payload: { query: 'Latest SUI API' },
  timestamp: new Date().toISOString()
});

// Receive message
const messages = await broker.receive('sui-docs-query-subagent');
console.log(messages[0].payload.query); // "Latest SUI API"
```

**Expected:**
- Message sent successfully
- Message received by correct agent
- Payload intact

## Test 6: Agent Registration

**Test:**
```bash
# Run registration script
./agents/register-agents.sh

# Verify registration
cat ~/.config/claude-code/custom-agents.json | grep "sui-supreme"
```

**Expected:**
- Script completes successfully
- Configuration file created at ~/.config/claude-code/custom-agents.json
- sui-supreme agent registered with correct settings

## Test 7: Broadcast Messages

**Test:**
```typescript
const broker = new MessageBroker();

broker.send({
  type: 'state_update',
  from: 'sui-tester-subagent',
  to: 'broadcast',
  payload: { test_results: { passed: 10, failed: 0 } },
  timestamp: new Date().toISOString()
});

// All agents should receive
const devMessages = await broker.receive('sui-development-agent');
const coreMessages = await broker.receive('sui-core-agent');

console.log(devMessages.length > 0);  // true
console.log(coreMessages.length > 0); // true
```

**Expected:**
- Broadcast message sent once
- All registered agents receive the message
- Message content identical for all recipients

## Success Criteria

All tests should pass:
- ✅ Agents can be invoked via Task tool
- ✅ State management works correctly
- ✅ Message broker handles communication
- ✅ Agent registration successful
- ✅ Broadcast messages work
