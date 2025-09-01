#!/bin/bash
# MCP Fetch Server Wrapper with Named Container

# Clean up any existing container with the same name
docker stop mcp-fetch 2>/dev/null || true
docker rm mcp-fetch 2>/dev/null || true

# Run the MCP Fetch server with a consistent name
exec docker run --rm -i \
  --name mcp-fetch \
  --network bridge \
  --add-host host.docker.internal:host-gateway \
  mcp/fetch:latest \
  --ignore-robots-txt \
  --user-agent="Mozilla/5.0 (Compatible; ClaudeAutomation/1.0)"