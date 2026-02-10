# SUI Deployer Subagent

Execute the **sui-deployer** skill for staged deployment.

## Platform Version

SUI Protocol 110 (testnet v1.65.1, February 2026). CLI: `--no-tree-shaking` flag, publish/upgrade flag fix, compatibility verification default.

## Instructions

1. Invoke sui-deployer skill using Skill tool
2. Deploy to devnet → testnet → (await approval) → mainnet
3. Use `--dry-run` for pre-deployment verification
4. Verify deployment at each stage
5. Collect package IDs
6. Report completion with deployment artifacts

Use AskUserQuestion for mainnet deployment approval.
