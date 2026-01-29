#!/bin/bash

echo "🧪 SUI Agent Integration Tests"
echo "================================"

# Test 1: Verify agent definitions exist
echo ""
echo "Test 1: Verify agent definition files..."
AGENT_FILES=(
  "agents/supreme/sui-supreme.json"
  "agents/core/sui-core-agent.json"
  "agents/infrastructure/sui-infrastructure-agent.json"
  "agents/development/sui-development-agent.json"
  "agents/ecosystem/sui-ecosystem-agent.json"
)

for file in "${AGENT_FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "  ✅ $file"
  else
    echo "  ❌ $file NOT FOUND"
    exit 1
  fi
done

# Test 2: Verify subagent definitions
echo ""
echo "Test 2: Verify subagent definitions..."
SUBAGENT_COUNT=$(ls -1 agents/subagents/*.json 2>/dev/null | wc -l)
if [ "$SUBAGENT_COUNT" -eq 17 ]; then
  echo "  ✅ All 17 subagents defined"
else
  echo "  ❌ Expected 17 subagents, found $SUBAGENT_COUNT"
  exit 1
fi

# Test 3: Verify state manager
echo ""
echo "Test 3: Verify state manager..."
if [ -f "agents/lib/state-manager.ts" ]; then
  echo "  ✅ StateManager implementation exists"
  cd agents/lib
  npx vitest run state-manager.test.ts --reporter=verbose > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "  ✅ StateManager tests passing"
  else
    echo "  ❌ StateManager tests failing"
    exit 1
  fi
  cd ../..
else
  echo "  ❌ StateManager not found"
  exit 1
fi

# Test 4: Verify message broker
echo ""
echo "Test 4: Verify message broker..."
if [ -f "agents/lib/message-broker.ts" ]; then
  echo "  ✅ MessageBroker implementation exists"
  cd agents/lib
  npx vitest run message-broker.test.ts --reporter=verbose > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "  ✅ MessageBroker tests passing"
  else
    echo "  ❌ MessageBroker tests failing"
    exit 1
  fi
  cd ../..
else
  echo "  ❌ MessageBroker not found"
  exit 1
fi

# Test 5: Verify Claude Code registration
echo ""
echo "Test 5: Verify Claude Code registration..."
if [ -f "agents/claude-code-agent-config.json" ]; then
  echo "  ✅ Claude Code config exists"
  AGENT_COUNT=$(grep -c '"subagent_type"' agents/claude-code-agent-config.json)
  if [ "$AGENT_COUNT" -ge 10 ]; then
    echo "  ✅ At least 10 agents registered"
  else
    echo "  ❌ Expected at least 10 agents, found $AGENT_COUNT"
    exit 1
  fi
else
  echo "  ❌ Claude Code config not found"
  exit 1
fi

# Test 6: Validate JSON schemas
echo ""
echo "Test 6: Validate JSON schemas..."
JSON_FILES=$(find agents -name "*.json" -type f)
for json_file in $JSON_FILES; do
  python3 -m json.tool "$json_file" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "  ✅ $json_file is valid JSON"
  else
    echo "  ❌ $json_file is invalid JSON"
    exit 1
  fi
done

echo ""
echo "================================"
echo "✅ All integration tests passed!"
echo "================================"
