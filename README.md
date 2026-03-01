# Gleam Docs MCP 🧙🏾‍♂️

> **The ultimate Model Context Protocol server for [Gleam](https://gleam.run) development** — built natively in Gleam on the BEAM, with zero JavaScript dependencies.

[![CI](https://github.com/criticalinsight/gleam-docs-mcp/actions/workflows/test.yml/badge.svg)](https://github.com/criticalinsight/gleam-docs-mcp/actions)
[![Gleam](https://img.shields.io/badge/gleam-%E2%9C%A8-ffaff3)](https://gleam.run)
[![License](https://img.shields.io/badge/license-Apache--2.0-blue)](LICENSE)

Gleam Docs MCP gives AI assistants (Claude, GPT, Gemini, etc.) deep access to
the Gleam ecosystem — compiler diagnostics, Hex.pm package search, Gloogle type
search, module scaffolding, and sandboxed code evaluation — all over the
[Model Context Protocol](https://modelcontextprotocol.io).

## Why Gleam Docs MCP?

- **Native Gleam** — no Node.js wrapper, runs directly on the BEAM
- **15 tools** — from `gleam check` to Gloogle type search
- **Structured TOML parsing** — dependencies extracted via `tom`, not raw strings
- **Stateless HTTP clients** — zero local state for Hex.pm and Gloogle APIs
- **stdio transport** — plug into any MCP client instantly

## Quick Start

```sh
# Clone and run
git clone https://github.com/criticalinsight/gleam-docs-mcp.git
cd gleam-docs-mcp
gleam deps download
gleam run
```

Add to your MCP client config (e.g. Claude Desktop):

```json
{
  "mcpServers": {
    "gleam-docs": {
      "command": "gleam",
      "args": ["run"],
      "cwd": "/path/to/gleam-docs-mcp"
    }
  }
}
```

## Tools (15)

### Project Diagnostics

| Tool | Description |
|---|---|
| `get_compiler_diagnostics` | Run `gleam check` on a project |
| `format_project` | Run `gleam format` on a project |

### Local Discovery & Scaffolding

| Tool | Description |
|---|---|
| `list_dependencies` | Parse `gleam.toml` and return structured dependency tables |
| `list_local_modules` | List `.gleam` files in the project's `src/` tree |
| `scaffold_gleam_module` | Create a new Gleam module with recursive directory creation |
| `get_symbol_context` | Extract source context for a local symbol |

### Code Execution

| Tool | Description |
|---|---|
| `evaluate_snippet` | Evaluate a Gleam snippet in a sandboxed temporary project |

### Ecosystem Search

| Tool | Description |
|---|---|
| `gloogle_search` | Search functions by type signature via [Gloogle](https://gloogle.run) |
| `search_hex_packages` | Search [Hex.pm](https://hex.pm) for Gleam packages |
| `get_package_releases` | Get release history for a Hex package |

### Module Introspection

| Tool | Description |
|---|---|
| `search_functions` | Search for functions within a package |
| `search_types` | Search for types within a package |
| `get_modules` | List modules in a Hex package |
| `get_module_info` | Get detailed documentation for a specific module |

## Resources

| URI | Description |
|---|---|
| `gleam://packages` | Feed of popular Gleam packages from Hex.pm |

## Architecture

- **Pure Gleam on BEAM** — no JavaScript wrappers or Node.js runtime
- **Erlang FFI** (`mcp_ffi.erl`) for safe dynamic JSON parsing
- **`tom` TOML parser** for structured project config analysis
- **`gleam_httpc`** for stateless Hex.pm and Gloogle API calls
- **stdio transport** — works with Claude Desktop, MCP Inspector, and more

## Dependencies

| Package | Purpose |
|---|---|
| `gleam_stdlib` | Core standard library |
| `gleam_http` / `gleam_httpc` | HTTP client for API calls |
| `gleam_json` | JSON encoding/decoding |
| `gleam_erlang` | Erlang interop for CLI wrapping |
| `simplifile` | Cross-target file system operations |
| `filepath` | Path manipulation utilities |
| `tom` | TOML parsing |

## Development

```sh
gleam run          # Start the server
gleam test         # Run tests
gleam docs build   # Generate HTML docs
gleam format src test  # Format source
```

## Keywords

`gleam`, `mcp`, `model-context-protocol`, `beam`, `erlang`, `ai-tools`,
`llm-tools`, `gleam-lang`, `hex-pm`, `gloogle`, `developer-tools`,
`code-intelligence`, `gleam-mcp`, `gleam-development`

## License

Apache-2.0
