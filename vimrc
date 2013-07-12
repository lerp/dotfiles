" +-----------------------------------------------------------------------------------------------+
" |                                     Options Section                                           |
" +-----------------------------------------------------------------------------------------------+
" Disable vi compatibility
set nocompatible
filetype plugin indent on
syntax on

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

" Change indent settings
set sw=4 sts=4 ts=4 expandtab
set smarttab
set autoindent

set autowrite
set showcmd
set mouse=a

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

" +-----------------------------------------------------------------------------------------------+
" |                                     Mapping Section                                           |
" +-----------------------------------------------------------------------------------------------+

" Remap % to the tab key. It's just easier!
nnoremap <tab> %
vnoremap <tab> %

" Remove Ex mode binding, I have no idea what it does and I keep hitting it :C
nnoremap Q <nop>

" Scroll when we're within 3 lines of the edge of the window
set scrolloff=3

" Makes up and down more logical
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Goodbye help menu!
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Windows style Cut, Copy & Paste
vnoremap <silent> <leader>cu "+x
vnoremap <silent> <leader>cp "+y
nnoremap <silent> <leader>P "+gP
nnoremap <silent> <leader>A ggvG$

" Select current block
nnoremap <silent> <leader>f ^v$%

" Save and build
nnoremap <silent> <F5> :wa<CR>:make! run<CR>

" Open vimrc
nnoremap <silent> <leader>ev :vsplit ~/dotfiles/vimrc<CR>

" Cycle through tabs
nnoremap <silent> H :tabprevious<CR>
nnoremap <silent> Q :wincmd h<CR>
nnoremap <silent> L :tabnext<CR>
nnoremap <silent> E :wincmd l<CR>

" Create new tab
nnoremap <silent> <C-t> :tabnew<CR>

" Find and replace
nnoremap <leader>r :% s/

" Open errors window
nnoremap <silent> <leader>e :Errors<CR>

" Remap gf to open file in new tab
nnoremap gf <C-W>gf

" Make blank lines and stay in normal mode
nnoremap <silent> <leader>o o<Esc>
nnoremap <silent> <leader>O O<Esc>

" Centers the screen on the matched search
noremap n nzz
noremap N Nzz

" Easy save, out of habbit
nnoremap <silent> <C-S> :w<CR>

" +-----------------------------------------------------------------------------------------------+
" |                                     Plugins Section                                           |
" +-----------------------------------------------------------------------------------------------+

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle' 
Bundle 'Valloric/YouCompleteMe'
Bundle 'lerp/Jelp'
let g:ycm_confirm_extra_conf=0

if !exists("g:loaded_pathogen")
    call pathogen#infect()
endif

augroup NERDTreeCommands
    autocmd!
    autocmd VimEnter * NERDTree 
augroup END

let NERDTreeChDirMode=1
nnoremap <silent> <F2> :NERDTreeToggle<CR>:wincmd =<CR>

let g:syntastic_check_on_open=1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

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
    let s:fname = expand("%:p:r")

    for [s:left, s:right] in g:SplitPairs
        if expand("%:e") == s:left
            set splitright
            exe "vsplit" fnameescape(s:fname . "." . s:right) 
            break
        elseif expand("%:e") == s:right
            set nosplitright
            exe "vsplit" fnameescape(s:fname . "." . s:left)
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
