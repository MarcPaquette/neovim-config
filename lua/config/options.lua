-- lua/config/options.lua
-- Core Neovim options and settings

local o = vim.opt

-----------------------------------------------------------------------
-- Encoding
-----------------------------------------------------------------------
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.fileencodings = "utf-8,ucs-bom,gb18030,gbk,gb2312,cp936"

-----------------------------------------------------------------------
-- Indentation
-----------------------------------------------------------------------
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true

-----------------------------------------------------------------------
-- UI
-----------------------------------------------------------------------
o.number = true
o.termguicolors = true
o.title = true
o.showmode = false              -- Hidden because lightline shows mode
o.laststatus = 2                -- Always show statusline
o.wrap = false
o.scrolloff = 5                 -- Lines to keep above/below cursor
o.pumheight = 20                -- Popup menu height
o.showmatch = true              -- Highlight matching brackets
o.matchtime = 1                 -- Tenths of second to show match
o.cursorline = false            -- Managed by autocmds
o.linespace = 0
o.gcr = "a:blinkon0"            -- Disable cursor blinking
o.fillchars = "vert:│,stl: ,stlnc: "
o.listchars = { trail = "·", precedes = "«", extends = "»", eol = "↲", tab = "▸ " }
o.list = false                  -- Toggle with :set list

-----------------------------------------------------------------------
-- Editing behavior
-----------------------------------------------------------------------
o.hidden = true                 -- Allow hidden buffers
o.mouse = "a"                   -- Enable mouse in all modes
o.mousehide = true              -- Hide mouse while typing
o.backspace = { "indent", "eol", "start" }
o.splitright = true             -- Vertical splits open right
o.report = 0                    -- Always report changed lines

-----------------------------------------------------------------------
-- Search
-----------------------------------------------------------------------
o.ignorecase = true
o.smartcase = true              -- Case-sensitive if uppercase present
o.incsearch = true              -- Incremental search
o.hlsearch = true               -- Highlight matches
o.inccommand = "nosplit"        -- Live substitution preview

-----------------------------------------------------------------------
-- Performance
-----------------------------------------------------------------------
o.updatetime = 100              -- Faster CursorHold events
o.timeoutlen = 700              -- Time for mapped sequence
o.ttimeoutlen = 0               -- No delay for key codes
-- Note: lazyredraw removed - causes display issues in modern Neovim

-----------------------------------------------------------------------
-- Completion
-----------------------------------------------------------------------
o.completeopt = "noinsert,menuone,noselect"
o.complete:remove("i")          -- Don't scan included files
o.complete:remove("t")          -- Don't scan tags
o.shortmess:append("c")         -- Don't show completion messages
o.wildmode = "list:longest"     -- Command-line completion mode

-----------------------------------------------------------------------
-- Files and backup
-----------------------------------------------------------------------
o.autoread = true               -- Reload files changed outside vim
o.autowriteall = true           -- Auto-save when switching buffers
o.undofile = true               -- Persistent undo
o.undolevels = 1000
o.undoreload = 10000
o.directory = "/tmp//,."        -- Swap file location
o.backupdir = "/tmp//,."        -- Backup file location
o.viewoptions = "cursor,folds,slash,unix"

-----------------------------------------------------------------------
-- Folding
-----------------------------------------------------------------------
o.foldenable = true
o.foldmethod = "marker"
o.foldmarker = "{{{,}}}"
o.foldlevel = 0
o.foldlevelstart = 99           -- Start with all folds open

-----------------------------------------------------------------------
-- Security
-----------------------------------------------------------------------
o.modeline = false              -- Disable modeline (security risk)
o.modelines = 10

-----------------------------------------------------------------------
-- Language-specific globals
-----------------------------------------------------------------------
vim.g.rubycomplete_buffer_loading = 1
vim.g.rubycomplete_classes_in_global = 1
vim.g.rubycomplete_rails = 1
