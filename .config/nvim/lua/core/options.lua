local opts = {
  autochdir = false,
  autoread = true,
  autowrite = true,
  background = 'dark',
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
  mousemodel = '',
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

for key, value in pairs(opts) do
  vim.o[key] = value
end

local ext_opts = {
  fillchars = 'diff:╱',
  matchpairs = '<:>',
  shortmess = 'c',
}

for key, value in pairs(ext_opts) do
  vim.opt[key]:append(value)
end
