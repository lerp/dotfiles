"=============================================================================="
" PLUGINS {{{

" PLUGGED {{{

silent! if plug#begin('~/.vim/plugged')
    Plug 'Valloric/YouCompleteMe', { 'do': 'python2 install.py --clang-completer' }
    Plug 'Yggdroot/indentLine', {'for': 'python', 'on': 'IndentLinesEnable' }
    Plug 'ap/vim-css-color'
    Plug 'bling/vim-airline'
    Plug 'chrisbra/unicode.vim'
    Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
    Plug 'digitaltoad/vim-jade'
    Plug 'docunext/closetag.vim'
    Plug 'groenewege/vim-less'
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'junegunn/vim-after-object'
    Plug 'kien/ctrlp.vim'
    Plug 'myusuf3/numbers.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/syntastic'
    Plug 'tfnico/vim-gradle'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'vim-scripts/SearchComplete'
    Plug 'vim-scripts/camelcasemotion'
    Plug 'vim-scripts/octave.vim--'

    call plug#end()
endif

" }}}
" YCM {{{

let g:ycm_confirm_extra_conf = 0

" }}}
" NERDTREE {{{

augroup NERDTreeCommands
    autocmd!
    " autocmd VimEnter * NERDTree
augroup END

let NERDTreeChDirMode=1
let NERDTreeIgnore=['\.pyc$']
nnoremap <silent> <F2> :NERDTreeToggle<CR>:wincmd =<CR>

" }}}
" SYNTASTIC {{{

let g:syntastic_check_on_open=1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_cpp_checker = ['cpplint']
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

" Mapping to start eclim sever.
nnoremap <silent> <leader>se :!/usr/share/eclipse/eclimd -b<CR>

" }}}
" SUPERTAB {{{

let g:SuperTabDefaultCompletionType = "<C-N>"

" }}}
" EASYMOTION {{{
map <Space> <Plug>(easymotion-s2)
" }}}
" TOMORROW {{{
if filereadable($HOME . "/.vim/plugged/tomorrow-theme/vim/colors/Tomorrow-Night.vim")
    silent! colorscheme Tomorrow-Night

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
    set guifont=DejaVu\ Sans\ Mono\ 9

    " Get rid of all the window decoration that comes with gvim
    set guioptions=
endif

set laststatus=2
let g:airline_powerline_fonts = 1
" }}}
" CTRLP {{{
let g:ctrlp_custom_ignore = '\v\.(class|o)$'
" }}}
" VIM-AFTER-OBJECT {{{
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
" }}}


" }}}
"=============================================================================="
" OPTIONS {{{
"
" Change the vertical fill character to a space
set fillchars=vert:\

" Makes tab completion like bash's
set wildmenu
set wildmode=list:longest
set wildignore+=*.sw?   " Ignore swp files

" Set the leader key
let mapleader = " "
let maplocalleader = " "

" Change indent settings
set shiftwidth=4 softtabstop=4 tabstop=8 expandtab
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
nnoremap <silent> <leader>p :silent! set paste<CR>"+p:set nopaste<CR>

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
nnoremap <leader>s ea<C-X><C-S>

" Open terminal in current working directory
nnoremap <silent> <leader>t :!urxvt &<CR><CR>

" Sort the current paragraph
nnoremap <silent> <leader>sp vip:sort<CR>

