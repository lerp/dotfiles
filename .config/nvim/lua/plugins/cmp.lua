return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip/loaders/from_vscode").lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          format = function(_, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 80)
            return vim_item
          end
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
          },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it"s probably `<Tab>`.
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "vsnip" },
          { name = "buffer" },
        },
        view = {
          entries = { name = "custom", selection_order = "near_cursor" }
        },
      }

      require('util').highlight {
        CmpItemAbbrDeprecated = { bg = "None", strikethrough = true, fg = "#808080" },
        CmpItemAbbrMatch = { bg = "None", fg = "#569CD6" },
        CmpItemAbbrMatchFuzzy = { bg = "None", fg = "#569CD6" },
        CmpItemKindVariable = { bg = "None", fg = "#9CDCFE" },
        CmpItemKindInterface = { bg = "None", fg = "#9CDCFE" },
        CmpItemKindText = { bg = "None", fg = "#9CDCFE" },
        CmpItemKindFunction = { bg = "None", fg = "#C586C0" },
        CmpItemKindMethod = { bg = "None", fg = "#C586C0" },
        CmpItemKindKeyword = { bg = "None", fg = "#D4D4D4" },
        CmpItemKindProperty = { bg = "None", fg = "#D4D4D4" },
        CmpItemKindUnit = { bg = "None", fg = "#D4D4D4" },
      }
    end,
  },
}
