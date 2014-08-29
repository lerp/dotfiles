"=============================================================================="
" OPTIONS {{{

" Disable vi compatibility
set nocompatible

" Enable syntax highlighting
syntax on

" Change the vertical fill character to a space
set fillchars=vert:\

" Highlight search matches as we type
set incsearch

" Remove the buffer when a file is closed
set nohidden

" Fix backspace in insert mode
set backspace=indent,eol,start

" Makes tab completion like bash's
set wildmenu
set wildmode=list:longest
set wildignore+=*.sw?   " Ignore swp files

" Set the leader key
let mapleader = "-"
let maplocalleader = "_"

" Change indent settings
set shiftwidth=4 softtabstop=4 tabstop=8 expandtab
set smarttab
set autoindent
set formatoptions=qrcn1

set autowrite
set showcmd
set mouse=a

" Enable back ups
set backup
set noswapfile  " Swap files are annoying

set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

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
set textwidth=80
set colorcolumn=+1

" Ignore case when doing searches
set smartcase

" Relative numbers are so useful with commands like :m!
set relativenumber

" Don't automatically change to the working directory to the file's directory
set noautochdir

" Stop the preview window from showing up
set completeopt-=preview

set list
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" Disable annoying beeping
set noerrorbells
set vb t_vb=

" }}}
"=============================================================================="
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
vnoremap <silent> <leader>cu "+x
vnoremap <silent> <leader>cp "+y
nnoremap <silent> <leader>p :silent! set paste<CR>"+gP:set nopaste<CR>

" Select all
nnoremap <silent> <leader>a ggvG$

" Open vimrc
nnoremap <silent> <leader>ev :vsplit ~/dotfiles/vimrc<CR>

" Cycle through tabs
nnoremap <silent> <leader>h :tabprevious<CR>
nnoremap <silent> <leader>l :tabnext<CR>
nnoremap <silent> <C-H> :wincmd h<CR>
nnoremap <silent> <C-L> :wincmd l<CR>
nnoremap <silent> <C-K> :wincmd k<CR>
nnoremap <silent> <C-J> :wincmd j<CR>

" Create new tab
nnoremap <silent> <C-t> :tabnew<CR>

" Make blank lines and stay in normal mode
nnoremap <silent> <leader>o o<Esc>k
nnoremap <silent> <leader>O O<Esc>j

" Centers the screen on the matched search
noremap n nzz
noremap N Nzz

" Easy save, out of habit
noremap <silent> <C-S> :w<CR>

" Easier start of line & end of line
nnoremap H ^
nnoremap L $

" Easier escaping
inoremap jk <esc>l
inoremap <esc> <nop>

" Always do a very magic search
nnoremap / /\v
nnoremap ? ?\v
vnoremap / /\v
vnoremap ? ?\v

" Clean trailing whitespace
nnoremap <leader>cw mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Mapping for easier spell checking.
nnoremap <leader>s  ea<C-X><C-S>

" }}}
"=============================================================================="
" PLUGINS {{{

" VUNDLE {{{

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/css_color.vim'
Plugin 'vim-scripts/camelcasemotion'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'groenewege/vim-less'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-scripts/SearchComplete'
Plugin 'bling/vim-airline'
Plugin 'docunext/closetag.vim'
Plugin 'nvie/vim-flake8'

call vundle#end()
filetype plugin indent on

" }}}
" YCM {{{

let g:ycm_confirm_extra_conf = 0

" }}}
" NERDTREE {{{

augroup NERDTreeCommands
    autocmd!
    autocmd VimEnter * NERDTree
augroup END

let NERDTreeChDirMode=1
let NERDTreeIgnore=['\.pyc$']
nnoremap <silent> <F2> :NERDTreeToggle<CR>:wincmd =<CR>

" }}}
" SYNTASTIC {{{

let g:syntastic_check_on_open=1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_java_checker = 'javac'
let g:syntastic_javascript_checkers = ['jshint']

" }}}
" LINEPULSE {{{

let g:linepulse_start = "guibg"
let g:linepulse_end   = "#606060"
let g:linepulse_steps = 30
let g:linepulse_time  = 100

" }}}
" ECLIM {{{

set rtp+=~/.vim/eclim
let g:EclimCompletionMethod = 'omnifunc'

" }}}
" SUPERTAB {{{

let g:SuperTabDefaultCompletionType = "<C-N>"

" }}}
" EASYMOTION {{{
map <Space> <Plug>(easymotion-s2)
" }}}
" TOMORROW {{{
if filereadable($HOME . "/.vim/bundle/tomorrow-theme/vim/colors/Tomorrow-Night.vim")
    colorscheme Tomorrow-Night

    " Highlight anything that goes over 81 columns
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%>81v.\+/

    autocmd! GuiEnter * set vb t_vb=
