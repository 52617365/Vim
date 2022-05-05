-------------
-- Mappings --
--------------
local api = vim.api
local opts = { noremap=true, silent=true }
local non_silent_opts = { noremap=true, silent=false }

-- Saving stuff to save time
api.nvim_set_keymap('n', '<C-s>', ':w<CR>', opts)
api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>', opts)
api.nvim_set_keymap('v', '<C-s>', '<Esc>:w<CR>',  opts)

-- Remaps for vim-fugitive
api.nvim_set_keymap('n', '<Leader>gs', ':G<CR>', opts)
api.nvim_set_keymap('n', '<Leader>gc', ':Gwrite<CR>', opts)
api.nvim_set_keymap('n', '<Leader>gp', ':Git! push<CR>', opts)
api.nvim_set_keymap('n', '<Leader>gj', ':diffget //3<CR>', opts)
api.nvim_set_keymap('n', '<Leader>gf', ':diffget //2<CR>', opts)

-- reload configuration file with :wc
api.nvim_set_keymap('n', '<Leader>wc', ':source $HOME/.config/nvim/init.lua<CR>', opts)

-- Show harpoon files with leader leader
api.nvim_set_keymap('n', '<Leader><Leader>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>a', ':lua require("harpoon.mark").add_file()<CR>', opts)
api.nvim_set_keymap('n', '<Leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>', opts)
api.nvim_set_keymap('n', '<Leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>', opts)
api.nvim_set_keymap('n', '<Leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>', opts)
api.nvim_set_keymap('n', '<Leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>', opts)

-- Debugger key bindings (nvim-dap)
-- TODO: ALL BINDINGS
api.nvim_set_keymap('n', '<Alt>b', ':lua require("dap").toggle_breakpoint()<CR>', opts)
api.nvim_set_keymap('n', '<Alt>so', ':lua require("dap").step_over()', opts)
api.nvim_set_keymap('n', '<Alt>si', ':lua require("dap").step_into()', opts)
api.nvim_set_keymap('n', '<Alt>c', ':lua require("dap").continue()', opts)
api.nvim_set_keymap('n', '<Alt>o', ':lua require("dap").repl.open()', opts)

api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<cr>', opts)
api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<cr>', opts)
api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers<cr>', opts)
api.nvim_set_keymap('n', '<Leader>fh', ':Telescope help_tags<cr>', opts)

-- lspconfig keybindings
api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
api.nvim_set_keymap('n', 'se', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Google searches
--api.nvim_set_keymap('n', '<Leader>s', '<Plug>SearchNormal', opts)
api.nvim_set_keymap('n', '<Leader>s', ':BrowserSearch ', non_silent_opts)
--api.nvim_set_keymap('v', '<Leader>s', '<Plug>SearchVisual',  opts)
api.nvim_set_keymap('v', '<Leader>s', ':BrowserSearch<CR>',  opts)

