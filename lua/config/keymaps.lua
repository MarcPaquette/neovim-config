-- lua/config/keymaps.lua
-- Key mappings (LSP keymaps are in plugins/init.lua LspAttach autocmd)

local map = vim.keymap.set
local cmd = vim.cmd

-----------------------------------------------------------------------
-- Search behavior
-----------------------------------------------------------------------
map("n", "n", "nzzzv", { desc = "Next search result centered" })
map("n", "N", "Nzzzv", { desc = "Prev search result centered" })

-- Full redraw to fix syntax highlighting bugs
map("n", "<C-l>", ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>", { silent = true, desc = "Full redraw / fix highlight" })

-----------------------------------------------------------------------
-- LuaSnip snippet navigation
-----------------------------------------------------------------------
local luasnip_ok, luasnip = pcall(require, "luasnip")
if luasnip_ok then
  map({"i", "s"}, "<C-j>", function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end, { silent = true, desc = "LuaSnip expand or jump" })

  map({"i", "s"}, "<C-k>", function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end, { silent = true, desc = "LuaSnip jump back" })
end

-----------------------------------------------------------------------
-- ALE (linting)
-----------------------------------------------------------------------
map("n", "<M-p>", "<Plug>(ale_previous_wrap)", { silent = true })
map("n", "<M-n>", "<Plug>(ale_next_wrap)", { silent = true })
map("n", "<leader>paa", ":ALEToggle<CR>", { silent = true, desc = "Toggle ALE" })
map("n", "<leader>paf", ":ALEFix<CR>", { silent = true, desc = "Fix file" })
map("n", "<leader>pal", ":ALELint<CR>", { silent = true, desc = "Lint file" })
map("n", "<leader>pai", ":ALEInfo<CR>", { silent = true, desc = "Show info" })
map("n", "<leader>pad", ":ALEDetail<CR>", { silent = true, desc = "Show detail" })
map("n", "<leader>pan", "<Plug>(ale_next_wrap)", { silent = true, desc = "Next error" })
map("n", "<leader>pap", "<Plug>(ale_previous_wrap)", { silent = true, desc = "Prev error" })

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
map("n", "<leader>f-", ":execute(':FZFFiles ' . expand('%:h'))<CR>", { silent = true, desc = "File Browser" })

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
-- Git commands (Fugitive)
-----------------------------------------------------------------------
map("n", "<leader>gs", ":Git<CR>", { silent = true, desc = "Status" })
map("n", "<leader>gc", ":FZFCommits<CR>", { silent = true, desc = "Commits (FZF)" })
map("n", "<leader>gC", ":FZFBCommits<CR>", { silent = true, desc = "Buffer commits" })
map("n", "<leader>gb", ":Git blame<CR>", { silent = true, desc = "Blame" })
map("n", "<leader>gd", ":Gdiffsplit<CR>", { silent = true, desc = "Diff split" })
map("n", "<leader>gl", ":Git log --oneline<CR>", { silent = true, desc = "Log (oneline)" })
map("n", "<leader>gL", ":Git log<CR>", { silent = true, desc = "Log (full)" })
map("n", "<leader>gp", ":Git push<CR>", { silent = true, desc = "Push" })
map("n", "<leader>gP", ":Git pull<CR>", { silent = true, desc = "Pull" })
map("n", "<leader>gf", ":Git fetch<CR>", { silent = true, desc = "Fetch" })
map("n", "<leader>gw", ":Gwrite<CR>", { silent = true, desc = "Stage file" })
map("n", "<leader>gr", ":Gread<CR>", { silent = true, desc = "Revert file" })

-----------------------------------------------------------------------
-- Vista tagbar (non-LSP)
-----------------------------------------------------------------------
map("n", "<leader>lt", ":Vista!!<CR>", { silent = true, desc = "Toggle tagbar" })

-----------------------------------------------------------------------
-- Visual alignment
-----------------------------------------------------------------------
map("x", "ga", "<Plug>(LiveEasyAlign)")

-----------------------------------------------------------------------
-- NERDTree (file explorer)
-----------------------------------------------------------------------
map("n", "<M-\\>", ":NERDTreeToggle<CR>", { silent = true })
map("n", "<leader>pnn", ":NERDTreeToggle<CR>", { silent = true, desc = "Toggle tree" })
map("n", "<leader>pnf", ":NERDTreeFind<CR>", { silent = true, desc = "Find current file" })
map("n", "<leader>pnr", ":NERDTreeRefreshRoot<CR>", { silent = true, desc = "Refresh root" })
map("n", "<leader>pnc", ":NERDTreeCWD<CR>", { silent = true, desc = "Set CWD as root" })

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

-----------------------------------------------------------------------
-- Additional leader keymaps (which-key auto-discovers via desc)
-----------------------------------------------------------------------
map("n", "<leader>fo", ":FZFBuffers<CR>", { silent = true, desc = "Open buffers" })
map("n", "<leader>fm", ":FZFHistory<CR>", { silent = true, desc = "Recent files" })
map("n", "<leader>f.", "<C-^>", { silent = true, desc = "Last buffer" })
map("n", "<leader>o", ":GBrowse<CR>", { silent = true, desc = "GitHub URL" })
map("n", "<leader>ht", ":GitGutterToggle<CR>", { silent = true, desc = "Toggle GitGutter" })
map("n", "<leader>hp", "<Plug>(GitGutterPreviewHunk)", { desc = "Preview hunk" })
map("n", "<leader>hs", "<Plug>(GitGutterStageHunk)", { desc = "Stage hunk" })
map("n", "<leader>hu", "<Plug>(GitGutterUndoHunk)", { desc = "Undo hunk" })
map("n", "<leader>sf", ":FZFRg<CR>", { silent = true, desc = "Find in directory" })
map("n", "<leader>st", ":FZFTags<CR>", { silent = true, desc = "Find tags" })
map("n", "<leader>sl", ":FZFLines<CR>", { silent = true, desc = "Lines in open files" })
map("n", "<leader>sb", ":FZFBLines<CR>", { silent = true, desc = "Lines in buffer" })
map("n", "<leader>ls", ":FZFTags<CR>", { silent = true, desc = "Symbols" })

-----------------------------------------------------------------------
-- Plugin management (Lazy)
-----------------------------------------------------------------------
map("n", "<leader>pll", ":Lazy<CR>", { silent = true, desc = "Open Lazy UI" })
map("n", "<leader>pls", ":Lazy sync<CR>", { silent = true, desc = "Sync plugins" })
map("n", "<leader>plu", ":Lazy update<CR>", { silent = true, desc = "Update plugins" })
map("n", "<leader>pli", ":Lazy install<CR>", { silent = true, desc = "Install missing" })
map("n", "<leader>plc", ":Lazy clean<CR>", { silent = true, desc = "Clean unused" })
map("n", "<leader>plk", ":Lazy check<CR>", { silent = true, desc = "Check for updates" })
map("n", "<leader>plr", ":Lazy restore<CR>", { silent = true, desc = "Restore to lockfile" })
map("n", "<leader>plp", ":Lazy profile<CR>", { silent = true, desc = "Profile startup" })
map("n", "<leader>plg", ":Lazy log<CR>", { silent = true, desc = "Show changelog" })
map("n", "<leader>plh", ":Lazy health<CR>", { silent = true, desc = "Health check" })

-- Mason (LSP server management)
map("n", "<leader>pmm", ":Mason<CR>", { silent = true, desc = "Open Mason UI" })
map("n", "<leader>pmu", ":MasonUpdate<CR>", { silent = true, desc = "Update registries" })
map("n", "<leader>pml", ":MasonLog<CR>", { silent = true, desc = "Show log" })

-- Treesitter
map("n", "<leader>ptt", ":TSUpdate<CR>", { silent = true, desc = "Update parsers" })
map("n", "<leader>pti", ":TSInstallInfo<CR>", { silent = true, desc = "Install info" })
map("n", "<leader>ptm", ":TSModuleInfo<CR>", { silent = true, desc = "Module info" })

-----------------------------------------------------------------------
-- Sessions (vim-session)
-----------------------------------------------------------------------
map("n", "<leader>pss", ":SaveSession<CR>", { silent = true, desc = "Save session" })
map("n", "<leader>pso", ":OpenSession<CR>", { silent = true, desc = "Open session" })
map("n", "<leader>psd", ":DeleteSession<CR>", { silent = true, desc = "Delete session" })
map("n", "<leader>psc", ":CloseSession<CR>", { silent = true, desc = "Close session" })
map("n", "<leader>psv", ":ViewSession<CR>", { silent = true, desc = "View session" })
