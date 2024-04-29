return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "Fildo7525/pretty_hover",
      "Issafalcon/lsp-overloads.nvim",
    },
    -- event = { "BufReadPost", "BufNewFile" },
    -- cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    config = function()
      local util = require("util")
      local buf_map = util.buf_map

      util.set_signs {
        DiagnosticSignError = "",
        DiagnosticSignWarn = "",
        DiagnosticSignInfo = "",
        DiagnosticSignHint = "",
      }

      vim.diagnostic.config {
        virtual_text = false,
        signs = true,
        float = {
          border = "single",
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      }

      -- Mason
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "clangd",
          "basedpyright",
          "ruff_lsp",
          "marksman",
          "yamlls",
          "cmake",
          "bashls",
        },
        automatic_installation = true,
      }

      -- Pretty Hover
      local pretty_hover = require("pretty_hover")

      pretty_hover.setup {
        border = "single",
      }

      -- LSP Config
      local lspconfig = require("lspconfig")

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = "single",
          focusable = false,
        })

      local on_attach = function(client, bufnr)
        buf_map(bufnr, "n", "gD", vim.lsp.buf.declaration)
        buf_map(bufnr, "n", "gi", vim.lsp.buf.implementation)
        buf_map(bufnr, "n", "<leader>rn", vim.lsp.buf.rename)
        buf_map(bufnr, "n", "<leader>ca", vim.lsp.buf.code_action)
        buf_map(bufnr, "n", "<leader>i", pretty_hover.hover)

        vim.api.nvim_create_augroup("lsp_actions", { clear = true, })
        vim.api.nvim_create_autocmd("CursorHold", {
          group = "lsp_actions",
          callback = function()
            vim.diagnostic.open_float({
              scope = "cursor",
              underline = false,
              focus = false,
              focusable = false,
            })
          end,
        })

        if client.server_capabilities.signatureHelpProvider then
          require("lsp-overloads").setup(client, {
            ui = {
              border = "single",
              focusable = false,
              floating_window_above_cur_line = false,
              max_height = 20,
            },
            keymaps = {},
            display_automatically = true
          })
        end

        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              if vim.b.formatting_enabled == nil or vim.b.formatting_enabled then
                vim.lsp.buf.format({ bufnr = bufnr })
              end
            end,
          })
        end
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Lua
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.api.nvim_get_runtime_file("", true),
              }
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }

      -- C++
      lspconfig.clangd.setup {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--log=verbose",
          "--offset-encoding=utf-16",
        },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          buf_map(bufnr, "n", "gh", "<cmd>ClangdSwitchSourceHeader<CR>")
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
        offsetEncodings = "utf-16"
      }

      -- Python
      lspconfig.basedpyright.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          basedpyright = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportUnusedCallResult = false,
                reportAny = false,
              }
            }
          }
        }
      }

      lspconfig.ruff_lsp.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- Misc
      lspconfig.marksman.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      lspconfig.yamlls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      lspconfig.cmake.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      lspconfig.bashls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
    end,
  },
}
