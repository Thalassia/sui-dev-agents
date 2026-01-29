# SUI Agent System - Examples

Real-world examples of using the SUI agent system.

## Example 1: NFT Marketplace - Complete Build

**Goal:** Build a complete NFT marketplace with Kiosk integration from scratch.

### Step 1: Invoke sui-supreme

```typescript
Task({
  subagent_type: "sui-supreme",
  prompt: `Build a complete NFT marketplace with:
- Fixed-price listings
- Auction functionality
- SUI Kiosk integration for NFT trading
- Walrus for metadata storage
- zkLogin for authentication
- React frontend`,
  description: "NFT marketplace complete build"
})
```

### What Happens:

1. **sui-supreme analyzes**:
   - Project type: NFT Marketplace
   - Required integrations: Kiosk, Walrus, zkLogin
   - Phases: Architecture → Development → Integration → Testing → Deployment

2. **Task decomposition**:
   - Task 1: Architecture (sui-development-agent → sui-architect-subagent)
   - Task 2: Query docs (sui-infrastructure-agent → sui-docs-query-subagent)
   - Task 3: Move development (sui-development-agent → sui-developer-subagent)
   - Task 4: Ecosystem integration (sui-ecosystem-agent)
   - Task 5: Frontend (sui-development-agent → sui-frontend-subagent)
   - Task 6: Testing (sui-development-agent → sui-tester-subagent)
   - Task 7: Security (sui-infrastructure-agent → sui-security-guard-subagent)
   - Task 8: Deployment (sui-development-agent → sui-deployer-subagent)

3. **Final output**:
   ```json
   {
     "status": "complete",
     "artifacts": {
       "specs": ["docs/specs/marketplace-spec.md"],
       "contracts": [
         "contracts/marketplace.move",
         "contracts/listing.move",
         "contracts/auction.move"
       ],
       "tests": [
         "tests/listing_tests.move",
         "tests/auction_tests.move"
       ],
       "frontend": ["frontend/"],
       "deployed_packages": {
         "testnet": "0x..."
       }
     },
     "integrations": ["kiosk", "walrus", "zklogin"],
     "test_results": {
       "total": 42,
       "passed": 42,
       "coverage": 0.89
     }
   }
   ```

---

## Example 2: Add Feature to Existing Project

**Scenario:** Add auction functionality to existing NFT marketplace.

```typescript
Task({
  subagent_type: "sui-development-agent",
  prompt: "Add auction module to existing NFT marketplace. Spec: docs/specs/marketplace-spec.md",
  description: "Add auction feature"
})
```

**Output:**
- Updated spec: `docs/specs/marketplace-spec.md` (with auction section)
- New contract: `contracts/auction.move`
- Tests: `tests/auction_tests.move`

---

## Example 3: Security Audit Workflow

**Goal:** Audit existing contracts before mainnet deployment.

### Step 1: Run security scan

```typescript
Task({
  subagent_type: "sui-infrastructure-agent",
  prompt: "Scan contracts/ directory for vulnerabilities (strict mode)",
  description: "Security audit"
})
```

**Output:**
```json
{
  "status": "issues_found",
  "vulnerabilities": [
    {
      "file": "contracts/listing.move",
      "line": 45,
      "severity": "high",
      "issue": "Unchecked arithmetic overflow",
      "fix": "Use safe_add() from sui::math"
    }
  ]
}
```

### Step 2: Fix vulnerabilities

```typescript
Task({
  subagent_type: "sui-development-agent",
  prompt: "Fix security issues in contracts/listing.move line 45: use safe_add",
  description: "Security fixes"
})
```

### Step 3: Re-scan

```typescript
Task({
  subagent_type: "sui-infrastructure-agent",
  prompt: "Re-scan contracts/ after security fixes",
  description: "Re-scan"
})
```

---

## Example 4: Multi-Integration Setup

**Goal:** Add Walrus storage + zkLogin auth to existing dApp.

### Step 1: Query docs (parallel)

```typescript
const [walrusDocs, zkLoginDocs] = await Promise.all([
  Task({
    subagent_type: "sui-infrastructure-agent",
    prompt: "Query Walrus integration guide and API",
    description: "Walrus docs"
  }),
  Task({
    subagent_type: "sui-infrastructure-agent",
    prompt: "Query zkLogin setup guide and OAuth flow",
    description: "zkLogin docs"
  })
]);
```

### Step 2: Integrate (sequential)

```typescript
// Backend first
Task({
  subagent_type: "sui-ecosystem-agent",
  prompt: "Integrate Walrus for NFT metadata storage",
  description: "Walrus integration"
});

// Then auth
Task({
  subagent_type: "sui-ecosystem-agent",
  prompt: "Add zkLogin authentication",
  description: "zkLogin integration"
});
```

---

## Example 5: Monitoring Agent Progress

**Track agent execution in real-time:**

```typescript
import { StateManager } from './agents/lib/state-manager';

const stateManager = new StateManager();

// Start long-running task
Task({
  subagent_type: "sui-supreme",
  prompt: "Build complete DeFi protocol",
  description: "DeFi build"
});

// Poll state every 5 seconds
setInterval(() => {
  const state = stateManager.getState();

  console.log(`\nProject: ${state.project.name}`);
  console.log(`Phase: ${state.project.phase}`);
  console.log(`\nAgent Status:`);

  Object.entries(state.agents).forEach(([agentId, status]) => {
    console.log(`  ${agentId}: ${status.status} (${status.progress * 100}%)`);
    if (status.current_task) {
      console.log(`    Task: ${status.current_task}`);
    }
  });

  console.log(`\nArtifacts:`);
  console.log(`  Specs: ${state.artifacts.specs.length}`);
  console.log(`  Contracts: ${state.artifacts.contracts.length}`);
  console.log(`  Tests: ${state.artifacts.tests.length}`);
}, 5000);
```

**Output:**
```
Project: defi-protocol
Phase: development

Agent Status:
  sui-development-agent: working (65%)
    Task: Generate Move code for swap module
  sui-infrastructure-agent: complete (100%)
  sui-ecosystem-agent: waiting (0%)

Artifacts:
  Specs: 1
  Contracts: 3
  Tests: 8
```

---

These examples demonstrate the complete agent workflow from simple feature additions to complex multi-phase projects.
