" PLUGGED {{{

silent! if plug#begin('~/.config/nvim/plugged')
    Plug 'editorconfig/editorconfig-vim'
    Plug 'hsanson/vim-android'
    Plug 'numToStr/Comment.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'phaazon/hop.nvim'
    Plug 'puremourning/vimspector'
    Plug 'rmagatti/auto-session', {'branch': 'main'}
    Plug 'roxma/nvim-yarp'
    Plug 'rubberduck203/aosp-vim'
    Plug 'szw/vim-maximizer'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'vim-scripts/vim-gradle'
    Plug 'w0ng/vim-hybrid'

    Plug 'williamboman/nvim-lsp-installer', {'branch': 'main'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'jose-elias-alvarez/null-ls.nvim', {'branch': 'main'}

    Plug 'hrsh7th/cmp-nvim-lsp-signature-help', {'branch': 'main'}
    Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
    Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
    Plug 'hrsh7th/cmp-path', {'branch': 'main'}
    Plug 'hrsh7th/cmp-cmdline', {'branch': 'main'}
    Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}

    Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
    Plug 'hrsh7th/vim-vsnip'

    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' }
    Plug 'kelly-lin/telescope-ag', {'branch': 'main'}

    " Language packs
    Plug 'tikhomirov/vim-glsl'
    Plug 'pboettch/vim-cmake-syntax'
    Plug 'digitaltoad/vim-pug'

    Plug '~/workspace/android.nvim'

    call plug#end()
endif

" }}}

" Set the leader key
let mapleader = " "
let maplocalleader = " "

" vim-hybrid {{{
set background=dark
silent! colorscheme hybrid
highlight! Search guibg=NONE guifg=green
" }}}
" nvim-cmp {{{
set completeopt=menu,menuone,noselect

lua <<EOF
  local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.abbr = string.sub(vim_item.abbr, 1, 80)
        return vim_item
      end
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          end
        end, { "i", "s" }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp_signature_help' },
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    }),
    view = {
      entries = {name = 'custom', selection_order = 'near_cursor' }
    },
  })
EOF
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
" }}}
" lsp {{{
lua <<EOF
  require("nvim-lsp-installer").setup {}

  local lspconfig = require('lspconfig')
  local opts = { noremap=true, silent=true }

  vim.diagnostic.config {
    virtual_text = false
  }

  vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  lspconfig.clangd.setup {
    cmd = { "clangd", "--clang-tidy" },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>ClangdSwitchSourceHeader<CR>', opts)

      on_attach(client, bufnr)
    end,
    flags = { 
      debounce_text_changes = 150, 
    },
    offsetEncodings = 'utf-8'
  }

  lspconfig.java_language_server.setup {
    cmd = { "/usr/share/java/java-language-server/lang_server_linux.sh", },
    capabilities = capabilities,
    on_attach = on_attach,
  }

  lspconfig.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }

  lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }

  local null_ls = require('null-ls')

  null_ls.setup {
    sources = {
      null_ls.builtins.diagnostics.codespell,
      -- null_ls.builtins.diagnostics.selene,
      -- null_ls.builtins.formatting.google_java_format,
    },
  }
EOF

set updatetime=300

augroup lsp_actions
    autocmd!
    autocmd CursorHold * silent lua vim.diagnostic.open_float(nil, {underline=false, focus=false})
augroup end

" }}}
" lualine {{{
lua <<EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'wombat',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF
" }}}
" telescope {{{
lua <<EOF
    local actions = require("telescope.actions")
    local telescope = require("telescope")

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<ESC>"] = actions.close,
          },
        },
        file_ignore_patterns = {
            "build.*/.*",
            "env.*/.*",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      },
    }

    telescope.load_extension("fzf")
    telescope.load_extension("ag")
EOF

nnoremap <silent> <C-P> <cmd>Telescope find_files<CR>
nnoremap <silent> <leader>b <cmd>Telescope buffers<CR>
nnoremap <silent> gr <cmd>Telescope lsp_references<CR>
nnoremap <silent> <leader>v <cmd>Telescope lsp_document_symbols<CR>
nnoremap <silent> <leader>d <cmd>Telescope diagnostics bufnr=0<CR>
nnoremap <silent> <leader>D <cmd>Telescope diagnostics<CR>
" }}}
" editorconfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" }}}
" {{{ vim-android
let g:android_sdk_path = expand("$HOME/android-sdk")
let g:gradle_loclist_show = 0
let g:gradle_show_signs = 0
" }}}
" {{{ hop.nvim
lua require('hop').setup()

