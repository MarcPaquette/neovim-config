-- lua/plugins/init.lua

return {
-- Core utility
{ 'liuchengxu/vim-which-key', lazy = false },
  { "tpope/vim-commentary" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" }, -- GitHub integration for fugitive
  { "airblade/vim-gitgutter" },
  { "tpope/vim-sleuth" },
  { "tpope/vim-vinegar" },
  { "junegunn/vim-easy-align" },
  { "itchyny/lightline.vim", config = function()
      vim.g.lightline = {
        active = {
          left = {{'mode', 'paste'}, {'fugitive', 'filename'}},
          right = {
            {'lineinfo'},
            {'percent'},
            {'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'},
            {'config_deps', 'config_outdated'},
          }
        },
        component = {
          lineinfo = '%3l:%-2v',
        },
        component_function = {
          fugitive = 'LightlineFugitive',
          filename = 'LightlineFilename',
        },
        component_expand = {
          linter_checking = 'lightline#ale#checking',
          linter_warnings = 'lightline#ale#warnings',
          linter_errors = 'lightline#ale#errors',
          linter_ok = 'lightline#ale#ok',
          config_outdated = 'update#status',
          config_deps = 'update#deps',
        },
        component_type = {
          linter_checking = 'left',
          linter_warnings = 'warning',
          linter_errors = 'error',
          linter_ok = 'left',
          config_outdated = 'warning',
          config_deps = 'error',
        },
        separator = { left = " ", right = " " },
        subseparator = { left = " ", right = " " }
      }

      vim.cmd([[
        function! LightlineModified()
          return &filetype =~# 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
        endfunction
        function! LightlineFilename()
          let l:fname = expand('%')
          return  l:fname ==# '__Tagbar__' ? g:lightline.fname :
                \ l:fname =~# '__Gundo\|NERD_tree' ? '' :
                \ ('' !=# LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                \ ('' !=# l:fname ? l:fname : '[No Name]') .
                \ ('' !=# LightlineModified() ? ' ' . LightlineModified() : '')
        endfunction
        function! LightlineReadonly()
          return &readonly ? 'readonly' : ''
        endfunction
        function! LightlineFugitive()
          if exists('*FugitiveHead')
            let l:branch = FugitiveHead()
            return l:branch !=# '' ? ' '.l:branch : ''
          endif
          return ''
        endfunction
      ]])

      vim.g['lightline#ale#indicator_checking'] = "…"
      vim.g['lightline#ale#indicator_warnings'] = "➤"
      vim.g['lightline#ale#indicator_errors'] = "✘"
      vim.g['lightline#ale#indicator_ok'] = "OK"
      vim.g.lightline.colorscheme = 'onedark'
    end },
  { "maximbaz/lightline-ale" },
  { "dense-analysis/ale", config = function()
      vim.g.ale_sign_error = '✘'
      vim.g.ale_sign_warning = '➤'
      vim.g.ale_sign_info = '➟'
      vim.g.ale_cursor_detail = 1
      vim.g.ale_floating_preview = 1
      vim.g.ale_hover_to_floating_preview = 1
      vim.g.ale_detail_to_floating_preview = 1
      vim.g.ale_floating_window_border = {'│', '─', '╭', '╮', '╯', '╰'}
      vim.g.ale_hover_cursor = 0
      vim.g.ale_echo_cursor = 0
      vim.g.ale_fix_on_save = 1
      vim.g.ale_disable_lsp = 1
      vim.g.ale_set_loclist = 0
      vim.g.ale_linters = {
        go = {'golangci-lint'},
        typescript = {'typecheck'},
        javascript = {'eslint'},
        proto = {},
      }
      vim.g.ale_go_golangci_lint_package = 1
      vim.g.ale_go_golangci_lint_options = '--fast'
      vim.g.ale_completion_enabled = 0

      -- ALE highlight links
      vim.cmd([[
        highlight link ALEVirtualTextError ErrorMsg
        highlight link ALEVirtualTextStyleError ALEVirtualTextError
        highlight link ALEVirtualTextWarning WarningMsg
        highlight link ALEVirtualTextInfo ALEVirtualTextWarning
        highlight link ALEVirtualTextStyleWarning ALEVirtualTextWarning
      ]])
    end },
   -- LSP and completion
   { 'neovim/nvim-lspconfig' },
   { 'williamboman/mason.nvim', config = function()
   require('mason').setup()
   end },
   { 'williamboman/mason-lspconfig.nvim', config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('mason-lspconfig').setup({
        ensure_installed = { 'gopls', 'ts_ls', 'pyright', 'rust_analyzer', 'bashls', 'cssls', 'html', 'jsonls', 'yamlls' }
      })
      local servers = { 'gopls', 'ts_ls', 'pyright', 'rust_analyzer', 'bashls', 'cssls', 'html', 'jsonls', 'yamlls' }
      for _, server in ipairs(servers) do
      vim.lsp.config(server, {
      capabilities = capabilities,
      })
              vim.lsp.enable(server)
      end

      -- LSP keymaps (removed to avoid conflicts with coc mappings in keymaps.lua)
      vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
      -- No keymaps set here; all handled in lua/config/keymaps.lua
      end
      })
    end },
    { 'nvim-treesitter/nvim-treesitter', config = function()
       require('nvim-treesitter.configs').setup({
         ensure_installed = { 'go', 'typescript', 'javascript', 'python', 'rust', 'bash', 'lua', 'vim', 'json', 'yaml', 'html', 'css', 'kotlin', 'proto' },
         highlight = { enable = true },
         indent = { enable = true },
       })
     end },
   { 'hrsh7th/nvim-cmp', config = function()
      local cmp = require'cmp'
   cmp.setup({
   snippet = {
   expand = function(args)
    require('luasnip').lsp_expand(args.body)
   end,
   },
   mapping = cmp.mapping.preset.insert({
   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
   ['<C-f>'] = cmp.mapping.scroll_docs(4),
   ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
    sources = cmp.config.sources({
    { name = 'nvim_lsp' },
   { name = 'luasnip' },
   }, {
   { name = 'buffer' },
   })
   })
   end },
  { 'hrsh7th/cmp-nvim-lsp' },
   { 'L3MON4D3/LuaSnip' },
   { 'saadparwaiz1/cmp_luasnip' },
  { "mhinz/vim-startify", config = function()
  vim.g.startify_change_to_dir = 0
  vim.g.startify_change_to_vcs_root = 0
  vim.g.startify_skiplist = {
  '/home/armhead/workspace/devenv/dotfiles/nvim/autoload/autoload',
  }
  vim.g.startify_lists = {
  { type = 'dir', header = { 'MRU ' .. vim.fn.getcwd() } },
  { type = 'files', header = { 'MRU' } },
    { type = 'sessions', header = { 'Sessions' } },
  { type = 'bookmarks', header = { 'Bookmarks' } },
  { type = 'commands', header = { 'Commands' } },
  }
  vim.g.startify_bookmarks = {
      { c = '~/.config/nvim/init.lua' },
    '~/.zshrc'
  }
  end },
  {
    'AckslD/nvim-whichkey-setup.lua',
  dependencies = {'liuchengxu/vim-which-key'},
  config = function()
    vim.o.timeout = true
  vim.o.timeoutlen = 300
  vim.g.which_key_timeout = 300

      local wk = require('whichkey_setup')
  wk.config{
    hide_statusline = false,
  default_keymap_settings = {
    silent = true,
  noremap = true,
  },
  default_mode = 'n',
  }

      -- Example keymap, replace with your own
      local keymap = {}
      wk.register_keymap('leader', keymap)
  end,
  },
  { "scrooloose/nerdtree", cmd = "NERDTreeToggle" },
  { "tpope/vim-dispatch", cmd = {"Dispatch", "Make", "Focus", "Start"} },
  { "janko-m/vim-test", cmd = {"TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit"} },
  { 'junegunn/fzf', build = './install --bin' },
  { "junegunn/fzf.vim", init = function()
      vim.g.fzf_command_prefix = 'FZF'
    end, config = function()
      vim.g.fzf_path = vim.fn.expand('~/.fzf/bin/fzf')
      vim.opt.wildignore:append("*.o,*.obj,.git,*.rbc,*.pyc,__pycache__")

      -- Set FZF_DEFAULT_COMMAND: prefer fd, then rg, else find
          if vim.fn.executable('fd') == 1 then
          vim.env.FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude .git'
          elseif vim.fn.executable('rg') == 1 then
          vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob !.git/'
          else
            vim.env.FZF_DEFAULT_COMMAND = 'find . -name .git -prune -o -type f -print'
        end

      if vim.fn.executable('ag') == 1 then
        vim.opt.grepprg = 'ag --nogroup --nocolor'
      end

  vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
  vim.g.fzf_colors = {
  fg = {'fg', 'Normal'},
  bg = {'bg', 'Normal'},
  hl = {'fg', 'Comment'},
  ['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
  ['bg+'] = {'bg', 'CursorLine', 'CursorColumn'},
  ['hl+'] = {'fg', 'Statement'},
  info = {'fg', 'PreProc'},
  border = {'fg', 'Ignore'},
  prompt = {'fg', 'Conditional'},
  pointer = {'fg', 'Exception'},
  marker = {'fg', 'Keyword'},
  spinner = {'fg', 'Label'},
    header = {'fg', 'Comment'}
  }
    vim.g.fzf_history_dir = '~/.local/share/fzf-history'
    end },
  { "xolox/vim-misc" },
  { "xolox/vim-session", dependencies = {"xolox/vim-misc"}, config = function()
  vim.g.session_autoload = 'no'
  end },

  -- Language-specific
  { "fatih/vim-go", ft = "go", build = ":GoInstallBinaries", config = function()
  vim.g.go_list_type = "quickfix"
  vim.g.go_fmt_command = "goimports"
  vim.g.go_fmt_fail_silently = 1
  vim.g.go_highlight_types = 1
  vim.g.go_highlight_fields = 1
  vim.g.go_highlight_functions = 1
  vim.g.go_highlight_methods = 1
  vim.g.go_highlight_operators = 1
  vim.g.go_highlight_build_constraints = 1
  vim.g.go_highlight_structs = 1
  vim.g.go_highlight_generate_tags = 1
  vim.g.go_highlight_space_tab_error = 0
  vim.g.go_highlight_array_whitespace_error = 0
  vim.g.go_highlight_trailing_whitespace_error = 1
  vim.g.go_highlight_extra_types = 1
  end
  },
  { "udalov/kotlin-vim", ft = "kotlin" },

  -- Optional enhancements
  { "nvim-lua/plenary.nvim" },

    -- Amp Plugin
{
  "sourcegraph/amp.nvim",
  branch = "main", 
  lazy = false,
  opts = { auto_start = true, log_level = "info" },
}
}
