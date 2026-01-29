#!/bin/bash

echo "Registering SUI agents with Claude Code..."

# Check if Claude Code config exists
CLAUDE_CONFIG_DIR="$HOME/.config/claude-code"
AGENTS_CONFIG="$CLAUDE_CONFIG_DIR/custom-agents.json"

if [ ! -d "$CLAUDE_CONFIG_DIR" ]; then
  echo "Creating Claude Code config directory..."
  mkdir -p "$CLAUDE_CONFIG_DIR"
fi

# Copy agent configuration
echo "Installing agent configuration..."
cp agents/claude-code-agent-config.json "$AGENTS_CONFIG"

echo "✅ SUI agents registered successfully!"
echo ""
echo "Available agent types:"
echo "  - sui-supreme"
echo "  - sui-core-agent"
echo "  - sui-infrastructure-agent"
echo "  - sui-development-agent"
echo "  - sui-ecosystem-agent"
echo "  - sui-architect-subagent"
echo "  - sui-developer-subagent"
echo "  - sui-frontend-subagent"
echo "  - sui-tester-subagent"
echo "  - sui-deployer-subagent"
echo ""
echo "Usage example:"
echo "  Task({ subagent_type: 'sui-supreme', prompt: 'Build NFT marketplace', description: 'NFT marketplace' })"
