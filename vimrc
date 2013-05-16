" Disable vi compatibility
set nocompatible
filetype off
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

" Remap % to the tab key. It's just easier!
nnoremap <tab> %
vnoremap <tab> %

" Remove Ex mode binding, I have no idea what it does and I keep hitting it :C
nnoremap Q <nop>

" Makes tab completion like bash's
set wildmode=list:longest
set wildmenu

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
nnoremap <silent> <leader>v :tabnew ~/dotfiles/vimrc<CR>

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

" Map ; to : in normal mode just for easyness
nnoremap ; :

" Remap gf to open file in new tab
nnoremap gf <C-W>gf

" Make blank lines and stay in normal mode
nnoremap <silent> <leader>o o<Esc>
nnoremap <silent> <leader>O O<Esc>

" Centers the screen on the matched search
map n nzz
map N Nzz

" Default indent settings
set sw=4 sts=4 ts=4 expandtab
set smarttab
set autoindent

set autowrite
set showcmd
set mouse=a
set relativenumber
set autochdir

" Stop the preview window from showing up
set completeopt-=preview

if has("gui_running")
    colorscheme jellybeans
    set guifont=Liberation\ Mono\ 9
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=e
    set guioptions-=L
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle' 
Bundle 'Valloric/YouCompleteMe'
let g:ycm_confirm_extra_conf=0

filetype plugin indent on

if !exists("g:loaded_pathogen")
    call pathogen#infect()
endif

augroup NERDTreeCommands
    autocmd!
    autocmd VimEnter * NERDTree 
augroup END

let NERDTreeChDirMode=1
nnoremap <silent> <F2> :NERDTreeToggle<CR>

let g:syntastic_check_on_open=1

function! OpenOther()
    exe "w"

    if expand("%:e") == "cpp"
        exe "e" fnameescape(expand("%:p:r:s?src?include?").".h")
    elseif expand("%:e") == "h"
        exe "e" fnameescape(expand("%:p:r:s?include?src?").".cpp")
    endif
endfunction

nmap <silent> <F3> :call OpenOther()<CR>

function! CppGuard()
    let s:defname = "_" . toupper(expand("%:t:r")) . "_" . toupper(expand("%:e")) . "_"

    call setline(1, "#ifndef " . s:defname)
    call setline(2, "#define " . s:defname)
    call setline(3, "")
    call setline(4, "#endif //" . s:defname)
endfunction

function! SplitOther()
    let s:pairs = [ [ "h", "cpp" ], [ "vert", "frag" ] ]
    let s:fname = expand("%:p:r")

    for [s:left, s:right] in s:pairs
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
endfunction 

augroup FileCommands
    autocmd!
    autocmd FileType c,h,hpp,cpp setlocal makeprg=make
    autocmd FileType lisp setlocal ts=2 sw=2 sts=2 makeprg=clisp\ %
    autocmd FileType makefile setlocal noexpandtab
    autocmd FileType d setlocal makeprg=dmd\ %

    " Save all files when the window loses focus
    autocmd FocusLost * :wa
    autocmd BufEnter * let &titlestring = expand("%:t")
    autocmd! BufWritePost vimrc source %
    
    autocmd! BufRead * call SplitOther()
    autocmd BufNewFile *.h call CppGuard()
augroup END
