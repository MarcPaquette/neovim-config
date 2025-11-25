# Neovim Configuration Agent Guidelines

## Build/Lint/Test Commands
- **Lint**: ALE handles async linting (enabled by default)
- **Test nearest**: `<leader>tt` or `:TestNearest`
- **Test file**: `<leader>tf` or `:TestFile`
- **Test suite**: `<leader>ts` or `:TestSuite`
- **Visit last test**: `<leader>tg` or `:TestVisit`

## Architecture & Structure
- **Plugin manager**: lazy.nvim with specs in `lua/plugins/` (init.lua, colors.lua)
- **Config structure**: Core in `lua/config/` (options.lua, keymaps.lua, autocmds.lua)
- **Languages**: Go (vim-go), Kotlin (kotlin-vim) with specific plugins
- **LSP/Completion**: Native nvim-lsp via Mason + nvim-cmp + LuaSnip; ALE for linting
- **Navigation**: Space leader, comma local leader; FZF for files, NERDTree for tree
- **Key components**: Fugitive/GitGutter for Git, Lightline for status, folke/which-key for discovery

## Code Style Guidelines
- **Indentation**: 4 spaces default, expandtab; Go uses tabs (noexpandtab)
- **Formatting**: `:FixWhitespace` for trailing spaces; consistent with vim/lua standards
- **Naming**: snake_case for Lua functions, camelCase for JS/TS, standard vim conventions
- **Imports**: Grouped by functionality in plugin configs; use Lua require for modules
- **Error handling**: ALE highlights; vim-test integration for running tests
- **Files**: init.lua bootstraps; no Cursor/Claude/Windsurf/Cline/Goose/Copilot rules found
