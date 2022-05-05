local opt = vim.opt
local fn = vim.fn
local cmd = vim.cmd
local g = vim.g
local api = vim.api
local opts = { noremap = true, silent = true }

-- LSP --
require("nvim-lsp-installer").setup{}
local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<space>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --  api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'v', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)

  --  vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lspconfig.sumneko_lua.setup {on_attach = on_attach, capabilities = capabilities}
lspconfig.tsserver.setup {on_attach = on_attach, capabilities = capabilities}
lspconfig.bashls.setup {on_attach = on_attach, capabilities = capabilities}
lspconfig.cssls.setup {on_attach = on_attach, capabilities = capabilities}
lspconfig.html.setup {on_attach = on_attach, capabilities = capabilities}
lspconfig.intelephense.setup {on_attach = on_attach, capabilities = capabilities}
