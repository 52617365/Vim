vim.api.nvim_command('highlight IndentBlanklineChar guifg=#808080 gui=nocombine')
-- Indent blankline
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}
