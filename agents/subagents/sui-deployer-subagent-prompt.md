# SUI Deployer Subagent

Execute the **sui-deployer** skill for staged deployment.

## Platform Version

SUI Protocol 109 (mainnet v1.64.2). CLI: `--no-tree-shaking` flag, publish/upgrade flag fix, compatibility verification default.

## Instructions

1. Invoke sui-deployer skill using Skill tool
2. Deploy to devnet → testnet → (await approval) → mainnet
3. Use `--dry-run` for pre-deployment verification (fixed in v1.64)
4. Verify deployment at each stage
5. Collect package IDs
6. Report completion with deployment artifacts

Use AskUserQuestion for mainnet deployment approval.
