-- lua/plugins/colors.lua
-- Colorscheme configuration

return {
  {
    "joshdick/onedark.vim",
    priority = 1000,  -- Load before other plugins
    config = function()
      vim.o.background = "dark"

      -- Custom background (pure black)
      vim.g.onedark_color_overrides = {
        background = { gui = "#000000", cterm = "0", cterm16 = "NONE" },
      }

      vim.cmd("colorscheme onedark")
    end,
  },
}

