# SUI Dev Agents

Complete toolkit for building production-ready SUI blockchain applications with integrated skills and agents.

## 🚀 Quick Start

### Using Skills (Direct Commands)

Start a complete SUI project:
```bash
/sui-full-stack
```

Use individual skills:
```bash
/sui-architect      # Architecture planning
/sui-developer      # Smart contract development
/sui-frontend       # Frontend integration
/sui-tester         # Comprehensive testing
/sui-deployer       # Multi-network deployment
```

### Using Agents (Task Delegation)

For complex orchestrated workflows, use agents via the Task tool:

```typescript
// Complete project build
Task({
  subagent_type: "sui-supreme",
  prompt: "Build an NFT marketplace with Kiosk integration",
  description: "NFT marketplace build"
})

// Specific development phase
Task({
  subagent_type: "sui-development-agent",
  prompt: "Generate architecture for a DeFi AMM",
  description: "AMM architecture"
})
```

## 📦 What's Included

### Skills (18 User-Invocable Commands)

**Core Orchestrator:**
- `/sui-full-stack` - Complete end-to-end project workflow with Git integration

**Development Workflow:**
- `/sui-architect` - Architecture planning and specification generation
- `/sui-developer` - Move smart contract development with quality checks
- `/sui-frontend` - React/Next.js/Vue frontend integration
- `/sui-fullstack-integration` - TypeScript type generation from Move
- `/sui-tester` - Comprehensive testing (unit, integration, E2E, gas benchmarks)
- `/sui-deployer` - Staged deployment (devnet, testnet, mainnet)

**Infrastructure:**
- `/sui-security-guard` - Security scanning, Git hooks, vulnerability detection
- `/sui-docs-query` - Latest SUI documentation lookup

**Ecosystem Integrations:**
- `/sui-kiosk` - NFT marketplace protocol (royalties, policies)
- `/sui-zklogin` - Zero-knowledge authentication
- `/sui-passkey` - WebAuthn integration
- `/sui-deepbook` - DEX protocol integration
- `/sui-walrus` - Decentralized storage
- `/sui-suins` - SUI name service
- `/sui-seal` - Asset wrapping protocol
- `/sui-nautilus` - AMM protocol
- `/sui-tools-guide` - Tool selection and recommendation

### Agents (23 Orchestration Agents)

**Supreme Orchestrator:**
- `sui-supreme` - Top-level task decomposition and coordination

**Category Agents:**
- `sui-core-agent` - Full-stack project workflows
- `sui-infrastructure-agent` - Documentation and security services
- `sui-development-agent` - Complete development lifecycle
- `sui-ecosystem-agent` - Protocol integrations

**Specialized Subagents (18):**
- Architecture, development, frontend, testing, deployment subagents
- Ecosystem-specific subagents (Kiosk, zkLogin, DeepBook, Walrus, etc.)

## 🏗️ Architecture

### Two-Tier System

**Skills** - Direct user invocation for specific tasks:
- Simple, focused functionality
- Executed immediately
- Example: `/sui-architect` to plan architecture

**Agents** - Complex multi-step orchestration:
- Hierarchical delegation
- State management
- Inter-agent communication
- Example: `sui-supreme` orchestrates entire project

### Agent Hierarchy

```
sui-supreme (Supreme Orchestrator)
├── sui-core-agent (Full-Stack Workflows)
│   └── sui-full-stack-subagent
├── sui-infrastructure-agent (Infrastructure Services)
│   ├── sui-docs-query-subagent
│   └── sui-security-guard-subagent
├── sui-development-agent (Development Lifecycle)
│   ├── sui-architect-subagent
│   ├── sui-developer-subagent
│   ├── sui-frontend-subagent
│   ├── sui-tester-subagent
│   └── sui-deployer-subagent
└── sui-ecosystem-agent (Ecosystem Integrations)
    ├── sui-kiosk-subagent
    ├── sui-zklogin-subagent
    ├── sui-deepbook-subagent
    ├── sui-walrus-subagent
    └── [5 more ecosystem subagents]
```

## 📖 Usage Examples

### Example 1: Complete New Project

```bash
User: "Build an NFT marketplace"

/sui-full-stack
→ Phase 0: Initialize project with Git + GitHub
→ Phase 1: Architecture planning (/sui-architect)
→ Phase 2: Smart contract development (/sui-developer)
→ Phase 3: Frontend integration (/sui-frontend)
→ Phase 4: Full-stack integration
→ Phase 5: Testing (/sui-tester)
→ Phase 6: Deployment (/sui-deployer)
→ Phase 7: Documentation generation

✅ Production-ready NFT marketplace with Git history!
```

### Example 2: Add Feature to Existing Project

```bash
User: "Add zkLogin to my existing dApp"

/sui-architect --update    # Update architecture spec
/sui-zklogin              # Integration guide
/sui-developer            # Modify contracts
/sui-frontend             # Add auth UI
/sui-tester               # Run tests
/sui-deployer --upgrade   # Upgrade deployment
```

### Example 3: Security Audit

```bash
/sui-security-guard --mode strict

→ Scans all Move contracts
→ Checks for OWASP vulnerabilities
→ Validates Git hooks
→ Generates security report
```

## 🔧 Configuration

Skills can be configured via `.sui-full-stack.json`:

```json
{
  "auto_commit": true,
  "git_enabled": true,
  "github_sync": true,
  "quality_gates": true,
  "auto_verify_tests": true,
  "max_test_retries": 5,
  "default_quality_mode": "strict"
}
```

## 🎯 Best Practices

1. **Start with `/sui-full-stack`** for new projects - handles entire lifecycle
2. **Use agents for complex tasks** - let `sui-supreme` orchestrate
3. **Security first** - run `/sui-security-guard` before commits
4. **Test-driven** - use `/sui-tester` throughout development
5. **Git integration** - enable auto-commit for clean history
6. **Ecosystem tools** - leverage SUI protocols (Kiosk, zkLogin, Walrus)

## 📚 Documentation

- **Skills Documentation:** `skills/*/skill.md` files
- **Agent Documentation:** `agents/*/prompt.md` files
- **Quick Reference:** `docs/QUICKSTART.md`
- **Architecture Guide:** `docs/ARCHITECTURE.md`
- **Examples:** `docs/EXAMPLES.md`

## 🔗 Integration with CLAUDE.md

This plugin integrates with your global CLAUDE.md rules:

- **auto_verify:** Automatic test execution and fixing (max 5 retries)
- **auto_quality_suggest:** Prompts for code review after major changes
- **error_recovery:** Auto-retry on API errors (max 5 times)
- **no_overengineering:** Focused, minimal solutions

## 🛠️ Troubleshooting

### Skills Not Found
```bash
# Plugin may need to be loaded
# Restart Claude Code or reload plugins
```

### Agent Not Found
```bash
# Verify agent registration
cd ~/.claude/plugins/sui-dev-agents/agents
cat claude-code-agent-config.json
```

## 📄 License

MIT License - Free to use and modify

## 👤 Author

Ramon Liao

## 🤝 Contributing

This is a personal plugin. Fork and customize for your needs!

---

**From idea to production-ready SUI dApp - guided every step of the way! 🚀**