" Open slides in directory
nnoremap <silent> <leader>os :!mupdf slides.pdf &<CR><CR>

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
    setlocal encoding=utf-8

    iabbrev <silent> <buffer> _0 ₀
    iabbrev <silent> <buffer> weierp ℘

    " Greek alphabet
    iabbrev <silent> <buffer> alpha α
    iabbrev <silent> <buffer> beta β
    iabbrev <silent> <buffer> gamma γ
    iabbrev <silent> <buffer> delta δ
    iabbrev <silent> <buffer> Delta Δ
    iabbrev <silent> <buffer> epsilon ε
    iabbrev <silent> <buffer> zeta ζ
    iabbrev <silent> <buffer> eta η
    iabbrev <silent> <buffer> theta θ
    iabbrev <silent> <buffer> iota ι
    iabbrev <silent> <buffer> kappa κ
    iabbrev <silent> <buffer> lambda λ
    iabbrev <silent> <buffer> mu μ
    iabbrev <silent> <buffer> nu ν
    iabbrev <silent> <buffer> xi ξ
    iabbrev <silent> <buffer> pi π
    iabbrev <silent> <buffer> rho ρ
    iabbrev <silent> <buffer> Sigma Σ
    iabbrev <silent> <buffer> sigma σ
    iabbrev <silent> <buffer> tau τ
    iabbrev <silent> <buffer> upsilon υ
    iabbrev <silent> <buffer> phi φ
    iabbrev <silent> <buffer> chi χ
    iabbrev <silent> <buffer> psi Ψ
    iabbrev <silent> <buffer> omega ω
    iabbrev <silent> <buffer> Omega Ω

    " Math Symbols
    iabbrev <silent> <buffer> +- ±
    iabbrev <silent> <buffer> *. ·
    iabbrev <silent> <buffer> !divide ÷
    iabbrev <silent> <buffer> !sqrt √
    iabbrev <silent> <buffer> !integral ∫
    iabbrev <silent> <buffer> !cintegral ∮
    iabbrev <silent> <buffer> !therefore ∴
    iabbrev <silent> <buffer> !because ∵
    iabbrev <silent> <buffer> !propto ∝
    iabbrev <silent> <buffer> !infinity ∞
    iabbrev <silent> <buffer> !equiv ≡

    " Logic Symbols
    iabbrev <silent> <buffer> !iff ↔
    iabbrev <silent> <buffer> !implies →
    iabbrev <silent> <buffer> !leq ≤
    iabbrev <silent> <buffer> !geq ≥
    iabbrev <silent> <buffer> !lesspref ≺
    iabbrev <silent> <buffer> !morepref ≻
endfunction

augroup filetype_txt
    autocmd!

    autocmd FileType text call SetupTextEnvironment()
augroup END

" }}}

" }}}
"=============================================================================="
" VIM TRAINING {{{
" I want to break the habit of pressing hjkl repeatedly to navigate, the below
" is to help break the bad pattern.
" Taken from http://jeetworks.org/from-acolyte-to-adept-the-next-step-after-nop-ing-arrow-keys/

function! DisableIfNonCounted(move) range
    if v:count
        return a:move
    else
        " You can make this do something annoying like:
           " echoerr "Count required!"
           " sleep 2
        return ""
    endif
endfunction

function! SetDisablingOfBasicMotionsIfNonCounted(on)
    let keys_to_disable = get(g:, "keys_to_disable_if_not_preceded_by_count", ["j", "k", "l", "h"])
    if a:on
        for key in keys_to_disable
            execute "noremap <expr> <silent> " . key . " DisableIfNonCounted('" . key . "')"
        endfor
        let g:keys_to_disable_if_not_preceded_by_count = keys_to_disable
        let g:is_non_counted_basic_motions_disabled = 1
    else
        for key in keys_to_disable
            try
                execute "unmap " . key
            catch /E31:/
            endtry
        endfor
        let g:is_non_counted_basic_motions_disabled = 0
    endif
endfunction

function! ToggleDisablingOfBasicMotionsIfNonCounted()
    let is_disabled = get(g:, "is_non_counted_basic_motions_disabled", 0)
    if is_disabled
        call SetDisablingOfBasicMotionsIfNonCounted(0)
    else
        call SetDisablingOfBasicMotionsIfNonCounted(1)
    endif
endfunction

command! ToggleDisablingOfNonCountedBasicMotions :call ToggleDisablingOfBasicMotionsIfNonCounted()
command! DisableNonCountedBasicMotions :call SetDisablingOfBasicMotionsIfNonCounted(1)
command! EnableNonCountedBasicMotions :call SetDisablingOfBasicMotionsIfNonCounted(0)

DisableNonCountedBasicMotions

" }}}
