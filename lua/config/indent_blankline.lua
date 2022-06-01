-- Indent blankline
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#808080 gui=nocombine]]
vim.cmd('highlight IndentBlanklineChar guifg=#808080 gui=nocombine')
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}
