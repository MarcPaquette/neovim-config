# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuration Overview

This is a Neovim configuration using **lazy.nvim** as the plugin manager. The configuration uses native Neovim LSP via Mason + nvim-cmp + LuaSnip for completion. ALE handles async linting (with `ale_fix_on_save = 1`, LSP features disabled via `ale_disable_lsp = 1`).

## Architecture

- **Entry point**: `init.lua` — Sets leader keys, bootstraps lazy.nvim, loads config modules in order
- **Core config**: `lua/config/` — loaded in order: options.lua → autocmds.lua → (plugins) → keymaps.lua
- **Plugins**: `lua/plugins/` — Lazy plugin specs (`init.lua` for all plugins, `colors.lua` for colorscheme)
- **Keymaps are loaded last** so they can reference plugin APIs (e.g., LuaSnip). LSP keymaps live in `plugins/init.lua` inside an `LspAttach` autocmd, not in `keymaps.lua`.

## Keymap Conventions

- Leader is `<Space>`, local leader is `,`
- `<CR>` in normal mode saves the current file (except in special buffers like NERDTree, quickfix)
- Keymaps use `vim.keymap.set` via a local `map` alias
- Groups follow a prefix pattern with WhichKey labels defined in `plugins/init.lua`:
  - `<leader>g*` — git, `<leader>f*` — files, `<leader>l*` — LSP, `<leader>s*` — search
  - `<leader>t*` — testing, `<leader>c*` — spell, `<leader>h*` — hunks
  - `<leader>p**` — plugin management (nested: `pa` ALE, `pl` Lazy, `pm` Mason, `pn` NERDTree, `ps` sessions, `pt` Treesitter)
- When adding a new keymap group, also add the WhichKey group label in `plugins/init.lua`'s `wk.add()` call

## Code Style (filetype settings)

- **Default**: 4 spaces, expandtab (options.lua)
- **Go**: Tabs, 4-width (autocmds.lua); formatting handled by vim-go (`goimports`)
- **Ruby**: 2 spaces (autocmds.lua)
- **Makefile**: Tabs (autocmds.lua)
- vim-sleuth is installed and auto-detects indent for other filetypes

## LSP Setup

Mason auto-installs servers configured in `plugins/init.lua`: gopls, ts_ls, pyright, rust_analyzer, bashls, cssls, html, jsonls, yamlls, sqls, lua_ls. All servers share the same `cmp_nvim_lsp` capabilities. vim-go's LSP features are disabled (`go_gopls_enabled = 0`) to avoid conflicts with the native LSP setup.

## Important Notes

- Keybind documentation lives in `README.md` — update it when changing keymaps
- Plugin globals (e.g., `vim.g.gitgutter_map_keys = 0`) that disable default plugin keymaps are in `keymaps.lua`, not in the plugin spec
- FZF commands are prefixed with `FZF` (e.g., `:FZFFiles`, `:FZFRg`) via `fzf_command_prefix`