nnoremap <silent> <leader>j :HopWord<CR>
" }}}
" vimspector {{{
let g:vimspector_enable_mappings = 'HUMAN'

nmap <leader>db <Plug>VimspectorBreakpoints
nmap <Leader>di <Plug>VimspectorBalloonEval
" }}}
" Misc {{{
lua <<EOF
  require('Comment').setup{}
  require('auto-session').setup {
      log_level = 'info',
      auto_session_suppress_dirs = {'~/', '~/workspace'}
  }
EOF
" }}}

" }}}
" OPTIONS {{{

set termguicolors
set signcolumn=yes

" Disable automatic comments
set formatoptions-=o

" Don't remove/add an new line character at ends of files
set nofixendofline

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

set cursorline
set relativenumber

set shortmess+=c

" Always have a status line
set laststatus=2

" Change the vertical fill character to nothing
set fillchars=

" Makes tab completion like bash's
set wildmode=list:longest
set wildignore+=*.sw?   " Ignore swp files

" Change indent settings
set shiftwidth=4 softtabstop=4 tabstop=4 expandtab
set formatoptions=qrcn1

set autowrite
set showcmd
set mouse=a

" Enable back ups
set backup
set noswapfile  " Swap files are annoying
set autoread

augroup autoread_load
    au!
    au FocusGained,BufEnter * silent! checktime
augroup end

set undodir=~/.config/nvim/tmp/undo//
set backupdir=~/.config/nvim/tmp/backup//
set directory=~/.config/nvim/tmp/swap//

" Create the directories for vim's files
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Scroll when we're within 3 lines of the edge of the window
set scrolloff=3

" Make the editor effectively 80 columns wide
set nowrap
set textwidth=100
set colorcolumn=+1

" Ignore case when doing searches
set smartcase

" Precede each line with it's line number
set number

" Don't automatically change to the working directory to the file's directory
set noautochdir

" Stop the preview window from showing up
set completeopt-=preview

set list
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" Disable annoying beeping
set noerrorbells

set matchpairs+=<:>

set spelllang=en_gb

" }}}
" MAPPINGS {{{

" Remap % to the tab key. It's just easier!
nnoremap <tab> %
vnoremap <tab> %

" Makes up and down more logical
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Goodbye help menu!
noremap <F1> <ESC>

" Cut, Copy & Paste to clipboard
vnoremap <silent> <leader>x "+x
vnoremap <silent> <leader>y "+y
nnoremap <silent> <leader>p "+p

" Select all
nnoremap <silent> <leader>a ggvG$

" Cycle through tabs
nnoremap <silent> <leader>h :tabprevious<CR>
nnoremap <silent> <leader>l :tabnext<CR>

" Navigate splits
nnoremap <silent> <C-h> <C-W>h
nnoremap <silent> <C-l> <C-W>l
nnoremap <silent> <C-k> <C-W>k
nnoremap <silent> <C-j> <C-W>j

" Create new tab
nnoremap <silent> <C-t> :tabnew<CR>

" Make blank lines and stay in normal mode
nnoremap <silent> <leader>o o<Esc>k
nnoremap <silent> <leader>O O<Esc>j

" Centers the screen on the matched search
noremap n nzz
noremap N Nzz

" Clear hlsearch
nnoremap <silent> <leader>ch :nohlsearch<CR>

" Easy save, out of habit
noremap <silent> <C-S> :w<CR>

" Easier start of line & end of line
nnoremap H ^
nnoremap L $

" Easier escaping
inoremap jk <esc>l
inoremap <esc> <nop>

" Always do a case insensitive very magic search
nnoremap / /\v\c
nnoremap ? ?\v\c
vnoremap / /\v\c
vnoremap ? ?\v\c

" Clean trailing whitespace
nnoremap <leader>cw mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Mapping for easier spell checking.
nnoremap <leader>s ea<C-X><C-S>

" Sort the current paragraph
nnoremap <silent> <leader>sp vip:sort<CR>

