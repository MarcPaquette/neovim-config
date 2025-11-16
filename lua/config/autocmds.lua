-- lua/config/autocmds.lua
local group = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remember cursor position
autocmd("BufReadPost", {
group = group("remember_cursor", {}),
callback = function()
local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
vim.api.nvim_win_set_cursor(0, { row, col })
end
end,
})

-- Cursor line management
autocmd({"InsertLeave", "WinEnter"}, {
group = group("cursorline", {}),
callback = function() vim.opt.cursorline = true end
})
autocmd({"InsertEnter", "WinLeave"}, {
group = group("cursorline", {}),
callback = function() vim.opt.cursorline = false end
})

-- Syntax sync from start
autocmd("BufEnter", {
  group = group("sync_fromstart", {}),
  command = "syntax sync maxlines=200"
})

-- Wrapping for txt files
autocmd({"BufRead", "BufNewFile"}, {
  group = group("wrapping", {}),
  pattern = "*.txt",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.wm = 2
    vim.opt_local.textwidth = 79
  end
})

-- Make/cmake settings
autocmd("FileType", {
  group = group("make_cmake", {}),
  pattern = "make",
  callback = function() vim.opt_local.noexpandtab = true end
})
autocmd({"BufNewFile", "BufRead"}, {
  group = group("make_cmake", {}),
  pattern = "CMakeLists.txt",
  callback = function() vim.opt_local.filetype = "cmake" end
})

-- Go settings
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

-- Completion preview close
autocmd("CompleteDone", {
  group = group("completion_preview_close", {}),
  callback = function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd("pclose")
    end
  end
})

-- Ruby settings
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
    vim.opt_local.regexpengine = 1
    vim.opt_local.foldmethod = "syntax"
  end
})

-- Basic config settings
autocmd("BufNewFile", {
group = group("basic_config", {}),
callback = function() vim.opt.formatoptions:remove("o") end
})
autocmd("BufEnter", {
group = group("basic_config", {}),
callback = function() vim.opt.formatoptions:remove("o") end
})

-- Reload file on focus
autocmd("FocusGained", {
group = group("basic_config", {}),
command = "checktime"
})

-- Autosave functionality (if enabled)
if vim.g.autosave then
autocmd("CursorHold", {
group = group("basic_config", {}),
callback = function()
if vim.bo.modified then
vim.cmd("write")
end
end
})
end

-- FZF statusline management
autocmd("FileType", {
group = group("fzf_config", {}),
pattern = "fzf",
callback = function()
  vim.opt.laststatus = 0
  vim.opt.ruler = false
end
})
autocmd("BufLeave", {
group = group("fzf_config", {}),
pattern = "*<buffer>",
callback = function()
  vim.opt.laststatus = 2
  vim.opt.ruler = true
end
})

