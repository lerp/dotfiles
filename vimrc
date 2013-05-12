" Disable vi compatibility
set nocompatible
filetype off
syntax on

" Highlight search matches as we type
set incsearch

" Highlight the cursor column and line
set cursorcolumn
set cursorline

" Fix backspace in insert mode
set backspace=indent,eol,start

" Remap % to the tab key. It's just easier!
nnoremap <tab> %
vnoremap <tab> %

" Remove Ex mode binding, I have no idea what it does and I keep hitting it :C
nnoremap Q <Nop>

" Makes tab completion like bash's
set wildmode=list:longest
set wildmenu

" Scroll when we're within 3 lines of the edge of the window
set scrolloff=3

" Forces me to use hjkl for navigating!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Goodbye help menu!
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Windows style Cut, Copy & Paste
nnoremap <silent> <C-X> "+x
nnoremap <silent> <C-C> "+y
nnoremap <silent> <C-V> "+gP
nnoremap <silent> <C-A> ggvG$
nnoremap <silent> <C-Z> u
nnoremap <silent> <C-S> :w<CR>

" Other useful mappings
" Select current block
nnoremap <leader>f ^v$%

" Save and build
nnoremap <F5> :wa<CR>:make! run \| copen<CR>

" Open vimrc
nnoremap <leader>v :tabnew ~/dotfiles/vimrc<CR>

" Cycle through tabs
nnoremap <C-Q> gT
nnoremap <C-E> gt

" Map ; to : in normal mode just for easyness
nnoremap ; :


" Default indent settings
set sw=4 sts=4 ts=4 expandtab
set smarttab
set autoindent

set autowrite
set showcmd
set mouse=a
set relativenumber
set autochdir

if has("gui_running")
    colorscheme jellybeans
    set guifont=Liberation\ Mono\ 9
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=e
    set guioptions-=L
endif

if has("au")
    au FileType c,h,hpp,cpp setlocal makeprg=make
    au FileType lisp setlocal ts=2 sw=2 sts=2 makeprg=clisp\ %
    au FileType makefile setlocal noexpandtab
    au FileType d setlocal makeprg=dmd\ %

    " Save all files when the window loses focus
    au FocusLost * :wa
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle' 
Bundle 'Valloric/YouCompleteMe'
let g:ycm_confirm_extra_conf=0

filetype plugin indent on

call pathogen#infect()

autocmd VimEnter * NERDTree 
let NERDTreeChDirMode=1