" Close the current tab
nnoremap <silent> <leader>tc :tabclose<CR>

if has('nvim')
    " Open init.vim
    nnoremap <silent> <leader>ev :vsplit ~/.config/nvim/init.vim<CR>
    nnoremap <silent> <leader>rv :source ~/.config/nvim/init.vim<CR>

    " Make jk exit in terminal too
    tnoremap jk <C-\><C-n>

    " Open a terminal at the bottom
    nnoremap <leader>t :botright 10split +terminal<CR><C-\><C-n>:silent! set wfh<CR>
else
    " Open .vimrc
    nnoremap <silent> <leader>ev :vsplit ~/.vimrc<CR>
    nnoremap <silent> <leader>rv :source ~/.vimrc<CR>

    " Open terminal in current working directory
    nnoremap <silent> <leader>t :!urxvt &<CR><CR>
endif

if exists('g:gui_oni')
    au FileType fzf tnoremap <nowait><buffer> <esc> <c-g>
endif

if &diff
    map <leader>r :diffget REMOTE<CR>
    map <leader>l :diffget LOCAL<CR>
endif

" Disable Ex mode
nnoremap Q <nop>
command! Q q

" }}}
" CUSTOM FUNCTIONS {{{

" Make all parent directories and save the file
function! DirectorySave()
    call mkdir(expand('%:h'), 'p')
    write
endfunction

nnoremap <leader>w :call DirectorySave()<cr>

augroup FileCommands
    autocmd!

    " Change the title string to just the file name
    autocmd BufEnter * let &titlestring = expand("%:t")

    " Resize all split windows whenever vim is resized.
    autocmd VimResized * exe "wincmd" "="

    " Set .BAS files to basic filetype
    autocmd BufRead *.BAS setlocal ft=basic

    " Save whenever focus is lost
    autocmd BufLeave,FocusLost * silent! wall
augroup END

" }}}
" LANGUAGE SETTINGS {{{

" Vim ---------------------------------------------------------------------- {{{

augroup filetype_vim
    autocmd!

    " Enable folding for vim markers and automatically close all folds
    autocmd FileType vim setlocal foldmethod=marker foldlevelstart=0

    " Reload the vimrc whenever it's saved
    autocmd! BufWritePost *vimrc source %
augroup END

" }}}

" Lisp --------------------------------------------------------------------- {{{

augroup filetype_lisp
    autocmd!

    " Set tab width and make program for lisp
    autocmd FileType lisp setlocal tabstop=2 shiftwidth=2 softtabstop=2
\                                  makeprg=clisp\ %
augroup END

" }}}

" C++ ---------------------------------------------------------------------- {{{

" A command for inserting a C guard macro
function! CppGuard()
    call setline(1, "#pragma once")
endfunction

augroup filetype_cpp
    autocmd!

    " Use tabs instead of spaces in makefiles
    autocmd FileType make setlocal noexpandtab

    " Insert the Cpp Guard whenever a header file is opened
    autocmd BufNewFile *.h,*.hpp call CppGuard()

    nnoremap <leader>ets vi{:s/\v(case )(.*::)?(.*):/& return "\3";<CR>
augroup END

" }}}

" Bash --------------------------------------------------------------------- {{{

augroup filetype_bash
    autocmd!

    " Execute the file when in a sh file
    autocmd FileType sh setlocal makeprg=./%
augroup END

" }}}

" Latex -------------------------------------------------------------------- {{{

function! SetupLatexEnvironment()
    nnoremap <buffer> <F5> :wa<CR>:!rubber --pdf --warn all %<CR>
    nnoremap <buffer> <F6> :!mupdf %:r.pdf &<CR><CR>
endfunction

augroup filetype_latex
    autocmd!

    autocmd FileType plaintex,tex call SetupLatexEnvironment()
augroup END

" }}}

" {{{ CMake

function! SetupCmakeEnvironment()
    setlocal noexpandtab
endfunction

augroup filetype_txt
    autocmd!

    autocmd FileType cmake call SetupCmakeEnvironment()
augroup END

" }}}

" {{{ Python

function! SetupPythonEnvironment()
    setlocal textwidth=80
endfunction

augroup filetype_python
    autocmd!

    autocmd FileType python call SetupPythonEnvironment()
augroup END

" }}}

" }}}
