" Denton Elliott
" Vim Defaults {{{
set nocompatible
set noshowmode " hide default mode text (e.g. -- INSERT -- below the statusline)
set clipboard=unnamed
set virtualedit=all
set cpoptions+=$
" }}}
" Plugin Management {{{

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'https://github.com/mattn/webapi-vim.git'
Plug 'Quramy/vim-js-pretty-template'
Plug 'mxw/vim-jsx'
Plug 'ternjs/tern_for_vim'
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --tern-completer
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'

" Plug 'pangloss/vim-javascript'
" Plugin 'tpope/vim-rails'
" Plugin 'tpope/vim-dispatch'
" Plugin 'janko-m/vim-test'
" Plugin 'https://github.com/shmargum/vim-sass-colors.git'

 " Initialize plugin system
call plug#end()

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
set foldlevelstart=10    " start with fold level of 1
" }}}
" UltiSnips {{{
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
 
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
let g:UltiSnipsSnippetsDir='~/.vim/UltiSnips'
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'
" }}}
" Typescript settings {{{
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
autocmd FileType typescript JsPreTmpl html
autocmd FileType typescript syn clear foldBraces
" }}}
" Emmet settings {{{
let g:user_emmet_leader_key='<C-y>'
let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.vim/.snippets.json')), "\n"))
" }}}
" Color settings {{{
" let g:solarized_termcolors=256
set background=dark
" set background=light
" colorscheme solarized
" colorscheme molokai
colorscheme railscasts2
" colorscheme badwolf
" colorscheme goodwolf
" }}}
" Leader shortcuts {{{
let mapleader = " "

" edit this file by typing ','V
nnoremap <leader>V :e $MYVIMRC<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
" Initialise list by a word under cursor
nnoremap <leader>u :execute 'CtrlPFunky ' . expand('<cword>')<cr>
" turn off search highlight
nnoremap <leader>/ :nohlsearch<cr>
" hitting leader twice switches buffers
nnoremap <leader><leader> :bn<cr>

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <leader>r :! clear; ruby %<cr>

" Testing
nnoremap <silent> <leader>t :TestNearest<cr>
nnoremap <silent> <leader>T :TestFile<cr>
nnoremap <silent> <leader>a :TestSuite<cr>
nnoremap <silent> <leader>l :TestLast<cr>
nnoremap <silent> <leader>g :TestVisit<cr>

" }}}
" CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" Close NERDTree window
let g:ctrlp_dont_split = 'NERD'
"let g:ctrlp_max_files=0
"let g:ctrlp_max_depth=40
nnoremap <leader>f :CtrlPFunky<cr>
" }}}
"  Use ag for grep {{{
set grepprg=ag
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
"set scrolloff=0                     " keep a 5 line padding when moving the cursor

"HTML Editing
set matchpairs+=<:>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
" }}}
" Scrolling {{{
"set scrolloff=8         "Start scrolling when we're 8 lines away from margins
"set sidescrolloff=15
"set sidescroll=1
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

" Switch windows with control-<char> instead of control-w+<char>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"enable keyboard shortcuts
let g:tern_map_keys=1
"show argument hints
let g:tern_show_argument_hints='on_hold'

" }}}
" Display Hidden Chars {{{
set list          " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping
" }}}
" Autocmds {{{
autocmd FileType javascript set formatprg=prettier\ --stdin
" }}}
" vim:foldmethod=marker:foldlevel=0
