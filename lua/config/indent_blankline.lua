-- Indent blankline
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#000000 gui=nocombine]]
require('indent_blankline').setup {
  space_char_blankline = " ",
  char_highlight_list = {
    "IndentBlanklineIndent1",
  }
}
