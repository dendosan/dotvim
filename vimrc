" Denton Elliott
" Vim Defaults {{{
set nocompatible
set noshowmode
" }}}
" Plugin Management {{{
syntax on
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-rails'
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/vim-js-pretty-template'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Source the vimrc file after saving it
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif
" }}}
" Folding {{{
"=== folding ===
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10    " start with fold level of 1
" }}}
" UltiSnips {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsSnippetDir="~/.vim"
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-k>"
let g:UltiSnipsJumpBackwardTrigger="<S-C-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
" Typescript settings {{{
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
autocmd FileType typescript JsPreTmpl html
autocmd FileType typescript syn clear foldBraces
" }}}
" Color settings {{{
"set background=dark
"colorscheme solarized
"colorscheme molokai
" colorscheme railscasts2
colorscheme badwolf
" }}}
" Leader shortcuts {{{
let mapleader = ","

" edit this file by typing ','V
nnoremap <leader>V :e $MYVIMRC<cr>
nmap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>f :CtrlPFunky<Cr>
" Initialise list by a word under cursor
nnoremap <leader>u :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
nnoremap <leader>/ :nohlsearch<CR>  " turn off search highlight
nnoremap <leader><leader> :bn<cr>     " hitting leader twice switches buffers

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>r :! clear; ruby %<CR>
" }}}
"NERDTree Settings {{{
" }}}
" CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
"let g:ctrlp_max_files=0
"let g:ctrlp_max_depth=40

" }}}
" POWERLINE {{{
" set rtp+=/Users/elliotd/miniconda2/lib/python2.7/site-packages/powerline/bindings/vim/
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim/
" set showtabline=1
set t_Co=256
" source /Users/elliotd/miniconda2/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2 " show a status line even if there's only one window
" }}}
" Vim Proc {{{
" set rtp+=/Users/elliotd/.vim/bundle/vimproc.vim/autoload/vimproc/
" set rtp+=/Users/elliotd/.vim/bundle/vimproc.vim/lib/vimproc_mac.so
" set rtp+=/Users/elliotd/.vim/bundle/vimproc.vim/plugin/vimproc.vim
" }}}
" Spaces, Tabs, General Config {{{
" Improve vim's scrolling speed
set ttyfast
set ttyscroll=3
set lazyredraw

set wildmode=longest,list,full
set wildmenu                    " show completion on the mode-line
set linespace=0                 " number of pixels between the lines
set splitright                  " open vertical splits on the right
set splitbelow                  " open the horizontal split below
set wrap                        " wrap long lines
set linebreak                   " break lines at word end
set nobackup                    " don't want no backup files
set nowritebackup               " don't make a backup before overwriting a file
set noswapfile                  " no swap files
set hidden                      " hide buffers when abandoned

" Time out on key codes but not mappings
set notimeout
set ttimeout
set ttimeoutlen=100

" Auto-reload buffers when files are changed on disk
set autoread

set undofile                    " Save undo's after file closes
set undodir=~/.vim/undo         " where to save undo histories
set undolevels=1000             " How many undos
set undoreload=10000            " number of lines to save for undo

set vb                          " disable alert sound
set showcmd                     " display incomplete commands
set history=100                 " a ton of history

" Whitespace
set tabstop=2 shiftwidth=2        " a tab is two spaces
set expandtab                     " use spaces, not tabs
" }}}
" Searching {{{
set incsearch                       " incremental searching
set hlsearch                        " highlight the search
set ignorecase                      " searches are case insensitive...
set smartcase                       " ... unless they contain at least one capital letter
set scrolloff=0                     " keep a 5 line padding when moving the cursor

"HTML Editing
set matchpairs+=<:>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
" }}}
" Scrolling {{{
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
" }}}
" Line Numbering {{{
"Toggle relative numbering, and set to absolute on loss of focus or insert mode
set rnu
function! ToggleNumbersOn()
    set nu!
    set rnu
endfunction
function! ToggleRelativeOn()
    set rnu!
    set nu
endfunction
autocmd FocusLost * call ToggleRelativeOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleRelativeOn()
autocmd InsertLeave * call ToggleRelativeOn()
" }}}
" Key Mappings {{{
" C-c send enter in insert mode
inoremap <C-c> <Esc>

" Expand %% to current directory
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%')<cr>

" Switch windows with control-<char> instead of control-w+<char>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}
" Display Hidden Chars {{{
set list          " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping
" }}}
" vim:foldmethod=marker:foldlevel=0
