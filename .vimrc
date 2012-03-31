colorscheme molokai
set t_Co=256
:cmap W w
:cmap Q q
set history=700

filetype plugin on
filetype indent on

" Fast editing of the .vimrc
map <leader>e :e! ~/.vim_runtime/vimrc<cr>
  
" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

"No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

set backspace=indent,eol,start
set backup
set directory=~/.vim/tmp
set backupdir=~/.vim/backup
set clipboard+=unnamed "
set mouse=a " use mouse everywhere

set shiftwidth=4 " auto-indent amount when using cindent, 
" >>, << and stuff like that
set softtabstop=4 " when hitting tab or backspace, how many spaces 
"should a tab be (see expandtab)
set tabstop=4 " real tabs should be 8, and they will show with 

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END


"x highlight current line
set cul                                          
" adjust color
hi CursorLine term=none cterm=none ctermbg=2      
