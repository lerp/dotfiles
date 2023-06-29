local util = require('util')
local palette = require('palette')

util.set_options {
  background = 'dark'
}

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

  ["@lsp.type.method"] = { fg = palette.white },
  ["@lsp.type.function"] = { fg = palette.white },
  ["@lsp.type.parameter"] = { fg = palette.white },
  ["@lsp.type.property"] = { fg = palette.white },
  ["@lsp.type.variable"] = { fg = palette.white },
  ["@lsp.type.namespace"] = { fg = palette.white },
  ["@lsp.type.class"] = { fg = palette.white },
  ["@lsp.type.typeParameter"] = { fg = palette.purple },

  ["@lsp.mod.deduced"] = { fg = palette.orange },

  -- Treesitter
  TSComment = { fg = palette.gray },
  TSAnnotation = { fg = palette.white },
  TSAttribute = { fg = palette.white },
  TSConstructor = { fg = palette.white },
  TSType = { fg = palette.cyan, },
  TSTypeBuiltin = { fg = palette.orange },
  TSConditional = { fg = palette.blue },
  TSException = { fg = palette.orange },
  TSInclude = { fg = palette.cyan },
  TSKeyword = { fg = palette.blue, },
  TSKeywordFunction = { fg = palette.orange, },
  TSLabel = { fg = palette.white },
  TSNamespace = { fg = palette.white },
  TSRepeat = { fg = palette.blue },
  TSConstant = { fg = palette.white },
  TSConstBuiltin = { fg = palette.red },
  TSFloat = { fg = palette.red },
  TSNumber = { fg = palette.red },
  TSBoolean = { fg = palette.red },
  TSCharacter = { fg = palette.green },
  TSError = { fg = palette.error_red },
  TSFunction = { fg = palette.white, },
  TSFuncBuiltin = { fg = palette.cyan },
  TSMethod = { fg = palette.white },
  TSConstMacro = { fg = palette.cyan },
  TSFuncMacro = { fg = palette.cyan },
  TSVariable = { fg = palette.white, },
  TSVariableBuiltin = { fg = palette.white },
  TSProperty = { fg = palette.white },
  TSOperator = { fg = palette.white },
  TSField = { fg = palette.purple },
  TSParameter = { fg = palette.white },
  TSParameterReference = { fg = palette.white },
  TSSymbol = { fg = palette.gray },
  TSText = { fg = palette.white },
  TSPunctDelimiter = { fg = palette.white },
  TSTagDelimiter = { fg = palette.white },
  TSPunctBracket = { fg = palette.white },
  TSPunctSpecial = { fg = palette.gray },
  TSString = { fg = palette.green },
  TSStringRegex = { fg = palette.blue },
  TSStringEscape = { fg = palette.blue },
  TSTag = { fg = palette.purple },
  TSEmphasis = { italic = true },
  TSUnderline = { underline = true },
  TSTitle = { fg = palette.gray },
  TSLiteral = { fg = palette.red },
  TSURI = { fg = palette.cyan, underline = true },
  TSKeywordOperator = { fg = palette.blue },
  TSStructure = { fg = palette.red },
  TSStrong = { fg = palette.gray },
  TSQueryLinterError = { fg = palette.warning_orange },

  -- CMake
  cmakeTSVariable = { fg = palette.blue },

  -- cpp
  -- cStorageClass = { fg = palette.blue },
  cppTSField = { fg = palette.white },

  -- comment
  commentTSConstant = { fg = palette.white, }
}
