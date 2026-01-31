# Agent Instructions & Repository Guidelines

This document contains instructions for AI agents (and human developers) working on this Neovim configuration.
Adhere strictly to these guidelines to maintain stability and consistency.

## 1. Repository Context & Environment
- **Project**: Neovim configuration based on `lazy.nvim`.
- **Primary Language**: Lua 5.1 / LuaJIT (Neovim flavor).
- **Core Frameworks**: `lazy.nvim` (plugins), `mason.nvim` (tooling), `nvim-lspconfig` (LSP), `conform.nvim` (formatting).
- **Neovim Version**: Expect >= 0.10.0 (uses `vim.snippet.expand`, modern API).

## 2. Project Structure
The configuration follows a modular namespace pattern under `lua/raketen/`.

```text
/home/thomas/.config/nvim/
├── init.lua                # Entry point (minimal, requires raketen)
├── lazy-lock.json          # Plugin version lockfile (Handle with care)
├── AGENTS.md               # This file
└── lua/
    └── raketen/
        ├── init.lua        # Bootstrap: leader key, core modules
        ├── lazy_init.lua   # Lazy.nvim bootstrap & setup
        ├── remap.lua       # Global keymaps
        ├── set.lua         # vim.opt settings
        └── lazy/           # Plugin specifications (One file per plugin/topic)
            ├── lsp.lua     # LSP, Mason, CMP, Conform setup
            ├── treesitter.lua
            └── ...
```

## 3. Build, Lint, and Test Commands

Since this is a configuration repository, "building" means loading the config in Neovim without errors.

### Verification (The "Test" Phase)
There is no automated unit test suite. You must verify changes by simulating the runtime environment.

1.  **Syntax Check**: Before applying changes, verify Lua syntax if possible.
    *   Command: `luac -p filename.lua` (if `luac` is available)
2.  **Headless Load (Smoke Test)**:
    *   Command: `nvim --headless -u init.lua '+qall'`
    *   *Goal*: Ensure no error messages appear on stdout/stderr during startup.
3.  **Plugin Sync**:
    *   If you added/modified plugins, run: `nvim --headless -u init.lua "+Lazy! sync" +qa`
4.  **Health Check**:
    *   Command: `nvim -u init.lua -c "checkhealth" -c "only" -c "write! health.log" -c "qa"`
    *   *Action*: Read `health.log` to identify issues.

### Formatting & Linting
The project uses `conform.nvim` for formatting.
- **Lua**: Uses `stylua` (indent: 2 spaces).
- **Manual Trigger**: Inside nvim, `<leader>l` triggers formatting.
- **Agent Guideline**: Write code that is already formatted. Do not rely on auto-formatting hooks being present in your shell environment.
    - Indentation: 2 spaces.
    - Quotes: Double quotes `"` preferred for strings.
    - Trailing commas: Yes, in tables (multi-line).

## 4. Code Style & Conventions

### Lua & Neovim API
- **Namespace**: All core modules live in `raketen.*`.
- **Locals**: Avoid global variables. Use `local` everywhere.
- **Vim API**: Prefer `vim.opt`, `vim.keymap.set`, `vim.api.nvim_*`.
    - *Bad*: `vim.cmd("set number")`
    - *Good*: `vim.opt.number = true`
- **Error Handling**:
    - Use `pcall` when requiring optional modules.
    - Example: `local ok, mod = pcall(require, "module_name"); if not ok then return end`

### Plugin Specifications (`lua/raketen/lazy/*.lua`)
Each file should return a **single table** (the plugin spec) or a **list of specs**.
- **Pattern**:
    ```lua
    return {
      "username/repo",
      dependencies = { "dep1", "dep2" },
      event = "VeryLazy", -- Use lazy loading keys when appropriate
      config = function()
         require("repo").setup({ ... })
      end
    }
    ```
- **Dependencies**: Define them inline within the spec.
- **Config**: Use `config = function() ... end` for setup logic, not `opts = {}` unless the plugin specifically supports it and you don't need custom logic.

### Keymaps
- Define global keymaps in `lua/raketen/remap.lua`.
- Define plugin-specific keymaps in the plugin's `config` function or `keys` table in the spec.
- **Desc**: ALWAYS provide a `{ desc = "..." }` field for keymaps.
    - Example: `vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })`

## 5. Agentic Workflows

### Task: Adding a New Plugin
1.  **Search**: Check `lua/raketen/lazy/` to ensure it doesn't already exist.
2.  **Create**: Create a new file `lua/raketen/lazy/<plugin_name>.lua`.
3.  **Define**: Add the standard `return { ... }` block.
4.  **Verify**: Run the Headless Smoke Test command.

### Task: Refactoring LSP
The `lsp.lua` file is dense. It handles:
- `mason` (installer)
- `mason-lspconfig` (bridge)
- `cmp` (completion)
- `conform` (formatting)
- Global `on_attach`
**Rule**: Be extremely careful when editing `on_attach`. It affects ALL language servers.

### Task: Debugging
If you need to debug why a setting isn't applying:
1.  Use `print(vim.inspect(...))` in the Lua code.
2.  Run nvim interactively or check `:messages`.
3.  **Do not leave print statements** in the final code.

## 6. Safety & Git Protocol
- **Secrets**: NEVER commit API keys or absolute paths to home directories (use `vim.fn.stdpath("data")` or `os.getenv("HOME")`).
- **Lazy Lock**: Do not manually edit `lazy-lock.json`. Let the sync command handle it.
- **Commits**:
    - Format: `<scope>: <description>`
    - Scopes: `feat`, `fix`, `chore`, `docs`, `style`.
    - Example: `feat(lsp): add gopls server`
    - Example: `fix(remap): correct visual mode paste behavior`

## 7. Cursor/Copilot Rules
(No specific external rules found in .cursor/ or .github/)
- **Assume**: The user is an experienced Neovim user but relies on you for Lua syntax correctness and API details.
