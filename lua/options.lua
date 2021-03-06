local opt = vim.opt
local cmd = vim.cmd
local g = vim.g

--------------
-- Options --
--------------

g.mapleader = ';'


cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
set nohlsearch
]])

vim.cmd([[set winbar=%m\ %f]])
opt.path = "$PWD/**"
opt.undodir = os.getenv('HOME') .. "/temp/"
opt.sol = true
opt.clipboard = 'unnamedplus'
opt.backup = false
opt.swapfile = false
opt.tabstop = 4
opt.iskeyword:append("-")
opt.shortmess:append("c")
opt.hidden = true
opt.number = true
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.relativenumber = true
opt.ignorecase = true
opt.pumheight = 10 -- pop up menu height
opt.smartcase = true -- smart case
opt.shiftwidth = 2
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.updatetime = 300
opt.autowriteall = true
opt.smartindent = true
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.wrap = false -- display lines as one long line
opt.cursorline = true -- highlight the current line
opt.background = "light" -- or "light" for light mode
cmd([[colorscheme gruvbox]])
cmd([[hi CursorLine cterm=underline gui=underline]])
opt.guifont = "monospace 17"
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.undofile = true
opt.timeoutlen = 800 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.lazyredraw = true
opt.synmaxcol = 300
opt.expandtab = true
opt.completeopt = 'menuone,noselect'
