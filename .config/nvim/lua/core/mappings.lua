local util = require('util')
local map = util.map

util.set_leader(' ')

-- init.lua
map('n', '<leader>rv', '<cmd>lua dofile(vim.env.MYVIMRC)<cr>')
map('n', '<leader>ev', '<cmd>tabnew $MYVIMRC<cr><cmd>lcd %:h<cr>')

-- Navigation
map('n', 'k', 'gk')
map('n', 'j', 'gj')
map('n', 'H', '^')
map('n', 'L', '$')
map('i', 'jk', '<esc>l')
map({ 'n', 'v' }, '<tab>', '%')

-- Clipboard
map('v', '<leader>x', '"+x')
map('v', '<leader>y', '"+y')
map('n', '<leader>p', '"+p')
map('n', '<leader>a', 'ggVG$') -- Select all

-- Splits
map('n', '<C-h>', '<C-W>h')
map('n', '<C-l>', '<C-W>l')
map('n', '<C-k>', '<C-W>k')
map('n', '<C-j>', '<C-W>j')

-- Tabs
map('n', '<C-t>', '<cmd>tabnew<cr>')
map('n', '<leader>h', '<cmd>tabprevious<cr>')
map('n', '<leader>l', '<cmd>tabnext<cr>')
map('n', '<leader>tc', '<cmd>tabclose<CR>')

-- Search
map('n', 'n', 'nzz')                          -- Center on search
map('n', 'N', 'Nzz')
map('n', '<leader>ch', '<cmd>nohlsearch<cr>') -- Clear highlight
map('n', '/', [[/\v\c]])
map('n', '?', [[?\v\c]])
map('v', '/', [[/\v\c]])
map('v', '?', [[?\v\c]])

-- Misc
map('n', '<leader>s', 'ea<C-X><C-S>')                                 -- Spellcheck
map('n', '<leader>cw', [[mz<cmd>%s/\s\+$//<cr><cmd>let @/=''<cr>`z]]) -- Clear trailing whitespace
map({ 'n', 'v', 'i' }, '<C-S>', '<cmd>update<cr>')                    -- Save

-- diagnostic
map("n", "<leader>e", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>q", vim.diagnostic.setloclist)
