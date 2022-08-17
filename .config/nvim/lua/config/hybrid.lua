local util = require('util')

util.set_options {
  background = 'dark'
}

vim.cmd [[
  silent! colorscheme hybrid
  highlight! link NormalFloat Normal
  highlight! Search gui=bold guifg=#EEFFFF guibg=#404040
  highlight! MatchParen gui=bold guifg=#FFCB6B guibg=None
  highlight! Cursor gui=bold guifg=#EEFFFF guibg=#4F4F4F
  highlight! link TabLine Normal
  highlight! link TabLineFill SignColumn
]]
