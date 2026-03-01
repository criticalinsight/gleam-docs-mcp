# Native Gleam MCP Server 🧙🏾‍♂️

A native Gleam implementation of a Model Context Protocol (MCP) server providing
comprehensive Gleam development tooling, package introspection, and ecosystem
search capabilities. Built from the ground up in Gleam on the BEAM — no Node.js
required. Follows the Rich Hickey philosophy of simple, focused components.

## Tools (15)

### Project Diagnostics
| Tool | Description |
|---|---|
| `get_compiler_diagnostics` | Run `gleam check` on a project |
| `format_project` | Run `gleam format` on a project |

### Local Discovery & Scaffolding
| Tool | Description |
|---|---|
| `list_dependencies` | Parse `gleam.toml` with `tom` and return structured dependency tables |
| `list_local_modules` | List `.gleam` files in the project's `src/` tree |
| `scaffold_gleam_module` | Safely create a new Gleam module with recursive directory creation |
| `get_symbol_context` | Extract source context for a local symbol |

### Code Execution
| Tool | Description |
|---|---|
| `evaluate_snippet` | Evaluate a Gleam snippet in a sandboxed temporary project |

### Ecosystem Search
| Tool | Description |
|---|---|
| `gloogle_search` | Search Gleam functions by type signature or name via [Gloogle](https://gloogle.run) |
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
- **Erlang FFI layer** (`mcp_ffi.erl`) for safe dynamic JSON parsing
- **Structured TOML parsing** via the `tom` package (replaces naive string reading)
- **Stateless HTTP clients** for Hex.pm and Gloogle APIs via `gleam_httpc`
- **stdio transport** — intended to be invoked by an MCP client (Claude Desktop, MCP Inspector, etc.)

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

## Usage

Run the server:
```sh
gleam run
```

Build docs:
```sh
gleam docs build
```

Run tests:
```sh
gleam test
```

> [!NOTE]
> This server uses stdio for transport. It is intended to be invoked by an MCP
> client rather than run interactively.
