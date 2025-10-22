# Neovim Configuration Agent Guidelines

## Build/Lint/Test Commands
- **Lint**: ALE handles linting automatically (enabled by default)
- **Test nearest**: `<leader>tt` or `:TestNearest`
- **Test file**: `<leader>tf` or `:TestFile`
- **Test suite**: `<leader>ts` or `:TestSuite`
- **Visit last test**: `<leader>tg` or `:TestVisit`

## Architecture & Structure
- **Plugin manager**: lazy.nvim with plugin definitions in `lua/plugins/`
- **Config structure**: Core settings in `lua/config/` (options, keymaps, autocmds)
- **Languages**: Go, Kotlin support with language-specific plugins
- **LSP/Completion**: CoC (Conquer of Completion) for language server features
- **Key navigation**: Space as leader, comma as local leader

## Code Style Guidelines
- **Indentation**: 4 spaces by default, expandtab enabled
- **Language-specific**:
  - Go: tabs (noexpandtab), 4-space width
- **Line endings**: No trailing whitespace (use `:FixWhitespace`)
- **Naming**: Standard vim/lua conventions, snake_case for lua functions
- **Imports**: Organized by functionality in plugin files
- **Error handling**: ALE for async linting, vim-test for test integration
