-- lua/config/keymaps.lua
local map = vim.keymap.set
local cmd = vim.cmd

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-----------------------------------------------------------------------
-- Search behavior
-----------------------------------------------------------------------
map("n", "n", "nzzzv", { desc = "Next search result centered" })
map("n", "N", "Nzzzv", { desc = "Prev search result centered" })

-- Full redraw to fix syntax highlighting bugs
map("n", "<C-l>", ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>", { silent = true, desc = "Full redraw / fix highlight" })

-----------------------------------------------------------------------
-- coc.nvim
-----------------------------------------------------------------------
-- Snippet navigation
map("i", "<C-j>", "<Plug>(coc-snippets-expand-jump)", { silent = true })
map("v", "<C-j>", "<Plug>(coc-snippets-select)", { silent = true })
vim.g.coc_snippet_next = "<c-j>"
vim.g.coc_snippet_prev = "<c-k>"

-- Trigger completion manually
map("i", "<M-Space>", 'coc#refresh()', { expr = true, silent = true })

-- Completion navigation
map("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true })
map("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true })

-----------------------------------------------------------------------
-- ALE
-----------------------------------------------------------------------
map("n", "<M-p>", "<Plug>(ale_previous_wrap)", { silent = true })
map("n", "<M-n>", "<Plug>(ale_next_wrap)", { silent = true })

-----------------------------------------------------------------------
-- Commentary
-----------------------------------------------------------------------
map("x", "<C-_>", "<Plug>Commentary", {})
map("o", "<C-_>", "<Plug>Commentary", {})
map("n", "<C-_>", "<Plug>CommentaryLine", {})

-----------------------------------------------------------------------
-- Editing enhancements
-----------------------------------------------------------------------
map("n", "Y", "yy", { desc = "Yank line like D and C" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", "<Tab>", ">gv", { desc = "Indent with Tab" })
map("v", "<S-Tab>", "<gv", { desc = "Unindent with Shift-Tab" })

-- Save with Enter (when appropriate)
vim.api.nvim_create_user_command("FixWhitespace", "%s/\\s\\+$//e", {})
vim.keymap.set("n", ";fws", ":FixWhitespace<CR>", { desc = "Fix trailing whitespace" })

local function should_save_on_enter()
  local bufnr = vim.api.nvim_get_current_buf()
  local name = vim.api.nvim_buf_get_name(bufnr)
  local bt = vim.bo[bufnr].buftype
  return not name:match("swoopBuf") and bt == ""
end
map("n", "<CR>", function()
  if should_save_on_enter() then
    cmd("write")
  else
    return "<CR>"
  end
end, { expr = true, silent = true, desc = "Save with Enter" })

-- Escape clears search highlight
map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-----------------------------------------------------------------------
-- Disable default plugin keymaps
-----------------------------------------------------------------------
vim.g.swoopUseDefaultKeyMap = 0
vim.g.gitgutter_map_keys = 0
vim.g.dispatch_no_maps = 1

-----------------------------------------------------------------------
-- Command-line path expansion
-----------------------------------------------------------------------
map("c", "%%", "expand('%:h').'/'", { expr = true, desc = "Insert current file dir" })
map("c", "<C-P>", "<C-R>=expand('%:p:h') . '/' <CR>", { desc = "Insert current file dir (full path)" })

-----------------------------------------------------------------------
-- FZF and files
-----------------------------------------------------------------------
map("n", "<C-p>", ":FZFFiles<CR>", { silent = true, desc = "FZF Files" })
map("n", "<leader>ff", ":FZFFiles<CR>", { silent = true, desc = "File Search" })
map("n", "<leader>e", ":FZFFiles<CR>", { silent = true, desc = "FZF Files" })
map("n", "<silent> <leader>f-", ":execute(':FZFFiles ' . expand('%:h'))<CR>", { desc = "File Browser" })

-----------------------------------------------------------------------
-- GitGutter hunks navigation
-----------------------------------------------------------------------
map("n", "]c", "<Plug>(GitGutterNextHunk)")
map("n", "[c", "<Plug>(GitGutterPrevHunk)")

-----------------------------------------------------------------------
-- Testing commands (vim-test)
-----------------------------------------------------------------------
map("n", "<leader>tt", ":TestNearest<CR>", { silent = true })
map("n", "<leader>tf", ":TestFile<CR>", { silent = true })
map("n", "<leader>ts", ":TestSuite<CR>", { silent = true })
map("n", "<leader>tg", ":TestVisit<CR>", { silent = true })

-----------------------------------------------------------------------
-- Git commands
-----------------------------------------------------------------------
map("n", "<leader>gs", ":Git<CR>", { silent = true })
map("n", "<leader>gc", ":Commits<CR>", { silent = true })
map("n", "<leader>gk", ":BCommits<CR>", { silent = true })
map("n", "<leader>gb", ":Git blame<CR>", { silent = true })

-----------------------------------------------------------------------
-- coc LSP-like keymaps
-----------------------------------------------------------------------
map("n", "gd", "<Plug>(coc-definition)", { silent = true })
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
map("n", "gi", "<Plug>(coc-implementation)", { silent = true })
map("n", "gr", "<Plug>(coc-references)", { silent = true })

map("n", "<leader>la", "<Plug>(coc-codeaction)", { silent = true })
map("v", "<leader>la", "<Plug>(coc-codeaction-selected)", { silent = true })
map("n", "<leader>l=", "<Plug>(coc-format)", { silent = true })
map("v", "<leader>l=", "<Plug>(coc-format-selected)", { silent = true })
map("n", "<leader>lr", "<Plug>(coc-rename)", { silent = true })
map("n", "<leader>lf", "<Plug>(coc-fix-current)", { silent = true })
map("n", "<leader>lk", ':call CocAction("doHover")<CR>', { silent = true })
map("n", "<leader>lt", ":Vista!!<CR>", { silent = true })

-----------------------------------------------------------------------
-- Visual alignment
-----------------------------------------------------------------------
map("x", "ga", "<Plug>(LiveEasyAlign)")

-----------------------------------------------------------------------
-- NERDTree
-----------------------------------------------------------------------
map("n", "<M-\\>", ":NERDTreeToggle<CR>", { silent = true })

-----------------------------------------------------------------------
-- Utility commands for copying/pasting (macOS)
-----------------------------------------------------------------------
if vim.fn.has("macunix") == 1 then
  map("v", "<C-x>", ":!pbcopy<CR>", { silent = true })
  map("v", "<C-c>", ":w !pbcopy<CR><CR>", { silent = true })
end

-----------------------------------------------------------------------
-- Abbreviations
-----------------------------------------------------------------------
cmd.cnoreabbrev("git", "Git")
cmd.cnoreabbrev("gitblame", "Git blame")
cmd.cnoreabbrev("Gitblame", "Git blame")

-----------------------------------------------------------------------
-- COPY/PRINT toggles (GitGutter, ALE)
-----------------------------------------------------------------------
map("n", ";cp", ":set nonumber<CR>:GitGutterDisable<CR>:ALEDisable<CR>", { desc = "Copy mode (hide UI)" })
map("n", ";pc", ":set number<CR>:ALEEnable<CR>:GitGutterEnable<CR>", { desc = "Print mode (show UI)" })

-- Which-key trigger mappings
map("n", "<silent> <Leader>", ":<c-u>WhichKey '<Space>'<CR>")
map("v", "<silent> <Leader>", ":<c-u>WhichKeyVisual '<Space>'<CR>")
map("n", "<silent> <LocalLeader>", ":<c-u>WhichKey ','<CR>")
map("v", "<silent> <LocalLeader>", ":<c-u>WhichKeyVisual ','<CR>")

-- Which-key configuration
vim.g.leader_key_map = {
  [' '] = {
    name = '+general',
    s = { 'Startify', 'Home Buffer' },
    f = { ':FZFCommands', 'Search commands' },
    a = { ':FZFColors', 'Search colorschemes' },
  },
  o = { ':GBrowse', 'Grab Github URL for current line' },
  t = {
    name = '+testing',
    t = { ':TestNearest', 'Run Nearest' },
    ['.'] = { ':TestLast', 'Run Last' },
    f = { ':TestFile', 'Run File' },
    s = { ':TestSuite', 'Run Suite' },
    g = { ':TestVisit', 'Goto last ran test' },
  },
  f = {
    name = '+files',
    f = { ':FZFFiles', 'File Search' },
    o = { ':FZFBuffers', 'Open Buffer Search' },
    m = { ':FZFHistory', 'Recent Files Search' },
    ['.'] = { '<c-^>', 'Goto Last Buffer' },
    ['-'] = 'File Browser',
  },
  h = {
    name = '+hunks',
    t = { ':GitGutterToggle', 'Toggle Git Gutter' },
    p = { '<Plug>(GitGutterPreviewHunk)', 'Preview Hunk' },
    s = { '<Plug>(GitGutterStageHunk)', 'Stage Hunk' },
    u = { '<Plug>(GitGutterUndoHunk)', 'Undo Hunk' },
  },
  g = { name = '+git' },
  s = {
    name = '+search',
    g = { 'Grepper', 'Find in directory (quickfix)' },
    f = { ':FZFRg ', 'Find in directory (live)' },
    t = { ':FZFTags', 'Find tags' },
    l = { ':FZFLines', 'Find lines in open files' },
    b = { ':FZFBlines', 'Find lines in current buffer' },
    p = { '<Plug>CtrlSFPrompt', 'Find in directory (ctrlsf)' },
  },
  c = {
    name = '+cscope',
    s = { ':cs find s <cword>', 'Cscope Symbol' },
    g = { ':cs find g <cword>', 'Cscope Definition' },
    c = { ':cs find c <cword>', 'Cscope Callers' },
    d = { ':cs find d <cword>', 'Cscope Callees' },
    a = { ':cs find a <cword>', 'Cscope Assignments' },
    o = { ':cs add cscope.out', 'Cscope Open Database' },
    z = { ':!sh -xc \'\'starscope -e cscope -e ctags\'\'', 'Cscope Build Database' },
  },
  l = {
    name = '+language-server',
    k = { ':call CocAction(\"doHover\")', 'Hover' },
    s = { ':FZFTags', 'Symbols' },
    t = { ':Vista!!', 'Tag Bar' },
    a = 'Code Action',
    ['='] = 'Code Format',
    r = 'Rename',
    f = 'Autofix Current',
  },
}

-- Register which-key
vim.cmd("call which_key#register('<Space>', 'g:leader_key_map')")

