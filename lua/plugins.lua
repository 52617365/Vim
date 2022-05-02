local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim'

-- Easy language server installer etc.
use {'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'} -- Collection of configurations for the built-in LSP client

-- Telescope fuzzy finder
use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
}
use 'nvim-telescope/telescope-fzy-native.nvim'

-- cmp
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-cmdline'
use 'hrsh7th/cmp-nvim-lua'
use 'L3MON4D3/LuaSnip'
use 'rafamadriz/friendly-snippets'
use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter

-- Gods plugins
use 'tpope/vim-fugitive'
use 'tpope/vim-commentary'
use 'tpope/vim-surround'

-- Some twerking shit for todo comments.
use 'folke/todo-comments.nvim'

-- Multi cursor thingy.
use {'mg979/vim-visual-multi', branch='master'}

-- Search from vim because I'm lazy.
use '52617365/vim-browser-search'

-- Debugging thing that probably will never be used.
use 'mfussenegger/nvim-dap'
use 'rcarriga/nvim-dap-ui'
use 'ajmwagar/vim-deus'
use 'vim-airline/vim-airline'
use 'morhetz/gruvbox'
use 'ThePrimeagen/harpoon'
use 'github/copilot.vim'
use 'onsails/lspkind.nvim'
use 'turbio/bracey.vim'
use 'preservim/nerdtree'
use 'ryanoasis/vim-devicons'
use { -- Nvim Treesitter configurations and abstraction layer
 'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
}
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
