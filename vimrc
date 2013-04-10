" Disable vi compatibility
set nocompatible

" Highlight search matches as we type
set incsearch

" Highlight the cursor column and line
set cursorcolumn
set cursorline

" Makes vim create an undo file so things can be undone between sessions!
set undofile

" Remap % to the tab key. It's just easier!
nnoremap <tab> %
vnoremap <tab> %

" Mapping to select the previously pasted text
nnoremap <leader>v V` ]

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
map <C-X> "+x
map <C-C> "+y
map <C-V> "+gP

" Map ; to : in normal mode just for easyness
nnoremap ; :


" Indent settings
set sw=4 sts=4 ts=4 expandtab
set smarttab
set autoindent

set autowrite
set showcmd
set mouse=a
set relativenumber
set autochdir

if has("gui_running")
    colorscheme twilight
    set guifont=Liberation\ Mono\ 9
    set guioptions-=T "Hides the toolbar
    set guioptions-=r "Hides the right scrollbar
endif

if has("au")
    filetype on

    au FileType c,h,hpp,cpp setlocal makeprg=make
    au FileType lisp setlocal ts=2 sw=2 sts=2 makeprg=clisp\ %

    " Save all files when the window loses focus
    au FocusLost * :wa
endif

execute pathogen#infect()

" let g:clang_debug = 1
let g:clang_complete_copen = 1
let g:clang_use_library = 1
let g:clang_library_path = '/usr/lib/'
let g:clang_user_options = '|| exit 0'
