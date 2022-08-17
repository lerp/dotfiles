local dap = require('dap')
local nmap = require('util').nmap


nmap('<F9>', [[<cmd>lua require('dap').toggle_breakpoint()<cr>]])
nmap('<F5>', [[<cmd>lua require('dap').continue()<cr>]])
