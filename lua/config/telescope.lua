--------------
-- Mappings --
--------------
P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

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
      n = { ["<c-t>"] = trouble.open_with_trouble },
      i = {
        ["<leader>h"] = R("telescope").extensions.hop.hop, -- hop.hop_toggle_selection
      },
      -- IMPORTANT
      -- either hot-reloaded or `function(prompt_bufnr) telescope.extensions.hop.hop end`
      -- custom hop loop to multi selects and sending selected entries to quickfix list
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      },
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
      file_browser = {
        theme = "ivy",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
          },
          ["n"] = {
            -- your custom normal mode mappings
          },
        },
      },
      telescope_browser = {
        docs_urls = {
          ["lua"] = [["https://www.google.com/search?q=%s&as_sitesearch=lua.org/manual/5.4"]],
          ["rust"] = [["https://doc.rust-lang.org/std/index.html?search=%s"]],
          ["cpp"] = [["https://www.google.com/search?q=%s&as_sitesearch=cppreference.com"]],
          ["c"] = [["https://www.google.com/search?q=%s&as_sitesearch=cppreference.com"]],
          ["java"] = [["https://docs.oracle.com/search/?q=%s&category=java&product=en%3Fjava"]],
          ["javascript"] = [["https://developer.mozilla.org/en-US/search?q=%s"]],
          ["php"] = [["https://www.php.net/manual-lookup.php?pattern=%s&scope=quickref"]],
          ["vim"] = [["https://vim.fandom.com/wiki/Special:Search?query=%s&scope=internal&contentType=&ns%5B0%5D=0"]],
          ["kotlin"] = [["https://kotlinlang.org/docs/home.html?q=%s&s=full"]],
        }
      },
      hop = {
        -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
        keys = { "a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
          "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
          "A", "S", "D", "F", "G", "H", "J", "K", "L", ":",
          "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", },
        -- Highlight groups to link to signs and lines; the below configuration refers to demo
        -- sign_hl typically only defines foreground to possibly be combined with line_hl
        sign_hl = { "WarningMsg", "Title" },
        -- optional, typically a table of two highlight groups that are alternated between
        line_hl = { "CursorLine", "Normal" },
        -- options specific to `hop_loop`
        -- true temporarily disables Telescope selection highlighting
        clear_selection_hl = false,
        -- highlight hopped to entry with telescope selection highlight
        -- note: mutually exclusive with `clear_selection_hl`
        trace_entry = true,
        -- jump to entry where hoop loop was started from
        reset_selection = true,
      },
    }
  }
}
require('telescope').load_extension('fzy_native')
require("telescope").load_extension('file_browser')
require("telescope").load_extension("refactoring")
require("telescope").load_extension('hop')
-- For project management.
-- My own extension for browser searching
-- require('telescope').load_extension('telescopebrowser')
