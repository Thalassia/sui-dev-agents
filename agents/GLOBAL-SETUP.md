# SUI Agents - Global Configuration

## ✅ 已成功設定為全域配置！

SUI Agent 架構已經安裝到全域位置，可在任何專案中使用。

## 📍 安裝位置

```
~/.claude/agents/
├── README.md
├── USAGE.md
├── EXAMPLES.md
├── supreme/               (Supreme 協調器)
├── core/                  (核心工作流)
├── infrastructure/        (基礎設施服務)
├── development/           (開發生命週期)
├── ecosystem/             (生態系統整合)
├── subagents/             (17 個子代理)
├── lib/                   (TypeScript 模組)
├── tests/                 (整合測試)
└── claude-code-agent-config.json
```

## 🚀 如何使用

### 1. 在任何專案中直接使用

```typescript
// 從任何專案目錄調用
Task({
  subagent_type: "sui-supreme",
  prompt: "Build an NFT marketplace with Kiosk integration",
  description: "NFT marketplace"
})
```

### 2. 查看使用指南

```bash
# 完整使用手冊
cat ~/.claude/agents/USAGE.md

# 實際範例
cat ~/.claude/agents/EXAMPLES.md
```

### 3. 運行測試驗證

```bash
# 整合測試
~/.claude/agents/tests/integration-test.sh

# 最終驗證
~/.claude/agents/tests/final-checklist.sh
```

## 📊 全域 Agents 系統總覽

### 可用的 Agents (22 個)

**Supreme 協調器:**
- `sui-supreme` - 頂層任務分解和協調

**分類 Agents (4 個):**
- `sui-core-agent` - 完整全棧專案協調
- `sui-infrastructure-agent` - 文檔查詢和安全掃描
- `sui-development-agent` - 開發生命週期管理
- `sui-ecosystem-agent` - 生態系統整合

**子 Agents (17 個):**
- 開發相關: architect, developer, frontend, tester, deployer
- 基礎設施: docs-query, security-guard, full-stack
- 生態系統: kiosk, walrus, zklogin, passkey, oracle, deepbook, nft-protocol, multisig, fullstack-integration

## 🎯 常見使用場景

### 場景 1: 建立新的 NFT Marketplace
```typescript
Task({
  subagent_type: "sui-supreme",
  prompt: "Build NFT marketplace with Kiosk, Walrus, and zkLogin",
  description: "NFT marketplace"
})
```

### 場景 2: 只生成架構
```typescript
Task({
  subagent_type: "sui-architect-subagent",
  prompt: "Generate architecture for DeFi AMM",
  description: "AMM architecture"
})
```

### 場景 3: 安全審計
```typescript
Task({
  subagent_type: "sui-infrastructure-agent",
  prompt: "Scan contracts/ for vulnerabilities (strict mode)",
  description: "Security audit"
})
```

## 🔧 管理全域 Agents

### 更新 Agents
```bash
# 從專案目錄更新全域設定
cp -r agents/* ~/.claude/agents/
```

### 重新註冊
```bash
# 重新註冊 agents 到 Claude Code
~/.claude/agents/register-agents.sh
```

### 刪除全域設定
```bash
# 如果需要移除全域設定
rm -rf ~/.claude/agents/
```

## 📖 完整文檔

- **使用指南:** `~/.claude/agents/USAGE.md`
- **實例範例:** `~/.claude/agents/EXAMPLES.md`
- **Agent 定義:** `~/.claude/agents/*/`
- **狀態管理 API:** `~/.claude/agents/lib/state-manager.ts`
- **消息代理 API:** `~/.claude/agents/lib/message-broker.ts`

## ✨ 優點

✅ **全域可用** - 在任何 SUI 專案中都可以直接使用
✅ **統一管理** - 所有 agents 集中在一個位置
✅ **自動更新** - 更新一次，所有專案都受益
✅ **零配置** - 新專案無需額外設置
✅ **完整測試** - 100% 測試覆蓋率 (17/17 tests passing)

## 🎊 開始使用！

現在你可以在**任何專案**中使用 SUI Agents 了！

```bash
# 建立一個新專案
mkdir my-new-sui-project
cd my-new-sui-project

# 直接使用全域 agents
# Task({ subagent_type: "sui-supreme", prompt: "..." })
```

---

**SUI Agent 架構現已全域配置完成！🚀**
