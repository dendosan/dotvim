execute pathogen#infect()
autocmd!
set nocompatible
set noshowmode

syntax on
filetype plugin indent on

set exrc

" Source the vimrc file after saving it
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

let mapleader = " "

" edit this file by typing 'space'V
nnoremap <leader>V :e $MYVIMRC<cr>

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

set ls=2                        " show a status line even if there's only one window

" Improve vim's scrolling speed
set ttyfast
set ttyscroll=3
set lazyredraw

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

" Lines with equal indent form a fold.
set foldmethod=indent
set foldlevel=1
set foldnestmax=10
" Open all folds by default
set nofoldenable

set undofile                    " Save undo's after file closes
set undodir=~/.vim/undo         " where to save undo histories
set undolevels=1000             " How many undos
set undoreload=10000            " number of lines to save for undo

set vb                          " disable alert sound
set showcmd                     " display incomplete commands
set history=100                 " a ton of history


" Whitespace
set tabstop=2 shiftwidth=2	    " a tab is two spaces
set expandtab			              " use spaces, not tabs

" Searching
set incsearch                       " incremental searching
set hlsearch                        " highlight the search
nnoremap <leader>/ :nohlsearch<CR>  " turn off search highlight
set ignorecase                      " searches are case insensitive...
set smartcase                       " ... unless they contain at least one capital letter
set scrolloff=0                     " keep a 5 line padding when moving the cursor

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

nnoremap <leader><leader> :b#<cr>     " hitting 'space' twice switches buffers

" Fast saving
nmap <leader>w :w!<cr>

function! Carousel()
	for theme in split(globpath(&runtimepath, 'colors/*.vim'), '\n')
		let t = fnamemodify(theme, ':t:r')
		try
			execute 'colorscheme '.t
			echo t
		catch
		finally
		endtry
		sleep 4
		redraw
	endfor
endfunction

map <silent> <Leader>tc :call Carousel()<cr>

