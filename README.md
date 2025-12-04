# neovim-config

Personal Neovim configuration using lazy.nvim and native LSP.

## Requirements

- Neovim 0.10+
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons)
- `fd` or `rg` (recommended for FZF)

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/neovim-config ~/.config/nvim
nvim
```

Lazy.nvim will bootstrap itself and install all plugins on first launch.

## Structure

```
├── init.lua                 # Entry point, bootstraps lazy.nvim
├── lua/
│   ├── config/
│   │   ├── options.lua      # Vim options
│   │   ├── autocmds.lua     # Autocommands
│   │   └── keymaps.lua      # Key mappings
│   └── plugins/
│       ├── init.lua         # Plugin specs
│       └── colors.lua       # Colorscheme (onedark)
```

## Key Bindings

**Leader**: `<Space>` | **Local Leader**: `,`

### Navigation
| Key | Action |
|-----|--------|
| `<C-p>` / `<leader>ff` / `<leader>e` | Find files (FZF) |
| `<M-\>` | Toggle NERDTree |
| `<leader>fo` | Open buffers |
| `<leader>fm` | Recent files |
| `<leader>f.` | Last buffer |
| `<leader>f-` | File browser (current dir) |

### Search
| Key | Action |
|-----|--------|
| `<leader>sf` | Find in directory (ripgrep) |
| `<leader>st` | Find tags |
| `<leader>sl` | Lines in open files |
| `<leader>sb` | Lines in buffer |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gy` | Go to type definition |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` / `<leader>lk` | Hover docs |
| `<leader>la` | Code action |
| `<leader>lr` | Rename symbol |
| `<leader>l=` | Format buffer |
| `<leader>ld` | Line diagnostics |
| `<leader>ls` | Symbols (tags) |
| `<leader>lt` | Toggle Vista tagbar |
| `[d` / `]d` | Prev/next diagnostic |

### Git
| Key | Action |
|-----|--------|
| `<leader>gs` | Git status |
| `<leader>gb` | Git blame |
| `<leader>gc` | Commits (FZF) |
| `<leader>gC` | Buffer commits (FZF) |
| `<leader>gd` | Diff split |
| `<leader>gl` | Log (oneline) |
| `<leader>gL` | Log (full) |
| `<leader>gp` | Push |
| `<leader>gP` | Pull |
| `<leader>gf` | Fetch |
| `<leader>gw` | Stage file |
| `<leader>gr` | Revert file |
| `<leader>o` | Open in GitHub |
| `]c` / `[c` | Next/prev hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hu` | Undo hunk |
| `<leader>ht` | Toggle GitGutter |

### Testing
| Key | Action |
|-----|--------|
| `<leader>tt` | Test nearest |
| `<leader>tf` | Test file |
| `<leader>ts` | Test suite |
| `<leader>tg` | Visit last test file |

### Editing
| Key | Action |
|-----|--------|
| `<CR>` | Save file |
| `<Esc>` | Clear search highlight |
| `<C-l>` | Full redraw / fix highlight |
| `Y` | Yank line |
| `<C-_>` | Toggle comment |
| `>` / `<` (visual) | Indent and reselect |
| `<Tab>` / `<S-Tab>` (visual) | Indent/unindent |
| `ga` (visual) | Align selection |
| `<M-n>` / `<M-p>` | Next/prev ALE error |
| `<C-j>` | Snippet expand/jump (insert) |
| `<C-k>` | Snippet jump back (insert) |
| `;fws` | Fix trailing whitespace |

### Completion (nvim-cmp)
| Key | Action |
|-----|--------|
| `<Tab>` / `<S-Tab>` | Select next/prev item |
| `<CR>` | Confirm selection |
| `<C-Space>` | Trigger completion |
| `<C-e>` | Abort completion |
| `<C-b>` / `<C-f>` | Scroll docs |

### Plugin Management
| Prefix | Plugin |
|--------|--------|
| `<leader>pl` | Lazy (l=UI, s=sync, u=update, i=install, c=clean, k=check, r=restore, p=profile, g=log, h=health) |
| `<leader>pm` | Mason (m=UI, u=update, l=log) |
| `<leader>pt` | Treesitter (t=update, i=info, m=modules) |
| `<leader>pa` | ALE (a=toggle, f=fix, l=lint, i=info, d=detail, n=next, p=prev) |
| `<leader>pn` | NERDTree (n=toggle, f=find, r=refresh, c=CWD) |
| `<leader>ps` | Sessions (s=save, o=open, d=delete, c=close, v=view) |

### Utility
| Key | Action |
|-----|--------|
| `;cp` | Copy mode (hide line numbers, git, ALE) |
| `;pc` | Print mode (show line numbers, git, ALE) |
| `%%` (cmdline) | Insert current file directory |

## LSP Servers

Mason auto-installs: `gopls`, `ts_ls`, `pyright`, `rust_analyzer`, `bashls`, `cssls`, `html`, `jsonls`, `yamlls`, `sqls`, `lua_ls`

## Plugins

- **Completion**: nvim-cmp + LuaSnip
- **LSP**: mason.nvim + nvim-lspconfig
- **Linting**: ALE
- **Syntax**: Treesitter
- **Git**: Fugitive + GitGutter
- **Files**: FZF + NERDTree
- **Status**: Lightline
- **Keys**: which-key.nvim
