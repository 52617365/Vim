local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim'

use {'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'} -- Collection of configurations for the built-in LSP client
use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
}
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-cmdline'
use 'hrsh7th/cmp-nvim-lua'
use 'jiangmiao/auto-pairs'
use 'tpope/vim-surround'
use 'saadparwaiz1/cmp_luasnip'
use 'vim-airline/vim-airline'
use 'tpope/vim-fugitive'
use 'morhetz/gruvbox'
use 'rafamadriz/friendly-snippets'
use 'hrsh7th/nvim-cmp'
use 'L3MON4D3/LuaSnip'
use 'nvim-telescope/telescope-fzy-native.nvim'
use 'ThePrimeagen/harpoon'
use 'sbdchd/neoformat'
use 'folke/todo-comments.nvim'
use 'mfussenegger/nvim-dap'
use 'rcarriga/nvim-dap-ui'
use 'onsails/lspkind.nvim'
use 'tpope/vim-commentary'
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
