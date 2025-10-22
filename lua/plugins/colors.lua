-- lua/plugins/colors.lua
return {
  {
    "joshdick/onedark.vim",
    priority = 1000, -- Load before other start plugins
    config = function()
      -- Match your old Vimscript settings
      vim.o.background = "dark"
      vim.g.onedark_color_overrides = {
        background = { gui = "#000000", cterm = "0", cterm16 = "NONE" },
      }

      -- Finally apply the colorscheme
      vim.cmd("colorscheme onedark")
    end,
  },
}