endif
" }}}
" DELMITMATE {{{
let delimitMate_expand_cr = 1
" }}}
" AIRLINE {{{
if has("gui_running")
    set guifont=Liberation\ Mono\ for\ Powerline\ 9,Liberation\ Mono\ 9

    " Get rid of all the window decoration that comes with gvim
    set guioptions=
endif

set laststatus=2
let g:airline_powerline_fonts = 1
" }}}
" CTRLP {{{
let g:ctrlp_custom_ignore = '\v\.(class)$'
" }}}

" }}}
"=============================================================================="
" CUSTOM FUNCTIONS {{{

" Show the folding column
function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction

nnoremap <leader>f :call FoldColumnToggle()<cr>

" Make all parent directorys and save the file
function! DirectorySave()
    call mkdir(expand('%:h'), 'p')
    write
endfunction

nnoremap <leader>w :call DirectorySave()<cr>

function! JavaProject()
    NERDTreeClose
    ProjectsTree
endfunction

nnoremap <leader>jp :call JavaProject()<cr>

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
"=============================================================================="
" LANGUAGE SETTINGS {{{

" Java --------------------------------------------------------------------- {{{

function! SetupJavaEnvironment()
    set noautochdir
    set path=./**

    nnoremap <buffer> <F5> :wa<CR>:ProjectCD<CR>:!gradle run<CR>
    nnoremap <buffer> <F6> :wa<CR>:ProjectCD<CR>:!gradle run -Pcurrent=%<CR>
    nnoremap <buffer> <localleader>c 0i//<esc>
    onoremap <buffer> ib  :<c-u>execute "normal! ?{\rms%hme`sv`e"<cr>
    onoremap <buffer> in( :<c-u>normal! f(vi(<cr>
    onoremap <buffer> il( :<c-u>normal! F)vi(<cr>

    nnoremap <buffer> <silent> <localleader>i :JavaImportOrganize<CR>
endfunction

augroup filetype_java
    autocmd!

    " Set up mappings
    autocmd FileType java call SetupJavaEnvironment()
augroup END

" }}}

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
    let defname = "_" . toupper(expand("%:t:r")) .
\                 "_" . toupper(expand("%:e")) . "_"

    call setline(1, "#ifndef " . defname)
    call setline(2, "#define " . defname)
    call setline(3, "")
    call setline(4, "#endif //" . defname)
endfunction

function! SetupCppEnvironment()
    setlocal syntax=cpp11
    setlocal makeprg=make

    syntax on

    nnoremap <buffer> <F5> :wa<CR>:make!<CR>
endfunction

augroup filetype_cpp
    autocmd!

    " Set file syntax to C++11
    autocmd FileType hpp,cpp call SetupCppEnvironment()

    " Use tabs instead of spaces in makefiles
    autocmd FileType makefile setlocal noexpandtab

    " Insert the Cpp Guard whenever a header file is opened
    autocmd BufNewFile *.(h|hpp) call CppGuard()
augroup END

" }}}

" Bash --------------------------------------------------------------------- {{{

augroup filetype_bash
    autocmd!

    " Execute the file when in a sh file
    autocmd FileType sh setlocal makeprg=./%
augroup END

" }}}

" Python ------------------------------------------------------------------- {{{

function! SetupPythonEnvironment()
    let g:pymode_rope = 0
    let g:pymode_doc = 1
    let g:pymode_doc_key = 'K'
    let g:pymode_lint = 1
    let g:pymode_lint_checker = "pyflakes,pep8"
    let g:pymode_lit_write = 1
    let g:pymode_virtualenv = 1
    let g:pymode_breakpoint = 1
    let g:pymode_breakpoint_key = '<localleader>b'
    let g:pymode_syntax = 1
    let g:pymode_syntax_all = 1
    let g:pymode_syntax_indent_errors = g:pymode_syntax_all
    let g:pymode_sytnax_space_errors = g:pymode_syntax_all

    let g:pymode_folding = 0

    nnoremap <buffer> <silent> <F5> :wa<CR>:!python %<CR>
endfunction

augroup filetype_python
    autocmd!

    " Execute the file when in a sh file
    autocmd FileType python call SetupPythonEnvironment()
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

" CSS ---------------------------------------------------------------------- {{{

function! SetupCSSEnvironment()
    nnoremap <buffer> <leader>S vi{:sort<CR>
endfunction

augroup filetype_css
    autocmd!

    autocmd FileType css,less call SetupCSSEnvironment()
augroup END

" }}}

function! SetupJSEnvironment()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
endfunction

augroup filetype_js
    autocmd!

    autocmd FileType js call SetupJSEnvironment()
augroup END
