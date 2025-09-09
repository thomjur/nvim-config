# Repository Guidelines

## Project Structure & Module Organization
- Root config: `init.lua` bootstraps plugins and core modules under `lua/`.
- Core modules: `lua/raketen/`
  - Settings: `lua/raketen/set.lua`
  - Keymaps: `lua/raketen/remap.lua`
  - Plugin bootstrap: `lua/raketen/lazy_init.lua`
  - Plugin specs: `lua/raketen/lazy/*.lua` (one file per plugin/topic).
- Lockfile: `lazy-lock.json` pins plugin versions; commit meaningful updates.

## Build, Test, and Development Commands
- Run with this config: `nvim -u init.lua` (from repo root).
- Install/update plugins: `nvim -u init.lua '+Lazy! sync' +qa`.
- Health checks: inside Neovim run `:checkhealth` and `:Lazy health`.
- LSP/Tooling: open `:Mason` to review installed servers and tools (if configured).
- Headless smoke test: `nvim --headless -u init.lua '+qall'` (verifies init without UI errors).

## Coding Style & Naming Conventions
- Language: Lua. Indent with 2 spaces, no tabs; keep lines readable (<100 cols when practical).
- Modules: use `raketen.*` namespace (e.g., `require('raketen.set')`).
- Plugin specs: place under `lua/raketen/lazy/`; name files after the plugin or feature (e.g., `treesitter.lua`, `nvim-lint.lua`).
- Formatting: prefer `stylua` locally (`stylua lua/`). Avoid trailing whitespace and unused locals.

## Testing Guidelines
- After changes, run: `nvim -u init.lua '+Lazy! sync'` then `:checkhealth`.
- Validate core flows: open a file, confirm LSP attaches, diagnostics render, and keymaps respond.
- For linters: trigger manually if needed (e.g., run a lint command or save a supported file).
- Keep changes small; document manual test steps in PRs.

## Commit & Pull Request Guidelines
- Commits: short, imperative subject (e.g., "lsp: add lua_ls"), followed by a brief body when needed.
- Scope commits by feature (settings, keymaps, plugin). Update `lazy-lock.json` in the same commit when relevant.
- PRs: include a clear description, rationale, and before/after notes or screenshots for UI/UX changes. Link related issues.

## Security & Configuration Tips
- Do not commit secrets or machine-specific paths. Prefer per-host overrides outside the repo.
- When adding plugins: create a new spec file under `lua/raketen/lazy/`, run `:Lazy sync`, and verify with `:Lazy health`.
