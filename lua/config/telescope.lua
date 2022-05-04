-- TODO: Make a config file specifically for lsp.
local opt = vim.opt
local fn = vim.fn
local cmd = vim.cmd
local g = vim.g
local api = vim.api
local opts = { noremap = true, silent = true }

-------------
-- Mappings --
--------------
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
