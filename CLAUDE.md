# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration written in Lua that uses Lazy.nvim as the plugin manager. The configuration provides a modern IDE-like experience with LSP support, Telescope fuzzy finding, Treesitter syntax highlighting, and various formatting/linting tools.

## Architecture

The configuration follows a modular structure:
- `init.lua` - Entry point that loads the `raketen` module
- `lua/raketen/init.lua` - Main module that sets leader key and loads submodules in order
- `lua/raketen/lazy_init.lua` - Bootstraps and configures Lazy.nvim plugin manager
- `lua/raketen/lazy/` - Plugin specifications loaded by Lazy.nvim
- `lua/raketen/remap.lua` - Custom key mappings
- `lua/raketen/set.lua` - Vim options, LSP keymaps, and WSL clipboard configuration

## Key Components

### Plugin Management
- Uses Lazy.nvim for plugin management with lazy loading
- Plugin specifications are organized in `lua/raketen/lazy/` directory
- Lock file at `lazy-lock.json` tracks exact plugin versions

### Language Server Protocol (LSP)
Configured LSP servers:
- `gopls` - Go
- `ts_ls` - TypeScript/JavaScript  
- `svelte` - Svelte
- `pyright` - Python
- `cssls` - CSS

### Formatting & Linting
- **Formatters**: `gofmt` (Go), `stylua` (Lua), `prettier`/`prettierd` (JS)
- **Linters**: `flake8` (Python) via nvim-lint
- Auto-format on save configured via LSP

### UI Components
- **Statusline**: Lualine with tokyonight theme showing mode, branch, diagnostics, filename, and file info

### Key Mappings
- Leader key: `<Space>`
- Telescope: `<leader>ff` (find files), `<leader>fg` (live grep), `<leader>fb` (buffers)
- File browser: `<leader>e`
- LSP: `gd` (definition), `gr` (references), `K` (hover), `<F2>` (rename)

## Commands

### Installing/Updating Plugins
```bash
# Open Neovim and Lazy will auto-install missing plugins
nvim

# Inside Neovim:
:Lazy sync    # Update all plugins
:Lazy update  # Update plugins
:Lazy clean   # Remove unused plugins
```

### LSP Commands
```vim
:LspInfo      # Show LSP server status
:LspInstall   # Install LSP servers (if using mason)
:LspRestart   # Restart LSP servers
```

### Treesitter Commands
```vim
:TSInstall <language>    # Install parser for language
:TSUpdate                 # Update all parsers
:TSInstallInfo           # Show installed parsers
```

## Development Notes

- Configuration uses WSL-specific clipboard settings for Windows Subsystem for Linux
- Tab size is set to 2 spaces with auto-indent
- Arrow keys are disabled in normal mode to encourage hjkl navigation
- Auto-pairs for brackets are configured in insert mode
- Color scheme is set to tokyonight-day