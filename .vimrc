set t_Co=256

set cursorcolumn " highlight the current column
set cursorline " highlight current line
set incsearch " BUT do highlight as you type you ^
set numberwidth=5 " We are good up to 99999 lines
set report=0 " tell us when anything is changed via :...
set ruler " Always show current positions along the bottom^
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

set noexrc " don't use local version of .(g)vimrc, .exrc
"set background=dark " we plan to use a dark background
set cpoptions=aABceFsmq

set nocompatible
set backspace=indent,eol,start
set backup
set backupdir=~/.vim/backup " where to put backup files
""set history=50""
set ruler
set background=dark
set showcmd
set incsearch
syntax on
set hlsearch

colorscheme monokai

filetype indent on


set history=1000  
set backup 						" backups are nice ...
set undofile					" so is persistent undo ...
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

set cursorline 

highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

set nu
set linebreak
set nowrap                     	" wrap long lines
set autoindent                 	" indent at the same level of the previous line
set shiftwidth=4               	" use indents of 4 spaces
set tabstop=4 					" an indentation every four columns
set softtabstop=4 				" let backspace delete indent
"set matchpairs+=<:>            	" match, to be used with % 
set pastetoggle=<F12>          	" pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
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

:cmap W w
:cmap Q q 
