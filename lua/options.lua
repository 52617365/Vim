local opt = vim.opt
local fn = vim.fn
local cmd = vim.cmd
local g = vim.g local api = vim.api local opts = { noremap=true, silent=true }

--------------
-- Options --
--------------
g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}
g.mapleader = ';'

cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

cmd([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
]])

cmd([[
augroup fmt
autocmd!
autocmd BufWritePre * undojoin | Neoformat
augroup END
]])

-- Close the tab if NERDTree is the only window remaining in it.
-- Open nerd tree when nvim is opened.
cmd([[
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
]])

cmd([[
colorscheme gruvbox
set noswapfile
set nobackup
set nowritebackup
set directory=$HOME/temp//
set backupdir=$HOME/temp//
set undodir=$HOME/temp//
au BufWritePre * :%s/\s\+$//e
au BufEnter * set fo-=c fo-=r fo-=o
set path=$PWD/**
set nosol
filetype plugin indent on
syntax enable
]])

vim.cmd([[
set clipboard^=unnamed,unnamedplus
set iskeyword+=-
]])

opt.tabstop = 4
opt.shortmess:append "c"
opt.hidden = true
opt.number = true
opt.splitbelow = true                       -- force all horizontal splits to go below current window
opt.splitright = true                       -- force all vertical splits to go to the right of current window
opt.relativenumber = true
opt.ignorecase = true
opt.pumheight = 10  -- pop up menu height
opt.showtabline = 2                         -- always show tabs
opt.smartcase = true                        -- smart case
opt.shiftwidth = 2
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.updatetime = 300
opt.autowriteall = true
opt.smartindent = true
opt.splitbelow = true                       -- force all horizontal splits to go below current window
opt.splitright = true                       -- force all vertical splits to go to the right of current window
opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
opt.autoindent = true
opt.wrap = false   -- display lines as one long line
opt.cursorline = true                       -- highlight the current line
opt.guifont = "monospace 17"
opt.background = 'dark'
opt.termguicolors = true
opt.scrolloff = 8  -- is one of my fav
opt.sidescrolloff = 8
opt.undofile = true
opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.wildmenu = true
opt.lazyredraw = true
opt.synmaxcol = 240
opt.expandtab = true
opt.completeopt = 'menuone,noselect'
g['bracey_server_allow_remote_connections'] = 1
g['bracey_auto_start_browser'] = 1
g['bracey_server_path'] = 'http://localhost'
