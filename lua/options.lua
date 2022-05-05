local opt = vim.opt
local fn = vim.fn
local cmd = vim.cmd
local g = vim.g
local api = vim.api
local o = vim.o
local opts = { noremap=true, silent=true }

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

augroup nerdtree
  autocmd VimEnter * NERDTree | wincmd p
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup end
]])

--colorscheme gruvbox

-- The settings I'm using but I directly forked the plugin and changed em to my likings.
--g.browser_search_engines = {
--   duckduckgo='https://duckduckgo.com/?q=%s',
--   brave='https://search.brave.com/search?q=%s',
--   phpdocs='https://www.php.net/search.php?show=quickref&pattern=%s',
--   rustdocs='https://doc.rust-lang.org/std/?search=%s',
--   mozilladocs='https://developer.mozilla.org/en-US/search?q=%s',
--   github='https://github.com/search?q=%s',
--   google='https://google.com/search?q=%s',
--   stackoverflow='https://stackoverflow.com/search?q=%s',
--   translate='https://translate.google.com/?sl=auto&tl=it&text=%s',
--   wikipedia='https://en.wikipedia.org/wiki/%s',
--   youtube='https=//www.youtube.com/results?search_query=%s&page=&utm_source=opensearch',
--}

g.deus_termcolors=256
api.nvim_command('colorscheme deus')
--api.nvim_command('set path=$PWD/**')
api.nvim_command('highlight CopilotSuggestion guifg=#555555 ctermfg=8')
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
opt.synmaxcol = 300
opt.expandtab = true
opt.completeopt = 'menuone,noselect'
g['bracey_server_allow_remote_connections'] = 1
g['bracey_auto_start_browser'] = 1
g['bracey_server_path'] = 'http://localhost'
