# Claude AI Assistant Notes - MCP Fetch Server

> **For overall environment context, see: `/home/administrator/AINotes/AINotes.md`**

## Project Overview
Anthropic's official MCP Fetch Server - enables web content fetching and HTML-to-Markdown conversion for workflow automation.

## Recent Work & Changes

### Session: 2025-08-27
- Created project directory `/home/administrator/projects/mcp-fetch`
- Pulled official Docker image `mcp/fetch:latest`
- Configured in `~/.config/claude/mcp-settings.json`
- Set up with `--ignore-robots-txt` per user request
- Configured for workflow automation, not web scraping
- Successfully tested - server version 1.2.0

## Configuration Details

### MCP Settings Entry
```json
"fetch": {
  "command": "docker",
  "args": [
    "run", "--rm", "-i",
    "--network", "bridge",
    "--add-host", "host.docker.internal:host-gateway",
    "mcp/fetch:latest",
    "--ignore-robots-txt",
    "--user-agent=Mozilla/5.0 (Compatible; ClaudeAutomation/1.0)"
  ],
  "env": {
    "FETCH_TIMEOUT": "30000"
  }
}
```

### Key Configuration Choices
1. **Network**: `bridge` - Provides internet access while preventing internal service access
2. **robots.txt**: Ignored - User specifically requested for normal workflow automation
3. **User Agent**: Custom but honest - identifies as automation tool
4. **Timeout**: 30 seconds - reasonable for most documentation sites

## Security Model

### Network Isolation
```yaml
Can Access:
  - Public internet
  - Documentation sites
  - GitHub, Docker Hub
  - Stack Overflow
  
Cannot Access:
  - Internal GitLab (192.168.*.*)
  - Internal Keycloak
  - PostgreSQL databases
  - Other Docker containers
  - Localhost services
```

### Why This Is Safe
- Using default Docker bridge network
- No access to internal Docker networks (gitlab-net, keycloak-net, etc.)
- Cannot reach private IP ranges
- Isolated from sensitive services

## Use Case: Workflow Automation

### User's Intent
- NOT for web scraping or crawling
- For automating normal browser tasks
- Fetching documentation and examples
- Checking for updates and advisories

### Example Workflows
```bash
# Instead of:
1. Open browser
2. Go to Docker Hub
3. Check postgres version
4. Copy description
5. Paste to notes

# Now:
"Fetch the Docker Hub page for postgres and tell me the latest version"
```

## Integration with Other MCP Servers

### With Memory Server
```
Fetch → Store in Memory
"Fetch the GitLab upgrade guide and remember the key steps"
```

### With Docker Gateway
```
Fetch → Execute
"Fetch the docker-compose example and deploy it"
```

## Common Tasks

### Documentation
- Fetch official docs for services
- Get configuration examples
- Retrieve troubleshooting guides

### Updates
- Check latest releases on GitHub
- Get security advisories
- Fetch changelogs

### Research
- Get Stack Overflow solutions
- Fetch blog post tutorials
- Retrieve API documentation

## Testing Results

### Server Info
- Name: mcp-fetch
- Version: 1.2.0
- Protocol: 2024-11-05
- Status: Working

### Capabilities
- ✅ Fetches URLs successfully
- ✅ Converts HTML to Markdown
- ✅ Respects timeout settings
- ✅ Ignores robots.txt as configured

## Best Practices

### When to Use Fetch
- Getting public documentation
- Checking for updates
- Fetching configuration examples
- Retrieving error explanations

### When NOT to Use Fetch
- Accessing internal services (use Docker exec)
- Heavy JavaScript sites (consider Playwright)
- Sites requiring authentication
- Large file downloads

## Maintenance

### Monitor Usage
```bash
# Check if fetch is being used appropriately
docker logs <container_id> | grep fetch
```

### Update Image
```bash
docker pull mcp/fetch:latest
```

## Troubleshooting

### Common Issues

1. **Timeouts**
   - Some sites are slow
   - Increase FETCH_TIMEOUT if needed

2. **Access Denied**
   - Some sites block automation
   - May need different user agent

3. **JavaScript Content**
   - Fetch only gets initial HTML
   - Consider Playwright MCP for JS-heavy sites

4. **Large Content**
   - Use chunked reading with start_index
   - Fetch truncates very large responses

## Security Notes

- robots.txt ignored by user request for legitimate automation
- Not configured for scraping or crawling
- Network isolation prevents internal access
- Honest user agent identifies as automation

## Future Considerations

- May want Playwright MCP for JavaScript-heavy sites
- Could add proxy configuration if needed
- Might implement caching for frequently fetched URLs

---
*Last Updated: 2025-08-27*
*Server Version: 1.2.0*
*Purpose: Workflow automation, not scraping*