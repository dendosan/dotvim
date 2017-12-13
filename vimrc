" Denton Elliott
" Vim Defaults {{{
set nocompatible
set noshowmode          " hide default mode text (e.g. -- INSERT -- below the statusline)
set clipboard=unnamed   " yy, D, P, etc. work with system clipboard. No need to prefix them with "+ or "*.
set virtualedit=all     " cursor can travel to any space in buffer
set cpoptions+=$        " places $ at change position
" }}}
" Plugin Management {{{
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'altercation/vim-colors-solarized'
Plug 'trevordmiller/nova-vim'

" Plug 'sbdchd/neoformat'
" " {{{
" let g:neoformat_try_formatprg = 1
" " Enable alignment
" let g:neoformat_basic_format_align = 1
" " Enable tab to spaces conversion
" let g:neoformat_basic_format_retab = 1
" " Enable trimmming of trailing whitespace
" let g:neoformat_basic_format_trim = 1
" let g:neoformat_run_all_formatters = 1
" " }}}
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
" {{{
let g:javascript_plugin_flow=1 "Flow colors
" }}}
" Plug 'crusoexia/vim-javascript-lib'
" Plug 'Quramy/vim-js-pretty-template'
" Plug 'mxw/vim-jsx'
" " {{{
" " Allow JSX in normal JS files
" let g:jsx_ext_required = 0
" "}}}
Plug 'mattn/webapi-vim' " needed by emmet
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'qpkorr/vim-bufkill' " Use :BD to remove buffer and keep screen open

Plug 'vim-syntastic/syntastic' " error highlighting
Plug 'godlygeek/tabular'
" Plug 'ctrlpvim/ctrlp.vim'

" Initialize plugin system
call plug#end()
" }}}
" Leader Shortcuts {{{
let mapleader=","
nnoremap <leader>re :vsplit $MYVIMRC<cr>
nnoremap <leader>rs :source $MYVIMRC<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <silent> <Esc><Esc> :nohlsearch<cr>
nnoremap <leader><leader> :bn<cr>
nnoremap <leader>w :w!<cr>
" Leader C is the prefix for code related mappîngs
noremap <silent> <Leader>cc :TComment<cr>
" fzf config {{{
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

" nnoremap <leader>g :GFiles<cr>
nnoremap <leader>d :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>

nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>

nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Ag' selection
endfunction

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" }}}

"}}}
" Editor Config {{{
set noshowcmd           " no show command in bottom bar
set showmatch           " highlight matching [{()}]
set incsearch           " incremental search
set hlsearch            " highlight search
set ignorecase          " ignore case while searching

set shiftwidth=2
set softtabstop=2
set tabstop=2

" for html/rb/groovy/xml files, 2 spaces
autocmd filetype html setlocal ts=2 sw=2 expandtab
autocmd filetype ruby setlocal ts=2 sw=2 expandtab
autocmd filetype groovy setlocal ts=2 sw=2 expandtab
autocmd filetype xml setlocal ts=2 sw=2 expandtab

" augroup NeoformatAutoFormat
"   autocmd!
"   autocmd FileType javascript,javascript.jsx setlocal formatprg=prettier\
"         \--stdin\
"         \--print-width\ 80\
"         \--single-quote\
"         \--trailing-comma\ es5
"   autocmd BufWritePre *.js,*.jsx Neoformat
" augroup END

" for js/coffee/jade files, 4 spaces
autocmd filetype javascript,javascript.jsx setlocal ts=4 sw=4 sts=0 expandtab
autocmd filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd filetype jade setlocal ts=4 sw=4 sts=0 expandtab

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

nnoremap j gj
nnoremap k gk
" }}}
" Custom Mappings {{{
nnoremap Q !!$SHELL<CR>                  " Q runs current line as a shell program
nnoremap <leader>- ddp                   " move line down
nnoremap <leader>_ ddkP                  " move line up
inoremap <c-u> <esc>viwU<esc>eli
nnoremap <c-u> viwUel

" }}}
" Emmet settings {{{
let g:user_emmet_leader_key='<C-y>'
let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.vim/.snippets.json')), "\n"))
" }}}
" Color settings {{{
let g:solarized_contrast="high"
let g:solarized_termcolors=256
set termguicolors
set background=dark
" set background=light
" colorscheme nova
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
"let g:netrw_banner=0           " Disable annoying banner
" }}}
" Display Hidden Chars {{{
set list                        " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping
" set listchars=tab:>-,trail:~,extends:»,precedes:« " Unprintable chars mapping
" }}}
" Line Numbering {{{
" vim-numbertoggle - Automatic toggling between 'hybrid' and absolute line numbers
set nu
set rnu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if &nu | set nornu | endif
augroup END
" }}}
" Syntastic {{{
" set statusline+=%#warningmsg#                                   "syntastic
" set statusline+=%{SyntasticStatuslineFlag()}                    "syntastic
" set statusline+=%*                                              "syntastic
"
" let g:syntastic_always_populate_loc_list = 1                    "syntastic
" let g:syntastic_auto_loc_list = 1                               "syntastic
" let g:syntastic_check_on_open = 1                               "syntastic
" let g:syntastic_check_on_wq = 0                                 "syntastic
" let g:syntastic_javascript_checkers = ['eslint']                "syntastic
" }}}
" Tabular {{{

" Align on equal sign
vnoremap <silent> <Leader>cee    :Tabularize /=<CR>              "tabular
" Align on # sign (comment)
vnoremap <silent> <Leader>cet    :Tabularize /#<CR>              "tabular
" Align (no sign)
vnoremap <silent> <Leader>ce     :Tabularize /
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
