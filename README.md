# SUI Dev Agents

**v2.1.0** - Complete toolkit for building production-ready SUI blockchain applications with skills, agents, commands, hooks, and rules. Now with **gRPC support** (JSON-RPC deprecated April 2026).

## 📦 Installation

### Install from Marketplace

```bash
/plugin marketplace add Thalassia/sui-dev-agents
/plugin install sui-dev-agents
```

### Direct Installation (Alternative)

```bash
/plugin install Thalassia/sui-dev-agents
```

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

### Commands (7 Fast Operations)

Quick, focused operations for common tasks:
- `/sui-dev-agents:init` - Initialize new Move project
- `/sui-dev-agents:build` - Build contracts with verification
- `/sui-dev-agents:test` - Run comprehensive tests
- `/sui-dev-agents:deploy` - Deploy to network
- `/sui-dev-agents:audit` - Security audit
- `/sui-dev-agents:upgrade` - Upgrade contracts
- `/sui-dev-agents:gas` - Gas usage report

### Skills (19 User-Invocable Skills)

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

### Hooks (Automatic Verification)

Three lifecycle hooks for automation:
- **PostToolUse** - Auto-verify Move syntax after edits
- **SessionStart** - Show active SUI environment
- **Stop** - Warn if test_only code in production

### Rules (Best Practices)

Installable coding standards:
- `sui-move/conventions.md` - Move coding patterns
- `sui-move/security.md` - Security guidelines
- `sui-move/testing.md` - Test patterns
- `common/code-quality.md` - Code quality rules

Install: `bash scripts/install-rules.sh`

### Developer Tools

- `.mcp.json` - MCP server template
- `.lsp.json` - move-analyzer LSP config

### Examples

Complete starter projects:
- `starter-nft/` - NFT collection with Kiosk
- `starter-defi/` - DeFi AMM
- `starter-dao/` - DAO governance
- `CLAUDE.md` - Project instructions template

### Scripts

Utility scripts:
- `install-rules.sh` - Install rules to ~/.claude/rules/
- `check-sui-env.sh` - Verify SUI environment
- `protocol-version-check.sh` - Check protocol version
- `gas-report.sh` - Generate gas report

## 🏗️ Architecture

### Three-Tier System

**Commands** - Fast, focused operations:
- Single-purpose tasks
- Minimal interaction
- Quick execution
- Example: `/sui-dev-agents:build` to compile contracts

**Skills** - Direct user invocation for specific tasks:
- More complex than commands
- Interactive workflows
- Immediate execution
- Example: `/sui-architect` to plan architecture

**Agents** - Complex multi-step orchestration:
- Hierarchical delegation
- State management
- Inter-agent communication
- Example: `sui-supreme` orchestrates entire project

### Component Hierarchy

```
Commands (7)           Skills (19)              Agents (23)
    ↓                      ↓                         ↓
  init              sui-full-stack          sui-supreme
  build             sui-architect           ├── sui-core-agent
  test              sui-developer           ├── sui-infrastructure-agent
  deploy            sui-frontend            ├── sui-development-agent
  audit             sui-tester              └── sui-ecosystem-agent
  upgrade           sui-deployer                 └── [18 subagents]
  gas               [13 more skills]

        ↓
    Hooks (3)               Rules (4)
PostToolUse             sui-move/conventions.md
SessionStart            sui-move/security.md
Stop                    sui-move/testing.md
                        common/code-quality.md
```

See `docs/ARCHITECTURE.md` for detailed component interactions.

## 📖 Usage Examples

### Example 1: Quick Start (Commands)

```bash
# Fast iteration workflow
/sui-dev-agents:init               # 1. Initialize project
# ... write some Move code ...
/sui-dev-agents:build              # 2. Build & verify
/sui-dev-agents:test               # 3. Run tests
/sui-dev-agents:audit              # 4. Security scan
/sui-dev-agents:deploy             # 5. Deploy to devnet
/sui-dev-agents:gas                # 6. Check gas usage

✅ Live on devnet in minutes!
```

### Example 2: Complete New Project (Skills)

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

### Example 3: Add Feature to Existing Project

```bash
User: "Add zkLogin to my existing dApp"

/sui-architect --update    # Update architecture spec
/sui-zklogin              # Integration guide
/sui-developer            # Modify contracts
/sui-frontend             # Add auth UI
/sui-dev-agents:test      # Run tests quickly
/sui-dev-agents:upgrade   # Upgrade deployment
```

### Example 4: Security Audit

```bash
/sui-security-guard --mode strict

→ Scans all Move contracts
→ Checks for OWASP vulnerabilities
→ Validates Git hooks
→ Generates security report
```

### Example 5: Using Example Projects

```bash
# Start from template
cp -r ~/.claude/plugins/sui-dev-agents/examples/starter-nft ./my-nft

cd my-nft
/sui-dev-agents:build
/sui-dev-agents:test
/sui-dev-agents:deploy

✅ NFT project running in 60 seconds!
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

1. **Install rules first** - `bash scripts/install-rules.sh` for consistent code quality
2. **Start with commands** for quick iterations - `/sui-dev-agents:init`, `:build`, `:test`
3. **Use `/sui-full-stack` skill** for new complete projects - handles entire lifecycle
4. **Let hooks verify automatically** - PostToolUse hook checks syntax after edits
5. **Use agents for complex tasks** - let `sui-supreme` orchestrate multi-step workflows
6. **Security first** - run `/sui-dev-agents:audit` or `/sui-security-guard` before commits
7. **Test-driven** - use `/sui-dev-agents:test` throughout development
8. **Git integration** - enable auto-commit for clean history
9. **Start from examples** - copy starter projects for faster setup
10. **Ecosystem tools** - leverage SUI protocols (Kiosk, zkLogin, Walrus)

## 📚 Documentation

- **Quick Start:** `docs/QUICKSTART.md` - 5-minute introduction
- **Complete Guide:** `docs/GUIDE.md` - Full usage guide (v2.0.0)
- **Architecture:** `docs/ARCHITECTURE.md` - Component design (v2.0.0)
- **Commands:** `commands/*.md` - Command reference
- **Skills:** `skills/*/skill.md` - Skill documentation
- **Agents:** `agents/*/prompt.md` - Agent documentation
- **Rules:** `rules/**/*.md` - Coding conventions
- **Examples:** `examples/` - Starter projects

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
