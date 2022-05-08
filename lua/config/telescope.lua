--------------
-- Mappings --
--------------
-- Trouble and telescope integration.
local trouble = require("trouble.providers.telescope")
-- Telescope.nvim
require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    project = {
      base_dirs = { '~/dev/file_analyzer/src', max_depth = 2,
        { '~/dev/Elasticsearch-Parser/src', max_depth = 2 },
        { '~/dev/work/site', max_depth = 2 },
        { '~/.config/nvim/lua', max_depth = 2 },
      },
      hidden_files = false, -- default: false
      theme = "dropdown",
    },
    telescope_browser = {
      engines = {
        { "rust", "asdasdasd" },
        { "mozilla", "123123123" },
      },
      browser = "firefox",
    }
  }
}
require('telescope').load_extension('fzy_native')
-- For project management.
require('telescope').load_extension('project')
-- My own extension for browser searching
require 'telescope'.load_extension('telescope_browser')
