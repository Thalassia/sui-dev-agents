# Changelog

All notable changes to the SUI Dev Agents plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-02

### Added

#### Skills (18 total)
- **Core Orchestrator:**
  - `/sui-full-stack` - Complete end-to-end project workflow with Git integration

- **Development Workflow:**
  - `/sui-architect` - Architecture planning and specification generation
  - `/sui-developer` - Move smart contract development with quality checks
  - `/sui-frontend` - React/Next.js/Vue frontend integration
  - `/sui-fullstack-integration` - TypeScript type generation from Move
  - `/sui-tester` - Comprehensive testing (unit, integration, E2E, gas benchmarks)
  - `/sui-deployer` - Staged deployment (devnet, testnet, mainnet)

- **Infrastructure:**
  - `/sui-security-guard` - Security scanning, Git hooks, vulnerability detection
  - `/sui-docs-query` - Latest SUI documentation lookup

- **Ecosystem Integrations:**
  - `/sui-kiosk` - NFT marketplace protocol (royalties, policies)
  - `/sui-zklogin` - Zero-knowledge authentication
  - `/sui-passkey` - WebAuthn integration
  - `/sui-deepbook` - DEX protocol integration
  - `/sui-walrus` - Decentralized storage
  - `/sui-suins` - SUI name service
  - `/sui-seal` - Asset wrapping protocol
  - `/sui-nautilus` - AMM protocol
  - `/sui-tools-guide` - Tool selection and recommendation

#### Agents (23 total)
- **Supreme Orchestrator:**
  - `sui-supreme` - Top-level task decomposition and coordination

- **Category Agents:**
  - `sui-core-agent` - Full-stack project workflows
  - `sui-infrastructure-agent` - Documentation and security services
  - `sui-development-agent` - Complete development lifecycle
  - `sui-ecosystem-agent` - Protocol integrations

- **Specialized Subagents (18):**
  - Architecture, development, frontend, testing, deployment subagents
  - Ecosystem-specific subagents for Kiosk, zkLogin, DeepBook, Walrus, and more

#### Features
- Hierarchical agent orchestration system
- Complete SUI blockchain development lifecycle support
- Git integration with automatic commit and push
- Security scanning and vulnerability detection
- Multi-network deployment automation
- Comprehensive testing framework
- TypeScript SDK integration
- Move 2024 Edition best practices
- Production-ready code generation

### Infrastructure
- Plugin configuration system with `.sui-full-stack.json`
- Agent registration via `claude-code-agent-config.json`
- Skill discovery and validation
- Documentation and examples

---

## Future Roadmap

### Planned for v1.1.0
- Enhanced error recovery mechanisms
- Additional ecosystem protocol integrations
- Performance optimization for large projects
- Interactive tutorial mode

### Planned for v1.2.0
- CI/CD pipeline integration
- Advanced monitoring and analytics
- Multi-language frontend support
- Enhanced security scanning rules

---

[1.0.0]: https://github.com/ramonliao/sui-dev-agents/releases/tag/v1.0.0
