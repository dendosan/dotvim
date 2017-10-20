" Denton Elliott
" Vim Defaults {{{
set nocompatible
set noshowmode          " hide default mode text (e.g. -- INSERT -- below the statusline)
set clipboard=unnamed   " yy, D, P, etc. work with system clipboard. No need to prefix them with "+ or "*.
set virtualedit=all     " cursor can travel to any space in buffer
set cpoptions+=$        " places $ at change position
" }}}
" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

Plug 'altercation/vim-colors-solarized'

Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'crusoexia/vim-javascript-lib'
Plug 'Quramy/vim-js-pretty-template'
Plug 'mxw/vim-jsx'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'qpkorr/vim-bufkill'

call plug#end()
" }}}
" Leader Shortcuts {{{
let mapleader=" "
map <leader>re :execute "edit " . $MYVIMRC<cr>
map <leader>rs :execute "source " . $MYVIMRC<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>/ :nohlsearch<cr>
" hitting leader twice switches buffers
nnoremap <leader><leader> :bn<cr>
" Fast saving
nnoremap <leader>w :w!<cr>
" Leader C is the prefix for code related mappîngs 
noremap <silent> <Leader>cc :TComment<cr>
" }}}
" UI Config {{{
set noshowcmd           " no show command in bottom bar
set showmatch           " highlight matching [{()}]
set hlsearch            " highlight search

set shiftwidth=2
set softtabstop=2
set tabstop=2

" for html/rb/groovy/xml files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype groovy setlocal ts=2 sw=2 expandtab
autocmd Filetype xml setlocal ts=2 sw=2 expandtab

" for js/coffee/jade files, 4 spaces
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype jade setlocal ts=4 sw=4 sts=0 expandtab

" Improve vim's scrolling speed
set ttyfast
set ttyscroll=3
set lazyredraw

set wildmode=longest,list,full
set wildmenu                    " show completion on the mode-line
set linespace=0                 " number of pixels between the lines
set splitright                  " open vertical splits on the right
set splitbelow                  " open the horizontal split below
" set wrap                        " wrap long lines
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

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Switch windows with control-<char> instead of control-w+<char>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" }}}
" Color settings {{{
let g:solarized_contrast="high"
let g:solarized_termcolors=256
set termguicolors
set background=dark
" set background=light
colorscheme solarized
" colorscheme molokai
" colorscheme monokai
" colorscheme railscasts2
" colorscheme badwolf
" colorscheme goodwolf
" colorscheme gruvbox
" colorscheme tomorrow-night
" }}}
" POWERLINE {{{
" set rtp+=/Users/elliotd/miniconda2/lib/python2.7/site-packages/powerline/bindings/vim/
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim/
set showtabline=2 " show tabline event if there's only one tab
set t_Co=256
" source /Users/elliotd/miniconda2/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2 " show a status line even if there's only one window
set guifont=Inconsolata-g\ for\ Powerline:h12
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
" }}}
" Snippets {{{
nnoremap <leader>html :-1read $HOME/.vim/.skeleton.html<cr>3jwf>a
" }}}
" Netrw {{{
"let g:netrw_banner=0            " Disable annoying banner
" }}}
" Display Hidden Chars {{{
set list                        " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping
"set listchars=tab:>-,trail:~,extends:»,precedes:« " Unprintable chars mapping
" }}}
"  Line Numbering {{{
"Toggle relative numbering, and set to absolute on loss of focus or insert mode
"set rnu
"function! ToggleNumbersOn()
"    set nu!
"    set rnu
"endfunction
"function! ToggleRelativeOn()
"    set rnu!
"    set nu
"endfunction
"autocmd FocusLost * call ToggleRelativeOn()
"autocmd FocusGained * call ToggleRelativeOn()
"autocmd InsertEnter * call ToggleRelativeOn()
"autocmd InsertLeave * call ToggleRelativeOn()

" vim-numbertoggle - Automatic toggling between 'hybrid' and absolute line numbers
set nu
set rnu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if &nu | set nornu | endif
augroup END
" }}}
" Folding {{{
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevelstart=10   " start with fold level of 1
" }}}
" Helper Functions {{{
function! ListLeaders()
     silent! redir @a
     silent! nmap <LEADER>
     silent! redir END
     silent! new
     silent! put! a
     silent! g/^s*$/d
     silent! %s/^.*,//
     silent! normal ggVg
     silent! sort
     silent! let lines = getline(1,"$")
endfunction
" }}}
" Help help {{{
" Help File speedups, <enter> to follow tag, delete for back
au filetype help nnoremap <buffer><cr> <c-]>
au filetype help nnoremap <buffer><bs> <c-T>
au filetype help nnoremap <buffer>q :q<CR>
au filetype help set nonumber
set splitbelow " Split windows, ie Help, make more sense to me below
au filetype help wincmd _ " Maximze the help on open
" }}}
" vim:foldmethod=marker:foldlevel=0
