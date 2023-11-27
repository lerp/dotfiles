local null_ls = require('null-ls')

null_ls.setup {
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          if vim.b.formatting_enabled == nil or vim.b.formatting_enabled then
            vim.lsp.buf.format({ bufnr = bufnr })
          end
        end,
      })
    end
  end,

  sources = {
    null_ls.builtins.diagnostics.cspell,
    null_ls.builtins.formatting.google_java_format.with({
      extra_args = { "--aosp" },
    }),
    null_ls.builtins.diagnostics.pylint.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
    }),
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
  },
}
