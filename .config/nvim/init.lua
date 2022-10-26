local req = require('require')
local util = req('util')
local Path = require('plenary.path')

util.set_options {
  autochdir = false,
  autoread = true,
  autowrite = true,
  backup = false,
  colorcolumn = '+1',
  completeopt = 'menu,menuone,noselect',
  cursorline = true,
  errorbells = false,
  expandtab = true,
  fixendofline = false,
  foldenable = false,
  formatoptions = 'qrcn1',
  grepformat = '%f:%l:%c:%m',
  grepprg = [[ag --vimgrep $*]],
  hidden = false,
  laststatus = 2,
  list = true,
  listchars = [[tab:▸ ,eol:¬,trail:⋅,extends:❯,precedes:❮]],
  mouse = 'a',
  number = true,
  relativenumber = true,
  scrolloff = 3,
  shiftwidth = 4,
  showbreak = '↪',
  showcmd = true,
  signcolumn = 'yes:1',
  smartcase = true,
  softtabstop = 4,
  spelllang = 'en_gb',
  swapfile = false,
  tabstop = 4,
  termguicolors = true,
  textwidth = 100,
  undofile = true,
  updatetime = 300,
  wildignore = '*.o,*~,*.pyc',
  wildmode = 'longest,full',
  wrap = false,
}

util.append_options {
  fillchars = 'diff:╱',
  matchpairs = '<:>',
  shortmess = 'c',
}

local map = util.map
local nmap = util.nmap
local imap = util.imap
local vmap = util.vmap

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- init.lua
nmap('<leader>rv', '<cmd>lua dofile(vim.env.MYVIMRC)<cr>')
nmap('<leader>ev', '<cmd>vs $MYVIMRC<cr>')

-- Navigation
nmap('k', 'gk')
nmap('j', 'gj')
nmap('H', '^')
nmap('L', '$')
imap('jk', '<esc>l')
map({ 'n', 'v' }, '<tab>', '%')

-- Clipboard
vmap('<leader>x', '"+x')
vmap('<leader>y', '"+y')
nmap('<leader>p', '"+p')
nmap('<leader>a', 'ggVG$') -- Select all

-- Splits
nmap('<C-h>', '<C-W>h')
nmap('<C-l>', '<C-W>l')
nmap('<C-k>', '<C-W>k')
nmap('<C-j>', '<C-W>j')

-- Tabs
nmap('<C-t>', '<cmd>tabnew<cr>')
nmap('<leader>h', '<cmd>tabprevious<cr>')
nmap('<leader>l', '<cmd>tabnext<cr>')
nmap('<leader>tc', '<cmd>tabclose<CR>')

-- Search
nmap('n', 'nzz') -- Center on search
nmap('N', 'Nzz')
nmap('<leader>ch', '<cmd>nohlsearch<cr>') -- Clear highlight
nmap('/', [[/\v\c]])
nmap('?', [[?\v\c]])
vmap('/', [[/\v\c]])
vmap('?', [[?\v\c]])

-- Misc
nmap('<leader>s', 'ea<C-X><C-S>') -- Spellcheck
nmap('<leader>cw', [[mz<cmd>%s/\s\+$//<cr><cmd>let @/=''<cr>`z]]) -- Clear trailing whitespace
map({ 'n', 'v', 'i' }, '<C-S>', '<cmd>w<cr>') -- Save

req('plugins')

-- Custom Behaviour
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup('directory_save', { clear = true }),
  callback = function()
    Path:new(vim.fn.expand('%:h')):mkdir()
  end
})

-- Abbreviations
vim.cmd [[
  inoreabbrev namesapce namespace
  inoreabbrev tempalte template
  inoreabbrev vnvoa vnova
]]

vim.cmd [[
" Make all parent directories and save the file
augroup FileCommands
  autocmd!

  " Change the title string to just the file name
  autocmd BufEnter * let &titlestring = expand("%:t")

  " Save whenever focus is lost
  autocmd BufLeave,FocusLost * silent! wall
augroup END

augroup autoread_load
  au!
  au FocusGained,BufEnter * silent! checktime
augroup end

" Vim

augroup filetype_vim
  autocmd!

  autocmd! Filetype vim setlocal foldenable foldmethod=marker foldlevelstart=0
  autocmd! BufWritePost init.vim setlocal foldenable foldmethod=marker
augroup END

" C++

augroup filetype_cpp
  autocmd!

  " Use tabs instead of spaces in makefiles
  autocmd FileType make setlocal noexpandtab

  nnoremap <leader>ets vi{:s/\v(case )(.*::)?(.*):/& return "\3";<CR>
augroup END

" Bash

augroup filetype_bash
autocmd!

" Execute the file when in a sh file
autocmd FileType sh setlocal makeprg=./%
augroup END

" Latex

function! SetupLatexEnvironment()
nnoremap <buffer> <F5> :wa<CR>:!rubber --pdf --warn all %<CR>
nnoremap <buffer> <F6> :!mupdf %:r.pdf &<CR><CR>
endfunction

augroup filetype_latex
autocmd!

autocmd FileType plaintex,tex call SetupLatexEnvironment()
augroup END

" CMake

function! SetupCmakeEnvironment()
setlocal noexpandtab
endfunction

augroup filetype_txt
autocmd!

autocmd FileType cmake call SetupCmakeEnvironment()
augroup END

" Python

function! SetupPythonEnvironment()
setlocal textwidth=80
endfunction

augroup filetype_python
autocmd!

autocmd FileType python call SetupPythonEnvironment()
augroup END
]]
