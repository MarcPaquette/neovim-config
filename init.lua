-- init.lua
-- Set leader key *before* anything else
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load basic options and autocmds first
require("config.options")
require("config.autocmds")

-- Load plugins next
require("lazy").setup("plugins", {
  install = { colorscheme = { "onedark" } },
  checker = { enabled = true },
})

-- Finally, load your keymaps *after* plugins exist
require("config.keymaps")
