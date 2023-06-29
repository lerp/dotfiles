require('nvim-lsp-installer').setup {}

local lspconfig = require('lspconfig')
local util = require('util')
local nmap = util.nmap
local buf_nmap = util.buf_nmap

vim.lsp.set_log_level('debug')
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  float = {
    border = 'single',
    format = function(diagnostic)
      -- if diagnostic.code ~= nil then
      --   return string.format('%s [%s]', diagnostic.message, diagnostic.code)
      -- end

      return diagnostic.message
    end,
  },
}

nmap('<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
nmap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
nmap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
nmap('<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')

local function on_attach(client, bufnr)
  buf_nmap(bufnr, 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_nmap(bufnr, 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_nmap(bufnr, '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  buf_nmap(bufnr, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

  vim.api.nvim_create_augroup('lsp_actions', {
    clear = true
  })
  vim.api.nvim_create_autocmd('CursorHold', {
    group = 'lsp_actions',
    callback = function(ev)
      ret = vim.diagnostic.open_float(nul, {underline=false, focus=false})

      if ret == nil then
        vim.lsp.buf.hover()
      end
    end
  })

  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

vim.lsp.set_log_level('off')

util.set_signs {
  DiagnosticSignError = '',
  DiagnosticSignWarn = '',
  DiagnosticSignInfo = '',
  DiagnosticSignHint = '',
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.clangd.setup {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--completion-style=bundled',
    '--cross-file-rename',
    '--header-insertion=iwyu',
    '--log=verbose',
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    buf_nmap(bufnr, 'gh', '<cmd>ClangdSwitchSourceHeader<CR>')
    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  offsetEncodings = 'utf-8'
}

lspconfig.java_language_server.setup {
  cmd = { '/usr/share/java/java-language-server/lang_server_linux.sh', },
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
  }
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.ltex.setup{}
lspconfig.csharp_ls.setup{}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
  focusable = false,
})
