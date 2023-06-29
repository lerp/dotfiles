local dap = require('dap')
local dapui = require('dapui')
-- local dapvt = require("nvim-dap-virtual-text")
local util = require('util')
local m = require('mapx')

util.set_signs {
  DapBreakpoint = '',
  DapBreakpointCondition = 'C',
  DapBreakpointRejected = '',
  DapLogPoint = 'L',
  DapStopped = '→',
}

util.highlight {
  DapBreakpoint = { ctermbg = 0, fg = '#993939', bg = 'None' },
  DapLogPoint = { ctermbg = 0, fg = '#61afef', bg = 'None' },
  DapStopped = { ctermbg = 0, fg = '#98c379', bg = 'None' }
}

dap.adapters.cpp = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb',
}

vim.cmd [[
augroup dap
  au!
  au FileType dap-repl lua require('dap.ext.autocompl').attach()
  au FileType dap-float nnoremap <buffer><silent> q <cmd>close!<cr>
augroup END
]]

m.group('silent', function()
  m.nnoremap('<F5>', function()
    require('dap.ext.vscode').load_launchjs('launch.json')
    require('dap').continue()
  end)
  m.nnoremap('<F9>', function() dap.toggle_breakpoint() end)
  m.nnoremap('<F10>', function() dap.step_over() end)
  m.nnoremap('<F11>', function() dap.step_into() end)
  m.nnoremap('<F12>', function() dap.step_out() end)
  m.nnoremap('<leader>B', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end)
  m.nnoremap('<leader>T', function() dap.terminate() end)
  m.nnoremap('<leader>?', [[<cmd>lua require('dap.ui.widgets').hover()<cr>]])
end)

dapui.setup {
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 80,
      position = "left",
    },
    {
      elements = {
        "repl",
      },
      size = 0.25,
      position = "bottom",
    },
  },
}

-- dapvt.setup {}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

m.nnoremap('<leader>du', [[<cmd>lua require('dapui').toggle()<cr>]], 'silent')
