require('hop').setup()

local nmap = require('util').nmap

nmap('<leader>j', '<cmd>HopWord<CR>')

vim.cmd [[
  highlight! HopNextKey gui=bold guifg=#FF9800
  highlight! HopNextKey1 gui=bold guifg=#C792EA
  highlight! HopNextKey2 guifg=#82AAFF
  highlight! link HopUnmatched Comment
]]
