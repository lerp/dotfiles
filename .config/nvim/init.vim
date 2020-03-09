" PLUGINS {{{

" PLUGGED {{{

silent! if plug#begin('~/.config/nvim/plugged')

    Plug 'google/vim-codefmt'
    Plug 'google/vim-maktaba'
    Plug 'itchyny/lightline.vim'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
    Plug 'lervag/vimtex'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'roxma/nvim-yarp'
    Plug 'szw/vim-maximizer'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-unimpaired'
    Plug 'vim-scripts/vim-gradle'
    Plug 'w0ng/vim-hybrid'

    call plug#end()
endif

" }}}

" vim-hybrid {{{
set background=dark
silent! colorscheme hybrid
" }}}
" lightline.vim {{{
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [
    \      [ 'mode', 'paste' ],
    \      [ 'git', 'cocstatus', 'readonly', 'filename', 'modified' ]
    \   ],
    \   'right': [
    \      [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
    \      [ 'blame' ]
    \   ],
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'blame': 'LightlineGitBlame'
    \ },
\ }

augroup coc_lightline
    autocmd!
    autocmd User CocStatusChange, CocDiagnosticChange call lightline#update()
augroup end

function! LightlightGitBlame() abort
    let blame = get(b:, 'coc_git_blame', '')
    return winwidth(0) > 120 ? blame : ''
endfunction

" }}}
" coc.nvim {{{
" Enable tabbing through popup menu
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : 
                    \ <SID>check_back_space() ? "\<Tab>" :
                    \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col -1] =~# '\s'
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>d :CocList diagnostics<CR>
nmap <silent> gh :CocCommand clangd.switchSourceHeader<CR>
" imap <silent> <C-l> <Plug>(coc-snippets-expand)
" imap <silent> <C-j> <Plug>(coc-snippets-expand-jump)
" vmap <silent> <C-j> <Plug>(coc-snippets-select)

" noinsert: prevent automatic text injection
" menuone: Shows the popup menu even if there's only one match
" noselect: prevents automatic selection
set completeopt=noinsert,menuone,noselect
set updatetime=300

highlight CocUnderline cterm=undercurl
highlight CocErrorHighlight ctermfg=red cterm=underline guifg=red gui=undercurl
highlight CocWarningHighlight ctermfg=yellow guifg=yellow cterm=underline guifg=yellow gui=undercurl

augroup coc_actions
    autocmd!
    autocmd CursorHold * silent call CocActionAsync('highlight')
    autocmd CursorHold * silent call CocActionAsync('showSignatureHelp')
augroup end

" }}}
" fzf {{{
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nnoremap <C-P> :FZF<CR>
" }}}
" vim-codefmt {{{
nnoremap <silent> == :FormatLines<CR>
vnoremap <silent> = :FormatLines<CR>
nnoremap <silent> <leader>fc :FormatCode<CR>

augroup codefmt_actions
    autocmd!
    autocmd FileType h,c,cpp,py silent :AutoFormatBuffer
augroup end
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

" Set the leader key
let mapleader = " "
let maplocalleader = " "

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

    " Set .BAS files to basic filetype
    autocmd BufRead *.BAS setlocal ft=basic

    " Save whenever focus is lost
    autocmd BufLeave,FocusLost * silent! wall
augroup END

let s:session_loaded = 1
let s:session_path = "~/.config/nvim/lastsession.vim"

augroup autosession
  " load last session on start
  " Note: without 'nested' filetypes are not restored.
  autocmd VimEnter * nested call s:session_vim_enter()
  autocmd VimLeavePre * call s:session_vim_leave()
augroup END

function! s:session_vim_enter()
    if bufnr('$') == 1 && bufname('%') == '' && !&mod && getline(1, '$') == ['']
        execute 'silent source ' . s:session_path
    else
      let s:session_loaded = 0
    endif
endfunction

function! s:session_vim_leave()
  if s:session_loaded == 1
    let sessionoptions = &sessionoptions
    try
        set sessionoptions-=options
        set sessionoptions+=tabpages
        execute 'mksession! ' . s:session_path
    finally
        let &sessionoptions = sessionoptions
    endtry
  endif
endfunction

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

augroup filetype_cpp
    autocmd!

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
"
function! SetupCmakeEnvironment()
    setlocal noexpandtab
endfunction

augroup filetype_txt
    autocmd!

    autocmd FileType cmake call SetupCmakeEnvironment()
augroup END

" }}}

" }}}
