# Raketen Neovim Configuration

A modular Neovim configuration based on [lazy.nvim](https://github.com/folke/lazy.nvim).

## Prerequisites & System Dependencies

This configuration relies on **Mason.nvim** to manage language servers (LSP), formatters, and linters. Mason does **not** include the runtimes required to run these tools. You must install the following dependencies on your system for Mason to work correctly.

### Essential Dependencies
- **Neovim** >= 0.10.0
- **Git** (for package management)
- **C Compiler** (gcc or clang) - Required for Treesitter parsers
- **Curl** & **Unzip** - Required for Mason to download packages

### Mason Dependencies (LSP/Formatters)
If you encounter errors like `spawn: npm failed`, you are missing these runtimes:

- **Node.js & npm**: Required for most LSPs (TypeScript, HTML, CSS, JSON, Pyright, etc.)
  ```bash
  # Debian/Ubuntu/Mint
  sudo apt install nodejs npm
  ```
- **Python3 & Pip**: Required for Python tools
  ```bash
  sudo apt install python3 python3-pip venv
  ```
- **Go**: Required for Go tools (gopls)
  ```bash
  sudo apt install golang
  ```
- **Cargo (Rust)**: Required for Rust tools
  ```bash
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  ```

## Structure

The configuration follows a standard `lazy.nvim` structure:

```text
~/.config/nvim/
├── init.lua                # Entry point
├── lua/
│   └── raketen/
│       ├── init.lua        # Core options & leader key
│       ├── lazy_init.lua   # Lazy.nvim bootstrapping
│       ├── remap.lua       # Keymaps
│       ├── set.lua         # Vim options
│       └── lazy/           # Plugin specifications
└── lazy-lock.json          # Plugin lockfile
```

## Setup

1. Backup your existing config:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. Clone this repository:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

3. Start Neovim:
   ```bash
   nvim
   ```
   Lazy.nvim will automatically bootstrap and install plugins. Run `:checkhealth` to verify your environment.
