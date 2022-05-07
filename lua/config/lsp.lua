local api = vim.api
local opts = { noremap = true, silent = true }

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
  api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'v', '<space>', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  --  vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
  --
  -- This next part is to open lsp diagnostics into a floating window ON HOVER
  -- vim.api.nvim_create_autocmd("CursorHold", {
  --   buffer = bufnr,
  --   callback = function()
  --     local diagnostic_opts = {
  --       focusable = false,
  --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  --       border = 'rounded',
  --       source = 'always',
  --       prefix = ' ',
  --       scope = 'cursor',
  --     }
  --     if vim.diagnostic.open_float(nil, diagnostic_opts) then
  --       vim.lsp.buf.code_action(nil, diagnostic_opts)
  --     end
  --   end
  -- })
end

-- LSP --
local expected_installed_servers = { "rust_analyzer", "tsserver", "bashls", "cssmodules_ls", "html", "intelephense" }
require("nvim-lsp-installer").setup {
  automatic_installation = true,
  ensure_installed = expected_installed_servers,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


local installable_servers = { "rust_analyzer", "tsserver", "bashls", "cssmodules_ls", "html", "intelephense" }

for _, server in ipairs(installable_servers) do
  require('lspconfig')[server].setup { capabilities = capabilities, on_attach = on_attach }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  -- This will disable virtual text, like doing:
  virtual_text = false,

  -- This is similar to:
  -- let g:diagnostic_show_sign = 1
  -- To configure sign display,
  --  see: ":help vim.lsp.diagnostic.set_signs()"
  signs = true,

  -- This is similar to:
  -- "let g:diagnostic_insert_delay = 1"
  update_in_insert = false,
}
)

-- lspconfig.rust_analyzer.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     -- to enable rust-analyzer settings visit:
--     -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
--     ["rust-analyzer"] = {
--       -- enable clippy on save
--       checkOnSave = {
--         command = "clippy"
--       },
--     }
--   }
-- }

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
