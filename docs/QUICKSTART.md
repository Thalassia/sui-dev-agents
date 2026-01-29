# SUI Dev Agents - Quick Start Guide

## 🎯 5-Minute Start

### Build Your First SUI dApp

```bash
# Start the complete workflow
/sui-full-stack

# Follow the prompts:
1. Project name? → "my-nft-marketplace"
2. Description? → "NFT marketplace with Kiosk"
3. Use Git? → Yes, with GitHub
4. Project type? → NFT Marketplace
5. Integrate tools? → Kiosk, Walrus, zkLogin

# Plugin handles:
✅ Git initialization
✅ Architecture planning
✅ Move contract generation
✅ Frontend scaffolding
✅ Testing setup
✅ Deployment to devnet
✅ Documentation generation
```

## 📋 Common Workflows

### 1. Architecture Only

```bash
/sui-architect

→ Answer questions about your project
→ Get: docs/specs/YYYY-MM-DD-{project}-spec.md
→ Get: Architecture diagrams
→ Get: Security threat model
```

### 2. Smart Contract Development

```bash
/sui-developer

→ Generates Move code from spec
→ Real-time quality checks
→ Auto-generates TypeScript types
→ Comprehensive unit tests
```

### 3. Frontend Integration

```bash
/sui-frontend

→ Choose framework (React/Next.js/Vue)
→ Wallet integration (@mysten/dapp-kit)
→ SDK setup (@mysten/sui.js)
→ API wrappers generated
```

### 4. Testing

```bash
/sui-tester

→ Move unit tests
→ Move integration tests
→ Frontend tests
→ E2E tests
→ Gas benchmarks
```

### 5. Deployment

```bash
/sui-deployer

# Choose network:
→ Devnet: Fully automated
→ Testnet: Confirmation required
→ Mainnet: Full security checklist
```

## 🔧 Individual Skills

### Infrastructure

```bash
# Security scan
/sui-security-guard --mode strict

# Query latest docs
/sui-docs-query "Kiosk transfer policies API"
```

### Ecosystem Tools

```bash
# NFT marketplace
/sui-kiosk

# Zero-knowledge auth
/sui-zklogin

# Decentralized storage
/sui-walrus

# DEX integration
/sui-deepbook
```

## 🤖 Using Agents for Complex Tasks

For multi-step orchestration:

```typescript
// Complete project from scratch
Task({
  subagent_type: "sui-supreme",
  prompt: "Build a DeFi AMM with DeepBook integration and farming rewards",
  description: "DeFi AMM complete build"
})

// Just development phase
Task({
  subagent_type: "sui-development-agent",
  prompt: "Implement staking contract with time-locks",
  description: "Staking contract"
})

// Just ecosystem integration
Task({
  subagent_type: "sui-ecosystem-agent",
  prompt: "Add Walrus storage for NFT metadata",
  description: "Walrus integration"
})
```

## ⚙️ Configuration

Create `.sui-full-stack.json` in your project:

```json
{
  "auto_commit": true,
  "git_enabled": true,
  "github_sync": true,
  "auto_verify_tests": true,
  "max_test_retries": 5,
  "default_quality_mode": "standard"
}
```

## 🎓 Learning Path

### Beginner

1. Run `/sui-full-stack` for guided project creation
2. Explore generated code
3. Modify contracts and re-test with `/sui-tester`
4. Deploy to devnet with `/sui-deployer`

### Intermediate

1. Use individual skills for specific tasks
2. Customize architecture with `/sui-architect`
3. Integrate ecosystem tools (Kiosk, zkLogin)
4. Deploy to testnet

### Advanced

1. Use agents for complex orchestration
2. Create custom workflows
3. Extend with your own skills
4. Production mainnet deployments

## 🆘 Getting Help

```bash
# View skill documentation
cat ~/.claude/plugins/sui-dev-agents/skills/sui-full-stack/skill.md

# Check agent hierarchy
cat ~/.claude/plugins/sui-dev-agents/agents/README.md

# Tool selection guide
/sui-tools-guide
```

## 📦 Next Steps

1. ✅ Read full README: `README.md`
2. ✅ Check examples: `docs/EXAMPLES.md`
3. ✅ Understand architecture: `docs/ARCHITECTURE.md`
4. ✅ Build your first dApp!

---

**Happy building on SUI! 🚀**
