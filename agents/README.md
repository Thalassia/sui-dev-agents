# SUI Agent Architecture

Complete hierarchical agent system for SUI blockchain development.

## Hierarchy

```
sui-supreme (Supreme Orchestrator)
├── sui-core-agent (Core Workflows)
│   └── sui-full-stack-subagent
├── sui-infrastructure-agent (Infrastructure Services)
│   ├── sui-docs-query-subagent
│   └── sui-security-guard-subagent
├── sui-development-agent (Development Workflows)
│   ├── sui-architect-subagent
│   ├── sui-developer-subagent
│   ├── sui-frontend-subagent
│   ├── sui-deployer-subagent
│   └── sui-tester-subagent
└── sui-ecosystem-agent (Ecosystem Integrations)
    └── [9 ecosystem subagents]
```

## Agent Types

- **Supreme Agent** (`sui-supreme`): Top-level orchestrator
- **Category Agents** (4): Domain-specific coordinators
- **Subagents** (18): Skill executors

## Usage

Invoke via Claude Code Task tool:

```typescript
Task({
  subagent_type: "sui-supreme",
  prompt: "Build an NFT marketplace with Kiosk integration",
  description: "NFT marketplace build"
})
```

## Agent Definitions

See `supreme/`, `core/`, `infrastructure/`, `development/`, `ecosystem/` folders.
