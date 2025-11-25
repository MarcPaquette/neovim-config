# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuration Overview

This is a Neovim configuration using **lazy.nvim** as the plugin manager. The configuration uses native Neovim LSP via Mason + nvim-cmp + LuaSnip for completion.

## Key Architecture

- **Entry point**: `init.lua` - Sets leader keys, bootstraps lazy.nvim, loads config modules in order
- **Core config**: `lua/config/` - options.lua → autocmds.lua → keymaps.lua (loaded after plugins)
- **Plugins**: `lua/plugins/` - Lazy plugin specs (init.lua, colors.lua, lang-go.lua)

## Testing Commands

- `<leader>tt` or `:TestNearest` - Run nearest test
- `<leader>tf` or `:TestFile` - Run current file tests
- `<leader>ts` or `:TestSuite` - Run full test suite
- `<leader>tg` or `:TestVisit` - Visit last test file

## Linting

ALE handles async linting with `ale_fix_on_save = 1`. Navigate errors with `<M-n>` / `<M-p>`.

## LSP Keymaps

All LSP navigation uses native vim.lsp.buf:
- `gd` - Go to definition
- `gr` - Find references
- `gi` - Go to implementation
- `gy` - Go to type definition
- `<leader>la` - Code action
- `<leader>lr` - Rename symbol
- `<leader>l=` - Format

## Navigation

- `<C-p>` or `<leader>ff` - FZF file search
- `<M-\>` - Toggle NERDTree
- `<leader>gs` - Git status (Fugitive)
- `]c` / `[c` - Next/prev git hunk

## Code Style

- **Default**: 4 spaces, expandtab
- **Go**: Tabs (noexpandtab), 4-width
- **Ruby**: 2 spaces

## Important Notes

- Leader key is `<Space>`, local leader is `,`
- `<CR>` in normal mode saves the current file (except in special buffers)
- WhichKey provides key discovery on leader press
- Mason auto-installs LSP servers: gopls, ts_ls, pyright, rust_analyzer, bashls, cssls, html, jsonls, yamlls
