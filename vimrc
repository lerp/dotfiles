" +----------------------------------------------------------------------------+
" |                             Options Section                                |
" +----------------------------------------------------------------------------+
" {{{

" Disable vi compatibility
set nocompatible

" Enable syntax highlighting
syntax on

" Enable status line
set laststatus=2
set statusline=%f
set statusline+=%=
set statusline+=%4l
set statusline+=/
set statusline+=%L

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

" Relative numbers are so useful with commands like :m!
set relativenumber

" Automatically change to the working directory to the file's directory
set autochdir

" Stop the preview window from showing up
set completeopt-=preview

set list
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" Set the colour to jellybeans if it exists
if filereadable($HOME . "/.vim/colors/jellybeans.vim")
    colorscheme jellybeans

    " Highlight anything that goes over 81 columns
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%>81v.\+/
endif

if has("gui_running")
    set guifont=Liberation\ Mono\ 9

    " Get rid of all the window deceration that comes with gvim
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=e
    set guioptions-=L

endif

" }}}

" +----------------------------------------------------------------------------+
" |                             Mapping Section                                |
" +----------------------------------------------------------------------------+
" {{{

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
nnoremap <silent> <leader>h :tabprevious<CR>:silent! DoPulse<CR>
nnoremap <silent> <leader>l :tabnext<CR>:silent! DoPulse<CR>
nnoremap <silent> <C-H> :wincmd h<CR>:silent! DoPulse<CR>
nnoremap <silent> <C-L> :wincmd l<CR>:silent! DoPulse<CR>
nnoremap <silent> <C-K> :wincmd k<CR>:silent! DoPulse<CR>
nnoremap <silent> <C-J> :wincmd j<CR>:silent! DoPulse<CR>

" Create new tab
nnoremap <silent> <C-t> :tabnew<CR>

" Remap gf to open file in new tab
nnoremap gf <C-W>gf

" Make blank lines and stay in normal mode
nnoremap <silent> <leader>o o<Esc>k
nnoremap <silent> <leader>O O<Esc>j

" Centers the screen on the matched search
noremap n nzz:silent! DoPulse<CR>
noremap N Nzz:silent! DoPulse<CR>

" Easy save, out of habbit
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

" Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" }}}

" +----------------------------------------------------------------------------+
" |                             Plugins Section                                |
" +----------------------------------------------------------------------------+
" {{{
" Vundle ------------------------------------------------------------------- {{{

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-pathogen'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'lerp/linepulse'
Bundle 'L9'
Bundle 'othree/vim-autocomplpop'

filetype plugin indent on

" }}}

" Pathogen ----------------------------------------------------------------- {{{

if !exists("g:loaded_pathogen")
    call pathogen#infect()
endif

" }}}

" NERDTree ----------------------------------------------------------------- {{{

augroup NERDTreeCommands
    autocmd!
    autocmd VimEnter * NERDTree
augroup END

let NERDTreeChDirMode=1
nnoremap <silent> <F2> :NERDTreeToggle<CR>:wincmd =<CR>

" }}}

" YCM and Syntastic -------------------------------------------------------- {{{

let g:ycm_confirm_extra_conf=0
let g:syntastic_check_on_open=1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_java_checker = 'javac'

" }}}

" LinePulse ---------------------------------------------------------------- {{{

let g:linepulse_start = "guibg"
let g:linepulse_end   = "#606060"
let g:linepulse_steps = 30
let g:linepulse_time  = 100

" }}}

" Eclim ---------------------------------------------------------------------{{{

if isdirectory($HOME . ".vim/bundle/eclim")
    set rtp+=~/.vim/bundle/eclim
endif

" }}}

" }}}

" +----------------------------------------------------------------------------+
" |                             Custom Section                                 |
" +----------------------------------------------------------------------------+
" {{{

" The pairs used by SplitOther()
let g:SplitPairs = [
\   [ "h", "cpp" ],
\   [ "vert", "frag" ],
\ ]

" Opens a vertical split for relative files.
" I.e. Opening myfile.h opens myfile.cpp.
function! SplitOther()
    let fname = expand("%:p:r")

    for [leftExt, rightExt] in g:SplitPairs
        if expand("%:e") == leftExt
            set splitright
            exe "vsplit" fnameescape(fname . "." . rightExt)
            break
        elseif expand("%:e") == rightExt
            set nosplitright
            exe "vsplit" fnameescape(fname . "." . leftExt)
            break
        endif
    endfor

    exe "filetype" "detect"
    exe "wincmd" "="
endfunction

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

augroup FileCommands
    autocmd!

    " Change the title string to just the file name
    autocmd BufEnter * let &titlestring = expand("%:t")

    " Resize all split windows whenever vim is resized.
    autocmd VimResized * exe "wincmd" "="

    " Attempt to open the relative file for this file
    autocmd BufRead * call SplitOther()
augroup END

" }}}

" +----------------------------------------------------------------------------+
" |                             Languages Section                              |
" |                             =================                              |
" |                                                                            |
" | This section sets up common commands for different languages I work in. I  |
" | try to have the commands listed below working for each language.           |
" |                                                                            |
" |                                  Mappings                                  |
" |                             =================                              |
" |                                                                            |
" | <F5>               - Save and execute                                      |
" | <localleader>c     - Comment current line                                  |
" |                                                                            |
" |                                 Operators                                  |
" |                             =================                              |
" |                                                                            |
" | ib                 - Inner block                                           |
" | in(                - Inside next parenthesis                               |
" | il(                - Inside last parenthesis                               |
" |                                                                            |
" +----------------------------------------------------------------------------+
" {{{

" Java --------------------------------------------------------------------- {{{

function! SetupJavaEnvironment()
    nnoremap <buffer> <F5> :wa<CR>:Mvn exec:java<cr>
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

    " Enable folding
    autocmd FileType java setlocal foldmethod=marker foldmarker={,}
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

augroup filetype_cpp
    autocmd!

    " Set file syntax to C++11
    autocmd FileType h,cpp setlocal syntax=cpp11 makeprg=make

    " Use tabs instead of spaces in makefiles
    autocmd FileType makefile setlocal noexpandtab

    " Insert the Cpp Guard whenever a header file is opened
    autocmd BufNewFile *.h call CppGuard()

    autocmd FileType h,cpp setlocal foldmethod=marker foldmarker={,}
augroup END

" }}}

" Bash --------------------------------------------------------------------- {{{

augroup filetype_bash
    autocmd!

    " Execute the file when in a sh file
    autocmd FileType sh setlocal makeprg=./%
augroup END

" }}}

" }}}
