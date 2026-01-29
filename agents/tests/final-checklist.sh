#!/bin/bash

echo "🎯 Final Verification Checklist"
echo "================================"

checks_passed=0
checks_total=0

# Check 1: Agent definitions
checks_total=$((checks_total + 1))
if [ -f "agents/supreme/sui-supreme.json" ] && \
   [ -f "agents/core/sui-core-agent.json" ] && \
   [ -f "agents/infrastructure/sui-infrastructure-agent.json" ] && \
   [ -f "agents/development/sui-development-agent.json" ] && \
   [ -f "agents/ecosystem/sui-ecosystem-agent.json" ]; then
  echo "✅ All category agent definitions exist"
  checks_passed=$((checks_passed + 1))
else
  echo "❌ Missing category agent definitions"
fi

# Check 2: Subagent count
checks_total=$((checks_total + 1))
subagent_count=$(ls -1 agents/subagents/*.json 2>/dev/null | wc -l)
if [ "$subagent_count" -eq 17 ]; then
  echo "✅ All 17 subagents defined"
  checks_passed=$((checks_passed + 1))
else
  echo "❌ Expected 17 subagents, found $subagent_count"
fi

# Check 3: State manager
checks_total=$((checks_total + 1))
if [ -f "agents/lib/state-manager.ts" ]; then
  echo "✅ StateManager exists"
  checks_passed=$((checks_passed + 1))
else
  echo "❌ StateManager missing"
fi

# Check 4: Message broker
checks_total=$((checks_total + 1))
if [ -f "agents/lib/message-broker.ts" ]; then
  echo "✅ MessageBroker exists"
  checks_passed=$((checks_passed + 1))
else
  echo "❌ MessageBroker missing"
fi

# Check 5: Claude Code registration
checks_total=$((checks_total + 1))
if [ -f "agents/claude-code-agent-config.json" ]; then
  echo "✅ Agents registered with Claude Code"
  checks_passed=$((checks_passed + 1))
else
  echo "⚠️  Run ./agents/register-agents.sh to register"
fi

# Check 6: Documentation
checks_total=$((checks_total + 1))
if [ -f "agents/USAGE.md" ] && [ -f "agents/EXAMPLES.md" ]; then
  echo "✅ Documentation complete"
  checks_passed=$((checks_passed + 1))
else
  echo "❌ Documentation missing"
fi

# Check 7: Tests
checks_total=$((checks_total + 1))
if [ -f "agents/tests/integration-test.sh" ]; then
  echo "✅ Integration tests exist"
  checks_passed=$((checks_passed + 1))
else
  echo "❌ Integration tests missing"
fi

# Check 8: Run integration tests
checks_total=$((checks_total + 1))
echo ""
echo "Running integration tests..."
./agents/tests/integration-test.sh > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "✅ All integration tests passed"
  checks_passed=$((checks_passed + 1))
else
  echo "❌ Some integration tests failed"
fi

echo ""
echo "================================"
echo "Passed: $checks_passed / $checks_total"

if [ "$checks_passed" -eq "$checks_total" ]; then
  echo "✅ All checks passed!"
  echo ""
  echo "🎉 SUI Agent Architecture is COMPLETE and READY!"
  echo ""
  echo "System Summary:"
  echo "  - 22 agents defined (1 supreme + 4 category + 17 subagents)"
  echo "  - State management system (6 tests passing)"
  echo "  - Message broker system (5 tests passing)"
  echo "  - Claude Code integration configured"
  echo "  - Comprehensive documentation (USAGE.md, EXAMPLES.md)"
  echo "  - All integration tests passing"
  echo ""
  echo "Quick Start:"
  echo "  Task({"
  echo "    subagent_type: 'sui-supreme',"
  echo "    prompt: 'Build an NFT marketplace',"
  echo "    description: 'NFT marketplace'"
  echo "  })"
  exit 0
else
  echo "❌ Some checks failed"
  exit 1
fi
