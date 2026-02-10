# SUI Dev Agents - Architecture Overview

**Version 2.0.0**

Detailed architecture of the sui-dev-agents plugin, covering components, interactions, and design principles.

## Table of Contents

1. [System Overview](#system-overview)
2. [Component Architecture](#component-architecture)
3. [Directory Structure](#directory-structure)
4. [Interaction Patterns](#interaction-patterns)
5. [Design Principles](#design-principles)

---

## System Overview

The sui-dev-agents plugin is a multi-layered toolkit for SUI blockchain development, organized into five primary component types:

```
┌─────────────────────────────────────────────────────────┐
│                    User Interface                        │
│         (Claude Code CLI / Chat Interface)              │
└─────────────────────────────────────────────────────────┘
                          ▼
┌─────────────────────────────────────────────────────────┐
│                   Component Layer                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │ Commands │  │  Skills  │  │  Agents  │             │
│  │   (7)    │  │   (19)   │  │   (23)   │             │
│  └──────────┘  └──────────┘  └──────────┘             │
│                                                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │  Hooks   │  │  Rules   │  │  Tools   │             │
│  │   (3)    │  │   (4)    │  │   (2)    │             │
│  └──────────┘  └──────────┘  └──────────┘             │
└─────────────────────────────────────────────────────────┘
                          ▼
┌─────────────────────────────────────────────────────────┐
│                   External Systems                       │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │ SUI CLI  │  │   Git    │  │   LSP    │             │
│  └──────────┘  └──────────┘  └──────────┘             │
└─────────────────────────────────────────────────────────┘
```

---

## Component Architecture

### 1. Commands

**Purpose:** Fast, focused operations for common tasks

**Characteristics:**
- Single-purpose
- Minimal user interaction
- Quick execution (< 30 seconds typically)
- Direct CLI integration

**Location:** `commands/*.md`

**Invocation:** `/sui-dev-agents:command-name`

**Command List:**
```
init      → Initialize new Move project
build     → Build contracts with verification
test      → Run test suite
deploy    → Deploy to network
audit     → Security audit
upgrade   → Upgrade contracts
gas       → Gas usage report
```

**Flow:**
```
User → /sui-dev-agents:init → Command Handler → SUI CLI → Result
                                    ↓
                              Hooks Triggered
```

### 2. Skills

**Purpose:** Interactive workflows for specific development tasks

**Characteristics:**
- More complex than commands
- Interactive prompts
- May use multiple tools
- Can orchestrate commands

**Location:** `skills/*/skill.md`

**Invocation:** `/skill-name`

**Skill Categories:**

```
Core Orchestrator (1)
├── sui-full-stack

Development Workflow (6)
├── sui-architect
├── sui-developer
├── sui-frontend
├── sui-fullstack-integration
├── sui-tester
└── sui-deployer

Infrastructure (2)
├── sui-security-guard
└── sui-docs-query

Ecosystem Integrations (9)
├── sui-kiosk
├── sui-zklogin
├── sui-passkey
├── sui-deepbook
├── sui-walrus
├── sui-suins
├── sui-seal
├── sui-nautilus
└── sui-tools-guide
```

**Flow:**
```
User → /sui-architect → Skill Handler → Multi-step Workflow
                             ↓
                       ┌──────────┐
                       │ Commands │
                       │ External │
                       │ Tools    │
                       └──────────┘
```

### 3. Agents

**Purpose:** Hierarchical orchestration for complex multi-step tasks

**Characteristics:**
- Task decomposition
- State management
- Inter-agent delegation
- Long-running operations

**Location:** `agents/*.md`

**Invocation:** Via Task tool

**Agent Hierarchy:**

```
sui-supreme (Supreme Orchestrator)
│
├── sui-core-agent (Full-Stack Workflows)
│   └── sui-full-stack-subagent
│
├── sui-infrastructure-agent (Infrastructure Services)
│   ├── sui-docs-query-subagent
│   └── sui-security-guard-subagent
│
├── sui-development-agent (Development Lifecycle)
│   ├── sui-architect-subagent
│   ├── sui-developer-subagent
│   ├── sui-frontend-subagent
│   ├── sui-tester-subagent
│   └── sui-deployer-subagent
│
└── sui-ecosystem-agent (Ecosystem Integrations)
    ├── sui-kiosk-subagent
    ├── sui-zklogin-subagent
    ├── sui-passkey-subagent
    ├── sui-deepbook-subagent
    ├── sui-walrus-subagent
    ├── sui-suins-subagent
    ├── sui-seal-subagent
    ├── sui-nautilus-subagent
    └── sui-fullstack-integration-subagent
```

**Agent Types:**

- **Supreme Orchestrator:** Top-level task decomposition
- **Category Agents:** Domain-specific coordination (4 agents)
- **Subagents:** Specialized task execution (18 agents)

**Flow:**
```
Task Tool → sui-supreme → Analyze Request
                ↓
           ┌────────────────────┐
           │   Category Agent   │
           └────────────────────┘
                ↓
           ┌────────────────────┐
           │     Subagent       │
           └────────────────────┘
                ↓
         ┌──────────────────┐
         │ Skills/Commands  │
         └──────────────────┘
```

### 4. Hooks

**Purpose:** Automatic verification and lifecycle events

**Characteristics:**
- Event-driven
- Non-blocking
- Transparent to user
- Configurable

**Location:** `hooks/hooks.json`

**Hook Types:**

```json
{
  "PostToolUse": [
    {
      "matcher": "Edit|Write",
      "hooks": [
        {
          "type": "command",
          "command": "sui move build after .move file edits",
          "description": "Auto-verify Move syntax"
        }
      ]
    }
  ],
  "SessionStart": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "show active SUI environment",
          "description": "Display network"
        }
      ]
    }
  ],
  "Stop": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "check for test_only code in sources/",
          "description": "Warn about test code leaks"
        }
      ]
    }
  ]
}
```

**Event Flow:**

```
[User edits file.move]
    ↓
[Edit tool completes]
    ↓
[PostToolUse hook triggers]
    ↓
[sui move build runs]
    ↓
[Output shown to user]
```

### 5. Rules

**Purpose:** Coding conventions and best practices

**Characteristics:**
- Declarative guidelines
- Applied automatically by Claude
- Project-agnostic
- Version-controlled

**Location:** `rules/**/*.md`

**Installation:** `scripts/install-rules.sh` → `~/.claude/rules/`

**Rule Categories:**

```
sui-move/
├── conventions.md    → Move coding patterns
├── security.md       → Security best practices
└── testing.md        → Test patterns

common/
└── code-quality.md   → General quality standards
```

**Application:**

```
User writes code → Claude applies rules → Code generated
                        ↓
                  ┌─────────────┐
                  │ conventions │
                  │ security    │
                  │ testing     │
                  │ quality     │
                  └─────────────┘
```

### 6. Developer Tools

**Purpose:** IDE and tooling integration

**Location:**
- `.mcp.json` - MCP server template
- `.lsp.json` - move-analyzer LSP config

**Usage:** Copy to project root for IDE integration

---

## Directory Structure

```
sui-dev-agents/
├── .claude-plugin/
│   ├── plugin.json              # Plugin metadata (v2.0.0)
│   ├── marketplace.json         # Marketplace listing
│   └── README.md                # Plugin overview
│
├── commands/                    # 7 commands
│   ├── init.md
│   ├── build.md
│   ├── test.md
│   ├── deploy.md
│   ├── audit.md
│   ├── upgrade.md
│   └── gas.md
│
├── skills/                      # 19 skills
│   ├── sui-full-stack/
│   ├── sui-architect/
│   ├── sui-developer/
│   ├── sui-frontend/
│   ├── sui-tester/
│   ├── sui-deployer/
│   ├── sui-security-guard/
│   ├── sui-docs-query/
│   ├── sui-kiosk/
│   ├── sui-zklogin/
│   ├── sui-passkey/
│   ├── sui-deepbook/
│   ├── sui-walrus/
│   ├── sui-suins/
│   ├── sui-seal/
│   ├── sui-nautilus/
│   ├── sui-fullstack-integration/
│   └── sui-tools-guide/
│
├── agents/                      # 23 agents
│   ├── sui-supreme.md           # Supreme orchestrator
│   ├── sui-core-agent.md        # Category agents
│   ├── sui-infrastructure-agent.md
│   ├── sui-development-agent.md
│   ├── sui-ecosystem-agent.md
│   └── [18 subagent files]
│
├── hooks/
│   └── hooks.json               # Hook configurations
│
├── rules/                       # 4 rule files
│   ├── sui-move/
│   │   ├── conventions.md
│   │   ├── security.md
│   │   └── testing.md
│   └── common/
│       └── code-quality.md
│
├── examples/                    # 3 starters + template
│   ├── starter-nft/
│   ├── starter-defi/
│   ├── starter-dao/
│   └── CLAUDE.md                # Project template
│
├── scripts/                     # 4 utility scripts
│   ├── install-rules.sh
│   ├── check-sui-env.sh
│   ├── protocol-version-check.sh
│   └── gas-report.sh
│
├── docs/
│   ├── QUICKSTART.md            # 5-minute intro
│   ├── GUIDE.md                 # Complete guide (new)
│   └── ARCHITECTURE.md          # This file (new)
│
├── .mcp.json                    # MCP template
├── .lsp.json                    # LSP config
├── README.md
├── CHANGELOG.md
└── LICENSE
```

---

## Interaction Patterns

### Pattern 1: Command → Hook

Fast iteration with automatic verification:

```
User: /sui-dev-agents:build
  ↓
Command: runs sui move build
  ↓
Result: shows output
  ↓
(later)
  ↓
User: edits nft.move
  ↓
PostToolUse Hook: auto-runs build
  ↓
Result: immediate feedback
```

### Pattern 2: Skill → Commands

Skill orchestrates multiple commands:

```
User: /sui-full-stack
  ↓
Skill: Phase 0 - Git init
Skill: Phase 1 - /sui-architect
Skill: Phase 2 - /sui-developer
  ↓ uses /sui-dev-agents:build internally
  ↓ hooks trigger automatically
Skill: Phase 3 - /sui-frontend
Skill: Phase 4 - Integration
Skill: Phase 5 - /sui-tester
  ↓ uses /sui-dev-agents:test internally
Skill: Phase 6 - /sui-deployer
  ↓ uses /sui-dev-agents:deploy internally
Skill: Phase 7 - Documentation
  ↓
Complete project output
```

### Pattern 3: Agent → Subagent → Skill

Complex orchestration:

```
Task({
  subagent_type: "sui-supreme",
  prompt: "Build NFT marketplace"
})
  ↓
sui-supreme: analyzes request
  ↓
delegates to → sui-development-agent
  ↓
delegates to → sui-architect-subagent
  ↓
invokes skill → /sui-architect
  ↓
generates spec
  ↓
back to → sui-development-agent
  ↓
delegates to → sui-developer-subagent
  ↓
invokes skill → /sui-developer
  ↓
uses command → /sui-dev-agents:build
  ↓
hooks trigger → PostToolUse
  ↓
... continues through deployment
```

### Pattern 4: Rules → Code Generation

Rules applied throughout:

```
User: asks for NFT contract
  ↓
Claude reads rules:
  - conventions.md → naming patterns
  - security.md → access control
  - testing.md → test structure
  - quality.md → documentation
  ↓
Generates code following all rules
  ↓
PostToolUse hook verifies syntax
  ↓
Code meets standards
```

---

## Design Principles

### 1. Layered Abstraction

```
High Level (Complex) → Agents       → Task decomposition
Mid Level (Guided)   → Skills       → Interactive workflows
Low Level (Fast)     → Commands     → Direct operations
Background           → Hooks        → Automatic checks
Foundation           → Rules        → Consistent standards
```

### 2. Composition Over Duplication

- Commands are atomic operations
- Skills compose commands
- Agents orchestrate skills
- No functionality duplicated

### 3. Progressive Enhancement

```
Beginner  → Use /sui-full-stack (guided)
          → Commands handle details
          → Hooks verify automatically
          ↓
Advanced  → Use individual skills
          → Compose custom workflows
          → Use agents for orchestration
```

### 4. Fail-Safe Defaults

- Hooks run automatically (non-blocking)
- Rules applied by default
- Commands prompt for dangerous operations
- Examples provide safe starting points

### 5. Developer Experience

```
Fast Feedback
  → Commands execute quickly
  → Hooks verify immediately

Clear Separation
  → Commands vs Skills vs Agents
  → Each has clear use case

Easy Discovery
  → /sui-dev-agents:tab shows commands
  → /sui-tab shows skills
  → Task tool for agents

Gradual Learning
  → Start with examples
  → Use commands for speed
  → Skills for guidance
  → Agents for complexity
```

---

## Version History

- **v2.0.0** (2026-02-11)
  - Added Commands (7)
  - Added Hooks (3)
  - Added Rules (4)
  - Added Examples (3 + template)
  - Added Scripts (4)
  - Added Developer Tools (2)

- **v1.1.0** (2026-02-05)
  - Updated for SUI v1.65, Protocol 110
  - TypeScript SDK rename
  - GraphQL API updates

- **v1.0.0** (2026-02-02)
  - Initial release
  - 18 Skills
  - 23 Agents

---

## Component Selection Guide

### When to Use Commands

✅ Quick operations
✅ Clear, single purpose
✅ Frequent use (build, test, deploy)
✅ Fast feedback needed

❌ Complex workflows
❌ Need user guidance
❌ Multi-step processes

### When to Use Skills

✅ Interactive workflows
✅ Need user input
✅ Multi-step but guided
✅ Specific domain task

❌ Just need speed
❌ No interaction needed
❌ Requires orchestration

### When to Use Agents

✅ Complex orchestration
✅ Task decomposition
✅ Long-running workflows
✅ State management needed

❌ Simple operations
❌ Fast iteration
❌ Single-purpose task

---

## Extension Points

### Adding Custom Commands

1. Create `commands/my-command.md`
2. Follow existing format
3. Add to `.claude-plugin/plugin.json`

### Adding Custom Skills

1. Create `skills/my-skill/` directory
2. Add `skill.md` with frontmatter
3. Claude auto-discovers

### Adding Custom Agents

1. Create `agents/my-agent.md`
2. Use frontmatter format
3. Add to `.claude-plugin/plugin.json`

### Adding Custom Hooks

1. Edit `hooks/hooks.json`
2. Add hook configuration
3. Test with matching events

### Adding Custom Rules

1. Create `.claude/rules/my-rules.md`
2. Follow declarative format
3. Claude applies automatically

---

**Architecture designed for Protocol 110, Move 2024 Edition**
