" PLUGINS {{{

" PLUGGED {{{

silent! if plug#begin('~/.config/nvim/plugged')
    Plug 'Valloric/YouCompleteMe', {'do': 'python2 install.py --clang-completer'}
    Plug 'ap/vim-css-color'
    Plug 'benekastah/neomake'
    Plug 'bling/vim-airline'
    Plug 'chaoren/vim-wordmotion'
    Plug 'chrisbra/unicode.vim'
    Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
    Plug 'digitaltoad/vim-jade'
    Plug 'docunext/closetag.vim'
    Plug 'evidens/vim-twig', {'for': 'twig'}
    Plug 'groenewege/vim-less'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'kien/ctrlp.vim'
    Plug 'myusuf3/numbers.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'tfnico/vim-gradle'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'vim-scripts/SearchComplete'
    Plug 'vim-scripts/octave.vim--'
    Plug 'wellle/targets.vim'

    call plug#end()
endif

" }}}

" YCM {{{

let g:ycm_confirm_extra_conf = 0

" }}}
" NEOMAKE {{{

let g:neomake_cpp_enable_makers = ['clang']

" }}}
" VIM-AIRLINE {{{

let g:airline_powerline_fonts = 1

" }}}
" TOMORROW-THEME {{{
silent! colorscheme Tomorrow-Night
" }}}
" NERDTREE {{{

let NERDTreeChDirMode=1
let NERDTreeIgnore=['\.pyc$']
nnoremap <silent> <F2> :NERDTreeToggle<CR>:wincmd =<CR>

" }}}
" ECLIM {{{

set rtp+=~/.vim/eclim
let g:EclimCompletionMethod = 'omnifunc'

" Mapping to start eclim sever.
nnoremap <silent> <leader>se :!/usr/share/eclipse/eclimd -b<CR>

" }}}
" SUPERTAB {{{

let g:SuperTabDefaultCompletionType = "<C-N>"

" }}}
" DELMITMATE {{{
let delimitMate_expand_cr = 1
" }}}
" CTRLP {{{
let g:ctrlp_custom_ignore = '\v\.(class|o)$'
" }}}
" }}}
" OPTIONS {{{

" Always have a status line
set laststatus=2

" Change the vertical fill character to nothing
set fillchars=

" Makes tab completion like bash's
set wildmode=list:longest
set wildignore+=*.sw?   " Ignore swp files

" Set the leader key
let mapleader = " "
let maplocalleader = " "

" Change indent settings
set shiftwidth=4 softtabstop=4 tabstop=8 expandtab
set formatoptions=qrcn1

set autowrite
set showcmd
set mouse=a

" Enable back ups
set backup
set noswapfile  " Swap files are annoying

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
set textwidth=80
set colorcolumn=+1

" Ignore case when doing searches
set smartcase

" Preceed each line with it's line number
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
vnoremap <silent> <leader>cu "+x
vnoremap <silent> <leader>cp "+y
nnoremap <silent> <leader>p  "+p

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

" Always do a very magic search
nnoremap / /\v
nnoremap ? ?\v
vnoremap / /\v
vnoremap ? ?\v

" Clean trailing whitespace
nnoremap <leader>cw mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Mapping for easier spell checking.
nnoremap <leader>s ea<C-X><C-S>

" Sort the current paragraph
nnoremap <silent> <leader>sp vip:sort<CR>

if has('nvim')
    " Open init.vim
    nnoremap <silent> <leader>ev :vsplit ~/.config/nvim/init.vim<CR>
    nnoremap <silent> <leader>rv :source ~/.config/nvim/init.vim<CR>

    " Make jk exit in terminal too
    tnoremap jk <C-\><C-n>

    " Open a terminal at the bottom
    nnoremap <leader>t :botright 10split +terminal<CR><C-\><C-n>:silent! set wfh<CR>
else
    " Open init.vim
    nnoremap <silent> <leader>ev :vsplit ~/.vimrc<CR>
    nnoremap <silent> <leader>rv :source ~/.vimrc<CR>

    " Open terminal in current working directory
    nnoremap <silent> <leader>t :!urxvt &<CR><CR>
endif

" }}}
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

function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]

    return join(lines, "\n")
endfunction

" }}}
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
    let directories = split(expand("%:h"), '/') +
                    \ [ expand("%:t:r"), expand("%:e") ]

    if !empty(directories) && directories[0] ==? "src"
        call remove(directories, 0)
    endif

    let guard = toupper(join(directories, "_")) . "_"

    call setline(1, "#ifndef " . guard)
    call setline(2, "#define " . guard)
    call setline(3, "")
    call setline(4, "#endif // " . guard)
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
    autocmd FileType cpp call SetupCppEnvironment()

    " Use tabs instead of spaces in makefiles
    autocmd FileType make setlocal noexpandtab

    " Insert the Cpp Guard whenever a header file is opened
    autocmd BufNewFile *.h,*.hpp call CppGuard()
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
    let g:syntastic_python_checkers = [ "flake8" ]

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

" JS ----------------------------------------------------------------------- {{{

function! SetupJSEnvironment()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
endfunction

augroup filetype_js
    autocmd!

    autocmd FileType js call SetupJSEnvironment()
augroup END

" }}}

" Octave (Matlab) ---------------------------------------------------------- {{{

function! RunInOctave(expression)
    execute "!octave -q --eval '" . a:expression . "'"
endfunction

function! SetupOctaveEnvironment()
    set filetype=octave

    nnoremap <buffer> <F5> :wa<CR>:!octave -q "%"<CR>
    nnoremap <buffer> <F6> :call RunInOctave(getline('.'))<CR>
    vnoremap <buffer> <silent> <F6> :call RunInOctave(<SID>get_visual_selection())<CR>
endfunction

augroup filetype_m
    autocmd!

    autocmd FileType matlab call SetupOctaveEnvironment()
augroup END

" }}}

" Text --------------------------------------------------------------------- {{{

function! SetupTextEnvironment()
    setlocal spell
endfunction

augroup filetype_txt
    autocmd!

    autocmd FileType text call SetupTextEnvironment()
augroup END

" }}}

" }}}
