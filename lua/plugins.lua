local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

return require('packer').startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  -- Easy language server installer etc.
  use { 'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer' }
  -- Collection of configurations for the built-in LSP client

  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'simrat39/rust-tools.nvim'
  -- Telescope extensions
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- Hopping inside telescope. (pog)
  use 'nvim-telescope/telescope-hop.nvim'

  -- select snippets inside telescope.
  use "benfowler/telescope-luasnip.nvim"
  -- refactoring.nvim
  use 'ThePrimeagen/refactoring.nvim'

  -- To make default lsp ui better.
  use 'stevearc/dressing.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines

  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  -- cmp
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp

  -- Gods plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'

  use 'ellisonleao/gruvbox.nvim'
  -- for commenting
  use 'numToStr/Comment.nvim'
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

  use 'ThePrimeagen/harpoon'

  use 'github/copilot.vim'

  -- Icons in nerd tree and elsewhere.
  use 'ryanoasis/vim-devicons'

  use { -- Nvim Treesitter configurations and abstraction layer
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  -- debugging and customizing treesitter
  use 'nvim-treesitter/playground'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Manage errors and shit easier with nicer ui.
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
