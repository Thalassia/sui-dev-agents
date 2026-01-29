# End-to-End Agent Test

Complete workflow test of the SUI agent system.

## Test Scenario

Build a simple token contract from scratch using the agent system.

## Step 1: Initialize State

```bash
# Ensure clean state
rm -f .claude/sui-agent-state.json

# State will be initialized by first agent invocation
```

## Step 2: Invoke sui-supreme

```typescript
Task({
  subagent_type: "sui-supreme",
  prompt: `Build a simple SUI token contract with:
- Mint function
- Transfer function
- Burn function
- Total supply tracking`,
  description: "Simple token contract"
})
```

## Step 3: Verify Agent Routing

**Expected routing:**
```
sui-supreme
  ↓ analyzes: DeFi project, token contract
  ↓ routes to: sui-development-agent
sui-development-agent
  ↓ phase: architecture
  ↓ delegates to: sui-architect-subagent
sui-architect-subagent
  ✓ executes: sui-architect skill
  ✓ generates: docs/specs/token-spec.md
```

## Step 4: Check State File

```bash
cat .claude/sui-agent-state.json
```

**Expected state:**
```json
{
  "project": {
    "name": "token-contract",
    "type": "DeFi",
    "phase": "architecture",
    "started_at": "2026-01-28...",
    "updated_at": "2026-01-28..."
  },
  "agents": {
    "sui-development-agent": {
      "status": "working",
      "current_task": "Generate architecture",
      "last_update": "2026-01-28...",
      "progress": 0.5
    }
  },
  "artifacts": {
    "specs": ["docs/specs/token-spec.md"],
    "contracts": [],
    "tests": [],
    "deployed_packages": []
  }
}
```

## Step 5: Continue to Development

**sui-supreme should automatically continue:**
```
sui-development-agent
  ↓ phase: development
  ↓ delegates to: sui-developer-subagent
sui-developer-subagent
  ✓ reads: docs/specs/token-spec.md
  ✓ executes: sui-developer skill
  ✓ generates: contracts/token.move
  ✓ runs: quality checks (strict mode)
  ✓ commits: code
```

## Step 6: Check Artifacts

```bash
ls -la docs/specs/
ls -la contracts/
```

**Expected files:**
```
docs/specs/token-spec.md
contracts/token.move
tests/token_tests.move
```

## Step 7: Verify Quality Checks

**sui-developer-subagent should run:**
- Fast mode: Compilation
- Standard mode: Security patterns
- Strict mode: Deep audit

**Check output for:**
```
✅ Compilation successful
✅ Security patterns OK
✅ Strict mode checks passed
```

## Step 8: Final State

```bash
cat .claude/sui-agent-state.json
```

**Expected final state:**
```json
{
  "project": {
    "phase": "complete"
  },
  "agents": {
    "sui-development-agent": {
      "status": "complete",
      "current_task": null,
      "progress": 1.0
    }
  },
  "artifacts": {
    "specs": ["docs/specs/token-spec.md"],
    "contracts": ["contracts/token.move"],
    "tests": ["tests/token_tests.move"]
  }
}
```

## Success Criteria

- ✅ State file initialized
- ✅ Agent routing correct (supreme → development → architect/developer)
- ✅ Spec generated
- ✅ Move code generated
- ✅ Quality checks passed
- ✅ Tests generated
- ✅ Final state complete

## Cleanup

```bash
# Save test artifacts
mkdir -p agents/tests/e2e-output
cp -r docs/specs/ agents/tests/e2e-output/ 2>/dev/null || true
cp -r contracts/ agents/tests/e2e-output/ 2>/dev/null || true
cp .claude/sui-agent-state.json agents/tests/e2e-output/ 2>/dev/null || true

# Clean up
rm -rf docs/specs/token-spec.md 2>/dev/null || true
rm -rf contracts/token.move 2>/dev/null || true
rm -f .claude/sui-agent-state.json 2>/dev/null || true
```
