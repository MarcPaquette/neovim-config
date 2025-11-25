-- lua/config/autocmds.lua
-- Autocommands for various file types and events

local group = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------------------------------------
-- Cursor position and line
-----------------------------------------------------------------------

-- Remember cursor position when reopening files
autocmd("BufReadPost", {
  group = group("remember_cursor", {}),
  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

-- Show cursorline only in active window and normal mode
autocmd({ "InsertLeave", "WinEnter" }, {
  group = group("cursorline", {}),
  callback = function()
    vim.opt.cursorline = true
  end
})

autocmd({ "InsertEnter", "WinLeave" }, {
  group = group("cursorline", {}),
  callback = function()
    vim.opt.cursorline = false
  end
})

-----------------------------------------------------------------------
-- Syntax and display
-----------------------------------------------------------------------

-- Sync syntax highlighting from start (prevents highlighting bugs)
autocmd("BufEnter", {
  group = group("sync_fromstart", {}),
  command = "syntax sync maxlines=200"
})

-----------------------------------------------------------------------
-- File type settings
-----------------------------------------------------------------------

-- Text files: enable wrapping
autocmd({ "BufRead", "BufNewFile" }, {
  group = group("wrapping", {}),
  pattern = "*.txt",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.wm = 2
    vim.opt_local.textwidth = 79
  end
})

-- Makefiles: use tabs
autocmd("FileType", {
  group = group("make_cmake", {}),
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
  end
})

-- CMakeLists.txt: set filetype
autocmd({ "BufNewFile", "BufRead" }, {
  group = group("make_cmake", {}),
  pattern = "CMakeLists.txt",
  callback = function()
    vim.opt_local.filetype = "cmake"
  end
})

-- Go: use tabs, 4-width
autocmd("FileType", {
  group = group("go", {}),
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end
})

-- Ruby: 2-space indent, syntax folding
autocmd("FileType", {
  group = group("ruby", {}),
  pattern = "ruby",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.softtabstop = 2
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.regexpengine = 1    -- Old regex engine (faster for Ruby)
    vim.opt_local.foldmethod = "syntax"
  end
})

-----------------------------------------------------------------------
-- Completion
-----------------------------------------------------------------------

-- Close preview window after completion
autocmd("CompleteDone", {
  group = group("completion_preview_close", {}),
  callback = function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd("pclose")
    end
  end
})

-----------------------------------------------------------------------
-- Editor behavior
-----------------------------------------------------------------------

-- Don't auto-insert comment leader on 'o' or 'O'
autocmd({ "BufNewFile", "BufEnter" }, {
  group = group("format_options", {}),
  callback = function()
    vim.opt.formatoptions:remove("o")
  end
})

-- Reload file when gaining focus (if changed externally)
autocmd("FocusGained", {
  group = group("auto_reload", {}),
  command = "checktime"
})

-----------------------------------------------------------------------
-- Autosave (optional, set vim.g.autosave = true to enable)
-----------------------------------------------------------------------

if vim.g.autosave then
  autocmd("CursorHold", {
    group = group("autosave", {}),
    callback = function()
      if vim.bo.modified then
        vim.cmd("write")
      end
    end
  })
end

-----------------------------------------------------------------------
-- Quickfix
-----------------------------------------------------------------------

-- Close quickfix window after selecting an item
autocmd("FileType", {
  group = group("quickfix_close", {}),
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", { buffer = true, silent = true })
  end
})

-----------------------------------------------------------------------
-- FZF
-----------------------------------------------------------------------

-- Hide statusline when FZF is open
autocmd("FileType", {
  group = group("fzf_config", {}),
  pattern = "fzf",
  callback = function()
    vim.opt.laststatus = 0
    vim.opt.ruler = false
  end
})

-- Restore statusline when leaving FZF
autocmd("BufLeave", {
  group = group("fzf_config", {}),
  pattern = "*<buffer>",
  callback = function()
    vim.opt.laststatus = 2
    vim.opt.ruler = true
  end
})
