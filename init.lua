require('options')
require('mappings')
require('plugins')

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

-- Setup nvim-cmp.
local has_words_before = function()
  local line, col = unpack(api.nvim_win_get_cursor(0))
  return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}


local cmp = require("cmp")
local luasnip = require("luasnip")

-- Autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"
-- Autopairs --

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  --    preselect = cmp.PreselectMode.None,
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
    { name = 'buffer' },
  })
})


-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
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
  api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<space>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
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
