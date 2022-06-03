local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

return require('packer').startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim'

  -- Easy language server installer etc.
  use { 'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer' } -- Collection of configurations for the built-in LSP client
  -- Telescope fuzzy finder
  use 'kosayoda/nvim-lightbulb'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  -- Telescope extensions
  use 'nvim-telescope/telescope-fzy-native.nvim'
  -- To make default lsp ui better.
  use 'stevearc/dressing.nvim'
  -- Project management inside neovim with a telescope extension.
  -- END Telescope extensions

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines

  -- cmp
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp Gods plugins

  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'

  use 'ellisonleao/gruvbox.nvim'
  -- for commenting
  use 'numToStr/Comment.nvim'
  use 'windwp/nvim-ts-autotag'
  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Multi cursor thingy.
  use { 'mg979/vim-visual-multi', branch = 'master' }

  -- Search from vim because I'm lazy.
  -- Colorscheme
  -- use 'ajmwagar/vim-deus'

  -- use 'marko-cerovac/material.nvim'
  use 'ThePrimeagen/harpoon'

  use 'github/copilot.vim'

  -- Nerd tree written in lua
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
  }

  use 'ryanoasis/vim-devicons'

  use { -- Nvim Treesitter configurations and abstraction layer
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'nvim-treesitter/playground'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }
  -- Auto pairs as the same suggest.
  -- use 'windwp/nvim-autopairs'


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
