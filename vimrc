" Denton Elliott
" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()
" }}}

let mapleader=" "
map <leader>re :execute "edit " . $MYVIMRC<cr>
map <leader>rs :execute "source " . $MYVIMRC<cr>
nnoremap <leader>/ :nohlsearch<cr>
" hitting leader twice switches buffers
nnoremap <leader><leader> :bn<cr>
" Fast saving
nnoremap <leader>w :w!<cr>

" UI Config {{{
set noshowcmd           " no show command in bottom bar
set showmatch           " highlight matching [{()}]
set hlsearch            " highlight search

set shiftwidth=2
set softtabstop=2
set tabstop=2

" for html/rb files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

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

" }}}
" Display Hidden Chars {{{
set list                        " Display unprintable characters f12 - switches
set listchars=tab:>-,trail:~,extends:»,precedes:« " Unprintable chars mapping
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
" vim:foldmethod=marker:foldlevel=0
