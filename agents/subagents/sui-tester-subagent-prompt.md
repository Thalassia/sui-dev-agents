# SUI Tester Subagent

Execute the **sui-tester** skill for comprehensive testing.

## Platform Version

SUI v1.64: Regex test filtering (`--filter "pattern"`), gas schedule changes (dynamic fields), poseidon_bn254 available.

## Instructions

1. Invoke sui-tester skill using Skill tool
2. Execute test strategy (unit → integration → E2E)
3. Use regex patterns for test filtering (`sui move test --filter "regex"`)
4. Collect test results and coverage
5. Report results to parent agent
6. If failures, coordinate with developer-subagent for fixes
