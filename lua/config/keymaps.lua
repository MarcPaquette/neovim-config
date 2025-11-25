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
-- Git commands
-----------------------------------------------------------------------
map("n", "<leader>gs", ":Git<CR>", { silent = true })
map("n", "<leader>gc", ":Commits<CR>", { silent = true })
map("n", "<leader>gk", ":BCommits<CR>", { silent = true })
map("n", "<leader>gb", ":Git blame<CR>", { silent = true })

-----------------------------------------------------------------------
-- Vista tagbar (non-LSP)
-----------------------------------------------------------------------
map("n", "<leader>lt", ":Vista!!<CR>", { silent = true, desc = "Toggle tagbar" })

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