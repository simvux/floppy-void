-- https://github.com/nanotee/nvim-lua-guide/

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/nvim-cmp' }, -- Autocompletion plugin
    { 'hrsh7th/cmp-nvim-lsp' }, -- LSP source for nvim-cmp
    { 'L3MON4D3/LuaSnip' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'is0n/fm-nvim' }, -- Ranger as file browser
    { 'lambdalisue/suda.vim' },
    { 'elkowar/yuck.vim' },
    { 'rktjmp/lush.nvim',
      { dir = '/home/simon/.config/nvim/lua/purple_theme' }
    },
    { 'whatyouhide/vim-gotham' },
    {
        'nvim-lualine/lualine.nvim', -- Statusbar
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    -- add your plugins here
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Common options
vim.cmd 'colorscheme purple_theme'
vim.api.nvim_set_option('scrolloff', 10)
vim.api.nvim_set_option('cmdheight', 0)
vim.api.nvim_set_option('spelllang', 'en')
vim.api.nvim_set_option('autochdir', true)
vim.wo.wrap = false
-- Double tap esc to de-highlight
vim.api.nvim_set_keymap('n', '<esc><esc>', ':silent! nohls | ccl<cr>', { noremap = true })
-- Save on spacebar
vim.api.nvim_set_keymap('n', '<Space>', ':w<CR>', {})
vim.api.nvim_create_autocmd('VimResized', {
    callback = function() vim.cmd("wincmd =") end,
})
vim.api.nvim_create_autocmd({'BufWinEnter'}, {
  desc = 'return cursor to where it was last time closing the file',
  pattern = '*',
  command = 'silent! normal! g`"zv',
})
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
vim.noshowmode = true
-- Switch panes with ctrl
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { noremap = true })
vim.api.nvim_set_keymap('n', 'm', ':Ranger<CR>', { noremap = true })
-- Solve auto-pair conflicts with Alt-Gr keyboards by unbinding everything
vim.cmd('let g:AutoPairsShorcutToggle = ""')
vim.cmd('let g:AutoPairsFastWrap = ""')
vim.cmd('let g:AutoPairsShortcutJump = ""')
vim.cmd('let g:AutoPairsAutoParisShortcutBackInsert = ""')

-- Prevent misinputs from EN -> Nordic keyboard mapping with Super being <>| (hack)
vim.api.nvim_set_keymap('i', 'D-\'', '\'', {})
vim.api.nvim_set_keymap('i', 'D-Bar', '', {})
vim.api.nvim_set_keymap('i', 'D-.', '', {})
vim.api.nvim_set_keymap('i', 'D-k', '', {})
vim.api.nvim_set_keymap('i', 'S-D-Space', '', {})

require("plugins")
