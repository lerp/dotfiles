local nmap = require('util').nmap

require('diffview').setup()

nmap('<leader>fh', '<cmd>DiffviewFileHistory %<cr>')
nmap('<leader>cd', '<cmd>DiffviewClose<cr>')

vim.cmd [[
  highlight! DiffAdd guifg=None guibg=#243042
  highlight! DiffDelete guifg=#532D2D guibg=#422424
  highlight! DiffChange guifg=None guibg=#272D43
  highlight! DiffText guifg=None guibg=#3b4566
]]
