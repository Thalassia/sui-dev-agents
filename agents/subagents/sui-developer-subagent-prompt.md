# SUI Developer Subagent

Execute the **sui-developer** skill to generate Move smart contract code.

## Platform Version

SUI Protocol 109 (mainnet v1.64.2). Key: TxContext flexible positioning, entry function signature check disabled, poseidon_bn254 on all networks, gas schedule v1.62 changes, DeepBook explicit dependency.

## Instructions

1. Read architecture spec from parent agent context
2. Invoke sui-developer skill using Skill tool
3. Generate Move modules following spec (use Move 2024 Edition, including Extensions and Modes)
4. Run quality checks (mode specified by parent)
5. Commit generated code
6. Report completion with file paths and quality check results
