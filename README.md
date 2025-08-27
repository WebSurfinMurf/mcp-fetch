# MCP Fetch Server

Web content fetching and conversion server for Claude Code.

## Status: ✅ DEPLOYED

- **Image**: `mcp/fetch:latest` (Anthropic official)
- **Version**: 1.2.0
- **Config**: Added to `~/.config/claude/mcp-settings.json`
- **Network**: bridge (internet access, isolated from internal services)

## What It Does

Enables Claude to fetch and process web content:
- Fetches URLs and converts HTML to Markdown
- Supports chunked reading for large pages
- Ignores robots.txt for workflow automation
- Uses standard browser user agent

## Configuration

### Current Settings
- **Network**: `bridge` - Internet access without internal service exposure
- **robots.txt**: Ignored (--ignore-robots-txt flag)
- **User Agent**: `Mozilla/5.0 (Compatible; ClaudeAutomation/1.0)`
- **Timeout**: 30 seconds

### Security Features
- Cannot access internal Docker networks
- Cannot reach localhost or private IPs
- Isolated from your GitLab, Keycloak, databases
- Only public internet access allowed

## Use Cases

### Documentation Fetching
```
"Fetch the Docker Hub page for the postgres image"
"Get the GitLab troubleshooting guide"
"Fetch the Keycloak configuration documentation"
```

### Update Checking
```
"Check the latest version on the project's GitHub releases page"
"Get the security advisories from the vendor site"
"Fetch the changelog from the official website"
```

### Configuration Examples
```
"Get the docker-compose example from the official docs"
"Fetch the recommended nginx configuration"
"Get the environment variables list from the README"
```

## Testing

Run the test script:
```bash
./test-fetch.sh
```

Expected output:
- Server version: 1.2.0
- Protocol: 2024-11-05
- Successfully initializes
- Can fetch public URLs

## Usage Examples

### Fetch a webpage
```
"Fetch https://docs.docker.com/compose/compose-file/"
```

### Get specific content
```
"Fetch the installation section from https://docs.gitlab.com/ee/install/"
```

### Check for updates
```
"Fetch https://github.com/docker/compose/releases/latest"
```

## Security Notes

### What It CAN Access
- ✅ Public websites
- ✅ Documentation sites  
- ✅ GitHub, Docker Hub
- ✅ Any public URL

### What It CANNOT Access
- ❌ Your internal services (GitLab, Keycloak)
- ❌ Private IP ranges (192.168.*.*, 10.*.*.*)
- ❌ Localhost (127.0.0.1)
- ❌ Other Docker containers

## Comparison with Browser

This is equivalent to:
```bash
# What you'd do manually:
1. Open browser
2. Navigate to URL
3. Copy content
4. Paste to Claude

# What fetch does automatically:
1. Fetch URL
2. Convert to Markdown
3. Return to Claude
```

## Files in This Project

- `README.md` - This file
- `CLAUDE.md` - AI assistant notes
- `test-fetch.sh` - Test script

## Troubleshooting

### Timeout Issues
- Default is 30 seconds
- Some sites may take longer
- Can be adjusted in config

### Access Denied
- Site may block automated requests
- Try different user agent
- Some sites require authentication

### Content Not Readable
- Site may use heavy JavaScript
- Fetch only gets initial HTML
- Consider using Playwright MCP for JS sites

## Resources

- [MCP Fetch Server Docs](https://github.com/modelcontextprotocol/servers/tree/main/src/fetch)
- [Model Context Protocol](https://spec.modelcontextprotocol.io/)
- Creator: Anthropic (official)

---
*Deployed: 2025-08-27*