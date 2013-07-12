" +------------------------------------------------------------------------------------------------+
" |                                     Options Section                                            |
" +------------------------------------------------------------------------------------------------+
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

" Highlight the cursor column and line
set cursorcolumn
set cursorline

" Fix backspace in insert mode
set backspace=indent,eol,start

" Makes tab completion like bash's
set wildmode=list:longest
set wildmenu

" Set the leader key
let mapleader = "-"
let maplocalleader = "_"

" Change indent settings
set sw=4 sts=4 ts=4 expandtab
set smarttab
set autoindent

set autowrite
set showcmd
set mouse=a

" Scroll when we're within 3 lines of the edge of the window
set scrolloff=3

" Make the editor effectively 100 columns wide
set wrap
set textwidth=100
set colorcolumn=101

" Relative numbers are so useful with commands like :m!
set relativenumber

" Automatically change to the working directory to the file's directory
set autochdir

" Stop the preview window from showing up
set completeopt-=preview

" Set the colour to jellybeans if it exists
if filereadable("~/.vim/colors/jellybeans.vim")
    colorscheme jellybeans
endif

" Make the cursor lines stick out a bit more
hi CursorLine guibg=#2D2D2D
hi CursorColumn guibg=#2D2D2D

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

" +------------------------------------------------------------------------------------------------+
" |                                     Mapping Section                                            |
" +------------------------------------------------------------------------------------------------+
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
nnoremap <silent> <leader>p "+gP

" Select all
nnoremap <silent> <leader>a ggvG$

" Open vimrc
nnoremap <silent> <leader>ev :vsplit ~/dotfiles/vimrc<CR>

" Cycle through tabs
nnoremap <silent> H :tabprevious<CR>
nnoremap <silent> Q :wincmd h<CR>
nnoremap <silent> L :tabnext<CR>
nnoremap <silent> E :wincmd l<CR>

" Create new tab
nnoremap <silent> <C-t> :tabnew<CR>

" Remap gf to open file in new tab
nnoremap gf <C-W>gf

" Make blank lines and stay in normal mode
nnoremap <silent> <leader>o o<Esc>
nnoremap <silent> <leader>O O<Esc>

" Centers the screen on the matched search
noremap n nzz
noremap N Nzz

" Easy save, out of habbit
noremap <silent> <C-S> :w<CR>

" Easier start of line & end of line
nnoremap <leader>h ^
nnoremap <leader>l $

" Easier escaping
inoremap jk <esc>l
inoremap <esc> <nop>

" }}}

" +------------------------------------------------------------------------------------------------+
" |                                     Plugins Section                                            |
" +------------------------------------------------------------------------------------------------+
" {{{
" Vundle --------------------------------------------------------------------------------------- {{{

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle' 
Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-pathogen'
Bundle 'lerp/Jelp'

filetype plugin indent on

" }}}

" Pathogen ------------------------------------------------------------------------------------- {{{

if !exists("g:loaded_pathogen")
    call pathogen#infect()
endif

" }}}

" NERDTree ------------------------------------------------------------------------------------- {{{

augroup NERDTreeCommands
    autocmd!
    autocmd VimEnter * NERDTree 
augroup END

let NERDTreeChDirMode=1
nnoremap <silent> <F2> :NERDTreeToggle<CR>:wincmd =<CR>

" }}}

" YCM and Syntastic ---------------------------------------------------------------------------- {{{

let g:ycm_confirm_extra_conf=0
let g:syntastic_check_on_open=1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" }}}
" }}}

" +------------------------------------------------------------------------------------------------+
" |                                     Custom Section                                             |
" +------------------------------------------------------------------------------------------------+
" {{{

" A command for inserting a C guard macro
function! CppGuard()
    let s:defname = "_" . toupper(expand("%:t:r")) . "_" . toupper(expand("%:e")) . "_"

    call setline(1, "#ifndef " . s:defname)
    call setline(2, "#define " . s:defname)
    call setline(3, "")
    call setline(4, "#endif //" . s:defname)
endfunction

" Inserts a C guard macro
nnoremap <silent> <leader>cg :call CppGuard()<CR>

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

augroup FileCommands
    autocmd!

    " Set the make and indenting for different filetypes
    autocmd FileType h,cpp setlocal syntax=cpp11 makeprg=make
    autocmd FileType lisp setlocal ts=2 sw=2 sts=2 makeprg=clisp\ %
    autocmd FileType makefile setlocal noexpandtab
    autocmd FileType d setlocal makeprg=dmd\ %
    autocmd FileType sh setlocal makeprg=./%

    " Change the title string to just the file name
    autocmd BufEnter * let &titlestring = expand("%:t")

    " Reload the vimrc whenever it's saved
    autocmd! BufWritePost vimrc source %
    
    " Resize all split windows whenever vim is resized.
    autocmd VimResized * exe "wincmd" "="

    autocmd! BufRead * call SplitOther()
    autocmd BufNewFile *.h call CppGuard()
augroup END

" }}}

" +------------------------------------------------------------------------------------------------+
" |                                     Languages Section                                          |
" |                                     =================                                          |
" |                                                                                                |
" | This section sets up common commands for different languages I work in. I try to have the      |
" | commands listed below working for each language.                                               |
" |                                                                                                |
" |                                          Mappings                                              |
" |                                     =================                                          |
" |                                                                                                |
" | <F5>               - Save and execute                                                          |
" | <localleader>c     - Comment current line                                                      |
" |                                                                                                |
" |                                         Operators                                              |
" |                                     =================                                          |
" |                                                                                                |
" | ib                 - Inner block                                                               |
" | in(                - Inside next parenthesis                                                   |
" | il(                - Inside last parenthesis                                                   |
" |                                                                                                |
" +------------------------------------------------------------------------------------------------+
" {{{

" Java ----------------------------------------------------------------------------------------- {{{

function! SetupJavaEnvironment()
    nnoremap <buffer> <F5> :wa<CR>:!mvn exec:java<cr>
    nnoremap <buffer> <localleader>c 0i//<esc>
    onoremap <buffer> ib  :<c-u>execute "normal! ?{\rms%hme`sv`e"<cr>
    onoremap <buffer> in( :<c-u>normal! f(vi(<cr>
    onoremap <buffer> il( :<c-u>normal! F)vi(<cr>
endfunction

autocmd! FileType java call SetupJavaEnvironment()

" }}}

" Vim ------------------------------------------------------------------------------------------ {{{

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker foldlevelstart=0
augroup END

" }}}

" }}}
