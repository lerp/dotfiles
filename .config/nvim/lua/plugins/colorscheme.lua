return {
  {
    'HoNamDuong/hybrid.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      local util = require('util')
      local palette = require('palette')

      vim.cmd [[
        colorscheme hybrid
        highlight! link NormalFloat Normal
        highlight! link TabLine Normal
        highlight! link TabLineFill SignColumn
      ]]

      util.highlight {
        SignColumn = { bg = palette.bg },
        MatchParen = { fg = palette.bold_yellow, bg = 'None', bold = true },
        Search = { fg = palette.bright, bg = palette.dark_gray, bold = true },
        Cursor = { fg = palette.bright, bg = palette.cursor, bold = true },
        DiffAdd = palette.diff_add,
        DiffDelete = palette.diff_delete,
        DiffChange = palette.diff_change,
        DiffText = palette.diff_text,

        Statement = { fg = palette.blue },
        StorageClass = { fg = palette.orange },

        ["@lsp.type.method"] = { fg = palette.white },
        ["@lsp.type.function"] = { fg = palette.white },
        ["@lsp.type.parameter"] = { fg = palette.white },
        ["@lsp.type.property"] = { fg = palette.white },
        ["@lsp.type.variable"] = { fg = palette.white },
        ["@lsp.type.namespace"] = { fg = palette.white },
        ["@lsp.type.class"] = { fg = palette.white },
        ["@lsp.type.typeParameter"] = { fg = palette.purple },
        ["@lsp.mod.deduced"] = { fg = palette.orange },

        ["@function.builtin"] = { fg = palette.white },

        -- CMake
        cmakeTSVariable = { fg = palette.blue },

        -- cpp
        cppTSField = { fg = palette.white },
        cppAccess = { fg = palette.blue },
        cppNumber = { fg = palette.red },
        cppFloat = { fg = palette.red },

        -- comment
        commentTSConstant = { fg = palette.white, }
      }
    end,
  },
}
