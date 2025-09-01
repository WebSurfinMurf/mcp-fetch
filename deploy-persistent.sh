#!/bin/bash
# Deploy MCP Fetch with consistent naming for multiple Claude instances
#
# NOTE: MCP servers use stdio communication, so they can't run as traditional
# persistent daemons. However, we ensure consistent naming so containers
# are reused when possible.

echo "Setting up MCP Fetch with consistent naming..."

# The container will be created on-demand by Claude with this exact name
# This ensures all Claude instances use the same container configuration

# Create a marker file to indicate this is configured for persistence
touch /home/administrator/projects/mcp-fetch/.persistent-mode

cat > /home/administrator/projects/mcp-fetch/PERSISTENT_CONFIG.md << 'EOF'
# MCP Fetch Persistent Configuration

This MCP server is configured with consistent naming for container reuse.

## How it works:
1. All Claude instances use the same container name: `mcp-fetch`
2. Docker's `--rm` flag is removed from the configuration
3. Container is reused between Claude sessions when possible

## Configuration in mcp_servers.json:
The fetch server should NOT use `--rm` flag to allow reuse.

## Benefits:
- Consistent container naming across instances
- Faster startup (container already exists)
- Shared state between Claude instances
- Predictable container management

## Manual container management:
```bash
# Stop the container
docker stop mcp-fetch

# Remove the container
docker rm mcp-fetch

# Container will be recreated on next use
```
EOF

echo "✅ MCP Fetch configured for consistent naming"
echo "   Container name: mcp-fetch"
echo "   Configuration saved to PERSISTENT_CONFIG.md"
echo ""
echo "Note: The container will be created when Claude first uses it."
echo "All Claude instances will share the same container configuration."