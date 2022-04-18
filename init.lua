require('plugins')

local opt = vim.opt
local fn = vim.fn
local cmd = vim.cmd
local g = vim.g
local api = vim.api
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


cmd([[
colorscheme gruvbox
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
]])


opt.tabstop = 4
opt.shortmess:append("c")
opt.hidden = true
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.shiftwidth = 4
opt.updatetime = 100
opt.autowriteall = true
opt.smartindent = true
opt.autoindent = true
opt.background = 'dark'
opt.termguicolors = true
opt.undofile = true
opt.wildmenu = true
opt.lazyredraw = true
opt.synmaxcol = 240
opt.expandtab = true
opt.completeopt = 'menu,menuone,noselect'

-------------
-- Mappings --
--------------

-- Saving stuff to save time
api.nvim_set_keymap('n', '<C-s>', ':w<CR>', opts)
api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>l', opts)
api.nvim_set_keymap('v', '<C-s>', '<Esc>:w<CR>',  opts)

-- Remaps for vim-fugitive
api.nvim_set_keymap('n', '<Leader>gs', ':G<CR>', opts)
api.nvim_set_keymap('n', '<Leader>gc', ':Git commit<CR>', opts)
api.nvim_set_keymap('n', '<Leader>gp', ':Git push<CR>', opts)
api.nvim_set_keymap('n', '<Leader>gj', ':diffget //3<CR>', opts)
api.nvim_set_keymap('n', '<Leader>gf', ':diffget //2<CR>', opts)

-- reload configuration file with :wc
api.nvim_set_keymap('n', '<Leader>wc', 'source $HOME/.config/nvim/init.lua<CR>', opts)
api.nvim_set_keymap('n', '<Leader>oc', 'source $HOME/.config/nvim/init.lua<CR>', opts)

-- Show harpoon files with leader leader
api.nvim_set_keymap('n', '<Leader><Leader>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>a', ':lua require("harpoon.mark").add_file()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>', opts)
api.nvim_set_keymap('n', '<Leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>', opts)
api.nvim_set_keymap('n', '<Leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>', opts)
api.nvim_set_keymap('n', '<Leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>', opts)

-- Comment code
api.nvim_set_keymap('n', '<Leader>cc', ':Commentary<CR>', opts)
api.nvim_set_keymap('n', '<Leader>cs', '{v}:Commentary<CR>', opts)

-- Debugger key bindings (nvim-dap)
-- TODO: ALL BINDINGS
api.nvim_set_keymap('n', '<Alt>b', ':lua require("dap").toggle_breakpoint()<CR>', opts)
api.nvim_set_keymap('n', '<Alt>so', ':lua require("dap").step_over()', opts)
api.nvim_set_keymap('n', '<Alt>si', ':lua require("dap").step_into()', opts)
api.nvim_set_keymap('n', '<Alt>c', ':lua require("dap").continue()', opts)
api.nvim_set_keymap('n', '<Alt>o', ':lua require("dap").repl.open()', opts)


-- Telescope.nvim
require('telescope').setup {
defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
},
    extensions = {
        fzy_native = {
                        override_generic_sorter = false,
                                    override_file_sorter = true,
        },
    }
}
require('telescope').load_extension('fzy_native')

api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<cr>', opts)
api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<cr>', opts)
api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers<cr>', opts)
api.nvim_set_keymap('n', '<Leader>fh', ':Telescope help_tags<cr>', opts)

-- Adding hopping around the file into arrow keys with ctrl combination
api.nvim_set_keymap('n', '<C-j>', '<C-d>', opts)
api.nvim_set_keymap('n', '<C-k>', '<C-u>', opts)
api.nvim_set_keymap('n', '<C-h>', '3b', opts)
api.nvim_set_keymap('n', '<C-l>', '3w', opts)

-- lspconfig keybindings
api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
api.nvim_set_keymap('n', 'se', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Setup nvim-cmp.
local has_words_before = function()
local line, col = unpack(api.nvim_win_get_cursor(0))
return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
     require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
  end,
},
mapping = {
["<C-d>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end, { "i", "s" }),

["<C-s>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end, { "i", "s" }),
  ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-n>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
  ['<C-e>'] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items

},
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'luasnip' }, -- For luasnip users.
}, {
  { name = 'buffer' },
})
})


-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

-- LSP --
local lsp_installer = require("nvim-lsp-installer")

local on_attach = function(client, bufnr)
api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
local lsp_opts = {
on_attach = on_attach,
capabilities = capabilities,
}
server:setup(lsp_opts)
end)
