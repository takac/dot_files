"Basic colouring and encoding
set t_Co=256
set encoding=utf-8

"Powerline config
set laststatus=2

"Vundle config
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'maksimr/vim-jsbeautify'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'SirVer/ultisnips'
Bundle 'Tabular'
Bundle 'VimClojure'
Bundle 'ack.vim'
Bundle 'chriskempson/base16-vim'
"Bundle 'git://git.wincent.com/command-t.git'
Bundle 'javacomplete'
Bundle 'kana/vim-smartinput'
Bundle 'majutsushi/tagbar'
Bundle 'peaksea'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'skammer/vim-css-color'
Bundle 'sudo.vim'
Bundle 'sukima/xmledit'
Bundle 'thinca/vim-quickrun.git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tsaleh/vim-matchit'
Bundle 'vim-scripts/scratch.vim'
Bundle 'vundle'

"Basic functionality
filetype plugin on
filetype indent on
syntax on

"Set colours and fonts
if has("gui_running")
	set background=dark
	color base16-tomorrow
	if has("gui_macvim")
		set guifont=Inconsolata:h17
	elseif has("gui_gtk2")
		set guifont=Inconsolata\ 13
	elseif has("gui_win32") || has("gui_win64")
		set guifont=Consolas:h11:cANSI
	endif
else
	set background=dark
	color peaksea
endif

set number
"set relativenumber
"au FocusLost * :set number
"au FocusGained * :set relativenumber
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber

"Easy motion config
let g:EasyMotion_leader_key = '<Space>'
hi EasyMotionTargetDefault cterm=bold ctermfg=196 gui=bold guifg=#ff0000

set pastetoggle=<F12>               " pastetoggle (sane indentation on pastes)

"VimClojure config
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1
"Set cross system compatibility
if has("unix")
	let s:uname = system("uname")
	if s:uname == "Darwin\n"
		set pastetoggle=<leader>p          	" pastetoggle (sane indentation on pastes)
		let g:Powerline_symbols = 'compatible'
		let mapleader="§"
	else
		let g:Powerline_symbols = 'fancy'
	endif
endif


"expand local path
cabbr <expr> %% expand('%:p:h')

" FIXME - make cross platform.
" Ack-grep plugin
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

nnoremap <leader>e :tabe ~/.vimrc<CR>
nnoremap <leader>l :set list!<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>te :tabedit
nnoremap <leader>tm :tabmove
nnoremap <leader>tn :tabnew<CR>
nnoremap <silent> <F1> :bn<CR>
nnoremap <silent> <F2> :bp<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <F4> :set hlsearch!<CR>
nnoremap <silent> <leader><CR> :set hlsearch!<CR>
nnoremap <silent> <F7> :set spell!<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <leader>w :w<CR>


vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Use current selection for Acking all files in cwd
vnoremap <silent> <leader>a :<C-U>let @/=GetVisual()<CR> :set hls<CR>:Ack "<C-R>/"<CR>
nnoremap <silent> <leader>a :let @/='<C-R>=expand("<cword>")<CR>'<CR>:Ack <cword><CR>:set hls<CR>

" Windows/Mac like behaviour, delete whole word
inoremap <C-Backspace> <C-O>cb
" Don't like this mapping at all..
nnoremap <C-Backspace> ldb

" Put word under cursor into search register and highlight
nnoremap <silent> * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
" magic stuff... to search using visual selection
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy:let @/=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>:set hls<CR>

" Useful location list search. Find current word in buffer and populate
" location list and show location list. To close location list use :lcl[ose]
nnoremap <silent> <leader>f :<C-U>call setloclist(".", [])<CR>
	\:g/<C-R>=expand("<cword>")<CR>/laddexpr expand("%") .
	\ ":" . line(".") .  ":" . getline(".")<CR>
	\:lw<CR>
    \:exec "nnoremap <silent> <buffer> q :lcl<CR>"
" Use visual selection for search
vnoremap <silent> <leader>f :normal *<CR>
	\:g/<C-R>//laddexpr expand("%") .
	\ ":" . line(".") .  ":" . getline(".")<CR>
	\:lw<CR>
    \:nnoremap <silent> <buffer> q :lcl<CR>

" like normal % but for quote marks
nnoremap <leader>% :call MatchQuote()<CR>

set foldmethod=expr
" Usually editing java.. so hide the imports
set foldexpr=HideImportFold(v:lnum)

function! HideImportFold(lnum)
	if getline(a:lnum) =~ '^import'
		return '1'
	endif
	if getline(a:lnum) =~ '\v^\s*$'
		return '-1'
	endif
	return '0'
endfunction

nnoremap <leader>Z :setlocal foldexpr=(getline(v:lnum)=~@/)?1:0 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
nnoremap <leader>z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" Map q to close a quickfix buffer, no need for macros in qf anyway

function! GetVisual() range
        let reg_save = getreg('"')
        let regtype_save = getregtype('"')
        let cb_save = &clipboard
        set clipboard&
        normal! ""gvy
        let selection = getreg('"')
        call setreg('"', reg_save, regtype_save)
        let &clipboard = cb_save
        return selection
endfunction

autocmd! BufEnter .vimrc nnoremap <leader>b gg/Bundle<CR>OBundle '<C-R>+'<ESC>:let @/="<C-R>=escape(getline("."), '/\.*$^~[')<CR>"<CR>vip:sor<CR>:w<CR>:BundleInstall<CR>q

" Move to matching " or ' a lot like %
fun! MatchQuote()
	let cur_char = getline(".")[col('.')-1]
	let begin = getpos(".")
	if cur_char  != '"' && cur_char != "'"
		"If quote not under cursor.. look forward for it
		echo "no quote.." . cur_char
		exec "norm f'"
		let s_pos_1 = getpos(".")
		call setpos(".", begin)
		exec 'norm f"'
		let s_pos_2 = getpos(".")
		call setpos(".", begin)
		" if quote not found forward.. look back
		if s_pos_1 == begin && s_pos_2 == begin
			exec "norm F'"
			let s_pos_1 = getpos(".")
			call setpos(".", begin)
			exec 'norm F"'
			let s_pos_2 = getpos(".")
			call setpos(".", begin)
			if s_pos_1 == begin && s_pos_2 == begin
				echo "no quotes found"
				return
			endif
		endif
		if s_pos_1 == begin
			call setpos(".", s_pos_2)
			return
		endif
		call setpos(".", s_pos_1)
		return
	endif
	exec "norm vi" . cur_char . "\<ESC>l"
	let end = getpos(".")
	exec "norm vi" . cur_char . "o\<ESC>h"
	let first = getpos(".")
	if begin == first
		call setpos(".", end)
	else
		call setpos(".", first)
	endif
endf
 
" When vimrc is edited, reload it and fix powerline colorscheme
autocmd! bufwritepost .vimrc call RestartVim()
if !exists("*RestartVim")
	fun! RestartVim()
		source ~/.vimrc
		:PowerlineReloadColorscheme
	endf
endif

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

"Fugitive
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>

" It's 2012.
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Don't move on *
nnoremap * *<c-o>
" Show the stack of syntax hilighting classes affecting whatever is under the
" cursor.
function! SynStack()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc

nnoremap <leader>s :call SynStack()<CR>

"magic capitilisation
inoremap <C-U> <esc>mzg~iw`za
" Resize splits when the window is resized
au VimResized * :wincmd =
" When vimrc is edited, reload it
autocmd! bufwritepost .*vimrc source ~/.vimrc

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

"fix mistype :W and :Q
command! -bang -range=% -complete=file -nargs=* WQ <line1>,<line2>wq<bang> <args>
command! -bang -range=% -complete=file -nargs=* Wq <line1>,<line2>wq<bang> <args>
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>w<bang> <args>
command! -bang Q quit<bang>

let g:UltiSnipsSnippetsDir = '~/.vim/bundle/ultisnips/UltiSnips'
set runtimepath+=~/.vim/bundle/ultisnips/UltiSnips
let g:UltiSnipsEditSplit = 'vertical'

let NERDSpaceDelims=1

set path+=~/git/web_secure_connect/src/**
set tags+=~/git/web_secure_connect/tags
set tags+=~/.tags

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set mouse=a " use mouse everywhere
"set ttymouse=xterm2     " necessary for gnu screen & mouse

set autoindent                      " indent at the same level of the previous line
set backspace=eol,start,indent
set backup                          " backups are nice ...
set backupdir=~/.vim/backup//
set clipboard+=unnamed              "
set cmdheight=2                     " The commandbar height
set cpoptions=aABceFsmq
"set cursorcolumn                    " highlight the current column
set cursorline                      " highlight current line :set cul
set directory=~/.vim/tmp//
set hid                             " Change buffer - without saving
set history=1000
set hlsearch                        " Highlight search things
set ignorecase                      " Ignore case when searching
set incsearch                       " Make search act like search in modern browsers
set linebreak
set listchars=tab:▸\ ,eol:¬,trail:●,extends:❯,precedes:❮
"set list
set magic                           " Set magic on, for regular expressions
set mat=2                           " How many tenths of a second to blink
set noerrorbells                    " No sound on errors
set noexrc                          " don't use local version of .(g)vimrc, .exrc
set nolazyredraw                    " Don't redraw while executing macros
set novisualbell
set nowrap                          " wrap long lines
"set nu
set numberwidth=5                   " We are good up to 99999 lines
set report=0                        " tell us when anything is changed via :...
"set vb
set ruler                           " Always show current positions along the bottom^
set shiftwidth=4                    " auto-indent amount when using cindent,
set showcmd
set showmatch                       " Show matching bracets when text indicator is over them
set smartcase                       " use smartcase searching
set scrolloff=7                            " Minimal number of screen lines to keep above and below the cursor.
set softtabstop=4                   " when hitting tab or backspace, how many spaces
set t_vb=
set tabstop=4                       " an indentation every four columns
set tabstop=4                       " real tabs should be 8, and they will show with
set tm=2500
set undodir=~/.vim/undo//             " where to save undo histories
set undofile                        " so is persistent undo ...
set undolevels=1000                 " How many undos
set undoreload=10000                " maximum number lines to save for undo on a buffer reload
set viminfo='10,\"100,:20,%,n~/.viminfo
set whichwrap+=<,>,h,l
set wildmenu                        " Turn on WiLd menu
set matchpairs+=<:>            	" match, to be used with %
"set guicursor+=i:blinkwait10
"set guicursor+=i:ver100-iCursor
"set guicursor+=n-v-c:blinkon0
"set guicursor=n-v-c:block-Cursor
"
set guicursor=n-c:block-Cursor-blinkon0
set guicursor+=v:block-vCursor-blinkon0
set guicursor+=i:ci-ver20-iCursor
highlight iCursor guifg=white guibg=white
" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif


"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

"set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" Tell vim to remember certain things when we exit
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END

"" ABBREVATIONS ""
iabbrev env environment
iabbrev enviroment environment
iabbrev AL artificial life
iabbrev GPr genetic programming
iabbrev GAl genetic algorithm
iabbrev adn and
"
""" CREAM ABBR """

iabbrev accesories accessories
iabbrev Accesories Accessories
iabbrev accomodate accommodate
iabbrev Accomodate Accommodate
iabbrev acheive achieve
iabbrev Acheive Achieve
iabbrev acheiving achieving
iabbrev Acheiving Achieving
iabbrev acn can
iabbrev Acn Can
iabbrev acommodate accommodate
iabbrev Acommodate Accommodate
iabbrev acomodate accommodate
iabbrev Acomodate Accommodate
iabbrev acommodated accommodated
iabbrev Acommodated Accommodated
iabbrev acomodated accommodated
iabbrev Acomodated Accommodated
iabbrev adn and
iabbrev Adn And
iabbrev agian again
iabbrev Agian Again
iabbrev ahppen happen
iabbrev Ahppen Happen
iabbrev ahve have
iabbrev Ahve Have
iabbrev allready already
iabbrev Allready Already
iabbrev almsot almost
iabbrev Almsot Almost
iabbrev alos also
iabbrev Alos Also
iabbrev alot a lot
iabbrev Alot A lot
iabbrev alreayd already
iabbrev Alreayd Already
iabbrev alwasy always
iabbrev Alwasy Always
iabbrev amke make
iabbrev Amke Make
iabbrev anbd and
iabbrev Anbd And
iabbrev andthe and the
iabbrev Andthe And the
iabbrev appeares appears
iabbrev Appeares Appears
iabbrev aplyed applied
iabbrev Aplyed Applied
iabbrev artical article
iabbrev Artical Article
iabbrev aslo also
iabbrev Aslo Also
iabbrev audeince audience
iabbrev Audeince Audience
iabbrev audiance audience
iabbrev Audiance Audience
iabbrev awya away
iabbrev Awya Away
iabbrev bakc back
iabbrev Bakc Back
iabbrev balence balance
iabbrev Balence Balance
iabbrev baout about
iabbrev Baout About
iabbrev bcak back
iabbrev Bcak Back
iabbrev beacuse because
iabbrev Beacuse Because
iabbrev becasue because
iabbrev Becasue Because
iabbrev becomeing becoming
iabbrev Becomeing Becoming
iabbrev becuase because
iabbrev Becuase Because
iabbrev becuse because
iabbrev Becuse Because
iabbrev befoer before
iabbrev Befoer Before
iabbrev begining beginning
iabbrev Begining Beginning
iabbrev beleive believe
iabbrev Beleive Believe
iabbrev bianry binary
iabbrev Bianry Binary
iabbrev bianries binaries
iabbrev Bianries Binaries
iabbrev boxs boxes
iabbrev Boxs Boxes
iabbrev bve be
iabbrev Bve Be
iabbrev changeing changing
iabbrev Changeing Changing
iabbrev charachter character
iabbrev Charachter Character
iabbrev charcter character
iabbrev Charcter Character
iabbrev charcters characters
iabbrev Charcters Characters
iabbrev charecter character
iabbrev Charecter Character
iabbrev charector character
iabbrev Charector Character
iabbrev cheif chief
iabbrev Cheif Chief
iabbrev circut circuit
iabbrev Circut Circuit
iabbrev claer clear
iabbrev Claer Clear
iabbrev claerly clearly
iabbrev Claerly Clearly
iabbrev cna can
iabbrev Cna Can
iabbrev colection collection
iabbrev Colection Collection
iabbrev comany company
iabbrev Comany Company
iabbrev comapny company
iabbrev Comapny Company
iabbrev comittee committee
iabbrev Comittee Committee
iabbrev commitee committee
iabbrev Commitee Committee
iabbrev committe committee
iabbrev Committe Committee
iabbrev committy committee
iabbrev Committy Committee
iabbrev compair compare
iabbrev Compair Compare
iabbrev compleated completed
iabbrev Compleated Completed
iabbrev completly completely
iabbrev Completly Completely
iabbrev comunicate communicate
iabbrev Comunicate Communicate
iabbrev comunity community
iabbrev Comunity Community
iabbrev conected connected
iabbrev Conected Connected
iabbrev cotten cotton
iabbrev Cotten Cotton
iabbrev coudl could
iabbrev Coudl Could
iabbrev cpoy copy
iabbrev Cpoy Copy
iabbrev cxan can
iabbrev Cxan Can
iabbrev danceing dancing
iabbrev Danceing Dancing
iabbrev definately definitely
iabbrev Definately Definitely
iabbrev develope develop
iabbrev Develope Develop
iabbrev developement development
iabbrev Developement Development
iabbrev differant different
iabbrev Differant Different
iabbrev differnt different
iabbrev Differnt Different
iabbrev diffrent different
iabbrev Diffrent Different
iabbrev disatisfied dissatisfied
iabbrev Disatisfied Dissatisfied
iabbrev doese does
iabbrev Doese Does
iabbrev doign doing
iabbrev Doign Doing
iabbrev doller dollars
iabbrev Doller Dollars
iabbrev donig doing
iabbrev Donig Doing
iabbrev driveing driving
iabbrev Driveing Driving
iabbrev drnik drink
iabbrev Drnik Drink
iabbrev ehr her
iabbrev Ehr Her
iabbrev embarass embarrass
iabbrev Embarass Embarrass
iabbrev equippment equipment
iabbrev Equippment Equipment
iabbrev esle else
iabbrev Esle Else
iabbrev excitment excitement
iabbrev Excitment Excitement
iabbrev exmaple example
iabbrev Exmaple Example
iabbrev exmaples examples
iabbrev Exmaples Examples
iabbrev eyt yet
iabbrev Eyt Yet
iabbrev familar familiar
iabbrev Familar Familiar
iabbrev feild field
iabbrev Feild Field
iabbrev fianlly finally
iabbrev Fianlly Finally
iabbrev fidn find
iabbrev Fidn Find
iabbrev firts first
iabbrev Firts First
iabbrev follwo follow
iabbrev Follwo Follow
iabbrev follwoing following
iabbrev Follwoing Following
iabbrev foriegn foreign
iabbrev Foriegn Foreign
iabbrev fro for
iabbrev Fro For
iabbrev foudn found
iabbrev Foudn Found
iabbrev foward forward
iabbrev Foward Forward
iabbrev freind friend
iabbrev Freind Friend
iabbrev frmo from
iabbrev Frmo From
iabbrev fwe few
iabbrev Fwe Few
iabbrev gerat great
iabbrev Gerat Great
iabbrev geting getting
iabbrev Geting Getting
iabbrev giveing giving
iabbrev Giveing Giving
iabbrev goign going
iabbrev Goign Going
iabbrev gonig going
iabbrev Gonig Going
iabbrev govenment government
iabbrev Govenment Government
iabbrev gruop group
iabbrev Gruop Group
iabbrev grwo grow
iabbrev Grwo Grow
iabbrev haev have
iabbrev Haev Have
iabbrev happend happened
iabbrev Happend Happened
iabbrev haveing having
iabbrev Haveing Having
iabbrev hda had
iabbrev Hda Had
iabbrev helpfull helpful
iabbrev Helpfull Helpful
iabbrev herat heart
iabbrev Herat Heart
iabbrev hge he
iabbrev Hge He
iabbrev hismelf himself
iabbrev Hismelf Himself
iabbrev hsa has
iabbrev Hsa Has
iabbrev hsi his
iabbrev Hsi His
iabbrev hte the
iabbrev Hte The
iabbrev htere there
iabbrev Htere There
iabbrev htey they
iabbrev Htey They
iabbrev hting thing
iabbrev Hting Thing
iabbrev htink think
iabbrev Htink Think
iabbrev htis this
iabbrev Htis This
iabbrev hvae have
iabbrev Hvae Have
iabbrev hvaing having
iabbrev Hvaing Having
iabbrev idae idea
iabbrev Idae Idea
iabbrev idaes ideas
iabbrev Idaes Ideas
iabbrev ihs his
iabbrev Ihs His
iabbrev immediatly immediately
iabbrev Immediatly Immediately
iabbrev indecate indicate
iabbrev Indecate Indicate
iabbrev insted intead
iabbrev Insted Intead
iabbrev inthe in the
iabbrev Inthe In the
iabbrev iwll will
iabbrev Iwll Will
iabbrev iwth with
iabbrev Iwth With
iabbrev jsut just
iabbrev Jsut Just
iabbrev knwo know
iabbrev Knwo Know
iabbrev knwos knows
iabbrev Knwos Knows
iabbrev konw know
iabbrev Konw Know
iabbrev konws knows
iabbrev Konws Knows
iabbrev levle level
iabbrev Levle Level
iabbrev libary library
iabbrev Libary Library
iabbrev librarry library
iabbrev Librarry Library
iabbrev librery library
iabbrev Librery Library
iabbrev librarry library
iabbrev Librarry Library
iabbrev liek like
iabbrev Liek Like
iabbrev liekd liked
iabbrev Liekd Liked
iabbrev liev live
iabbrev Liev Live
iabbrev likly likely
iabbrev Likly Likely
iabbrev littel little
iabbrev Littel Little
iabbrev liuke like
iabbrev Liuke Like
iabbrev liveing living
iabbrev Liveing Living
iabbrev loev love
iabbrev Loev Love
iabbrev lonly lonely
iabbrev Lonly Lonely
iabbrev makeing making
iabbrev Makeing Making
iabbrev mkae make
iabbrev Mkae Make
iabbrev mkaes makes
iabbrev Mkaes Makes
iabbrev mkaing making
iabbrev Mkaing Making
iabbrev moeny money
iabbrev Moeny Money
iabbrev mroe more
iabbrev Mroe More
iabbrev mysefl myself
iabbrev Mysefl Myself
iabbrev myu my
iabbrev Myu My
iabbrev neccessary necessary
iabbrev Neccessary Necessary
iabbrev necesary necessary
iabbrev Necesary Necessary
iabbrev nkow know
iabbrev Nkow Know
iabbrev nwe new
iabbrev Nwe New
iabbrev nwo now
iabbrev Nwo Now
iabbrev ocasion occasion
iabbrev Ocasion Occasion
iabbrev occassion occasion
iabbrev Occassion Occasion
iabbrev occurence occurrence
iabbrev Occurence Occurrence
iabbrev occurrance occurrence
iabbrev Occurrance Occurrence
iabbrev ocur occur
iabbrev Ocur Occur
iabbrev oging going
iabbrev Oging Going
iabbrev ohter other
iabbrev Ohter Other
iabbrev omre more
iabbrev Omre More
iabbrev onyl only
iabbrev Onyl Only
iabbrev optoin option
iabbrev Optoin Option
iabbrev optoins options
iabbrev Optoins Options
iabbrev opperation operation
iabbrev Opperation Operation
iabbrev orginized organized
iabbrev Orginized Organized
iabbrev otehr other
iabbrev Otehr Other
iabbrev otu out
iabbrev Otu Out
iabbrev owrk work
iabbrev Owrk Work
iabbrev peopel people
iabbrev Peopel People
iabbrev perhasp perhaps
iabbrev Perhasp Perhaps
iabbrev perhpas perhaps
iabbrev Perhpas Perhaps
iabbrev pleasent pleasant
iabbrev Pleasent Pleasant
iabbrev poeple people
iabbrev Poeple People
iabbrev porblem problem
iabbrev Porblem Problem
iabbrev preceed precede
iabbrev Preceed Precede
iabbrev preceeded preceded
iabbrev Preceeded Preceded
iabbrev probelm problem
iabbrev Probelm Problem
iabbrev protoge protege
iabbrev Protoge Protege
iabbrev puting putting
iabbrev Puting Putting
iabbrev pwoer power
iabbrev Pwoer Power
iabbrev quater quarter
iabbrev Quater Quarter
iabbrev questoin question
iabbrev Questoin Question
iabbrev reccomend recommend
iabbrev Reccomend Recommend
iabbrev reccommend recommend
iabbrev Reccommend Recommend
iabbrev receieve receive
iabbrev Receieve Receive
iabbrev recieve receive
iabbrev Recieve Receive
iabbrev recieved received
iabbrev Recieved Received
iabbrev recomend recommend
iabbrev Recomend Recommend
iabbrev reconize recognize
iabbrev Reconize Recognize
iabbrev recrod record
iabbrev Recrod Record
iabbrev religous religious
iabbrev Religous Religious
iabbrev rwite write
iabbrev Rwite Write
iabbrev rythm rhythm
iabbrev Rythm Rhythm
iabbrev seh she
iabbrev Seh She
iabbrev selectoin selection
iabbrev Selectoin Selection
iabbrev sentance sentence
iabbrev Sentance Sentence
iabbrev seperate separate
iabbrev Seperate Separate
iabbrev shineing shining
iabbrev Shineing Shining
iabbrev shiped shipped
iabbrev Shiped Shipped
iabbrev shoudl should
iabbrev Shoudl Should
iabbrev similiar similar
iabbrev Similiar Similar
iabbrev smae same
iabbrev Smae Same
iabbrev smoe some
iabbrev Smoe Some
iabbrev soem some
iabbrev Soem Some
iabbrev sohw show
iabbrev Sohw Show
iabbrev soudn sound
iabbrev Soudn Sound
iabbrev soudns sounds
iabbrev Soudns Sounds
iabbrev statment statement
iabbrev Statment Statement
iabbrev stnad stand
iabbrev Stnad Stand
iabbrev stopry story
iabbrev Stopry Story
iabbrev stoyr story
iabbrev Stoyr Story
iabbrev stpo stop
iabbrev Stpo Stop
iabbrev strentgh strength
iabbrev Strentgh Strength
iabbrev struggel struggle
iabbrev Struggel Struggle
iabbrev sucess success
iabbrev Sucess Success
iabbrev swiming swimming
iabbrev Swiming Swimming
iabbrev tahn than
iabbrev Tahn Than
iabbrev taht that
iabbrev Taht That
iabbrev talekd talked
iabbrev Talekd Talked
iabbrev tath that
iabbrev Tath That
iabbrev teh the
iabbrev Teh The
iabbrev tehy they
iabbrev Tehy They
iabbrev tghe the
iabbrev Tghe The
iabbrev thansk thanks
iabbrev Thansk Thanks
iabbrev themselfs themselves
iabbrev Themselfs Themselves
iabbrev theri their
iabbrev Theri Their
iabbrev thgat that
iabbrev Thgat That
iabbrev thge the
iabbrev Thge The
iabbrev thier their
iabbrev Thier Their
iabbrev thme them
iabbrev Thme Them
iabbrev thna than
iabbrev Thna Than
iabbrev thne then
iabbrev Thne Then
iabbrev thnig thing
iabbrev Thnig Thing
iabbrev thnigs things
iabbrev Thnigs Things
iabbrev thsi this
iabbrev Thsi This
iabbrev thsoe those
iabbrev Thsoe Those
iabbrev thta that
iabbrev Thta That
iabbrev tihs this
iabbrev Tihs This
iabbrev timne time
iabbrev Timne Time
iabbrev tje the
iabbrev Tje The
iabbrev tjhe the
iabbrev Tjhe The
iabbrev tkae take
iabbrev Tkae Take
iabbrev tkaes takes
iabbrev Tkaes Takes
iabbrev tkaing taking
iabbrev Tkaing Taking
iabbrev tlaking talking
iabbrev Tlaking Talking
iabbrev todya today
iabbrev Todya Today
iabbrev tongiht tonight
iabbrev Tongiht Tonight
iabbrev tonihgt tonight
iabbrev Tonihgt Tonight
iabbrev towrad toward
iabbrev Towrad Toward
iabbrev tpyo typo
iabbrev Tpyo Typo
iabbrev truely truly
iabbrev Truely Truly
iabbrev tyhat that
iabbrev Tyhat That
iabbrev tyhe the
iabbrev Tyhe The
iabbrev useing using
iabbrev Useing Using
iabbrev vacumme vacuum
iabbrev Vacumme Vacuum
iabbrev veyr very
iabbrev Veyr Very
iabbrev vrey very
iabbrev Vrey Very
iabbrev waht what
iabbrev Waht What
iabbrev watn want
iabbrev Watn Want
iabbrev wehn when
iabbrev Wehn When
iabbrev whcih which
iabbrev Whcih Which
iabbrev whic which
iabbrev Whic Which
iabbrev whihc which
iabbrev Whihc Which
iabbrev whta what
iabbrev Whta What
iabbrev wief wife
iabbrev Wief Wife
iabbrev wierd weird
iabbrev Wierd Weird
iabbrev wihch which
iabbrev Wihch Which
iabbrev wiht with
iabbrev Wiht With
iabbrev windoes windows
iabbrev Windoes Windows
iabbrev withe with
iabbrev Withe With
iabbrev wiull will
iabbrev Wiull Will
iabbrev wnat want
iabbrev Wnat Want
iabbrev wnated wanted
iabbrev Wnated Wanted
iabbrev wnats wants
iabbrev Wnats Wants
iabbrev woh who
iabbrev Woh Who
iabbrev wohle whole
iabbrev Wohle Whole
iabbrev wokr work
iabbrev Wokr Work
iabbrev woudl would
iabbrev Woudl Would
iabbrev wriet write
iabbrev Wriet Write
iabbrev wrod word
iabbrev Wrod Word
iabbrev wroking working
iabbrev Wroking Working
iabbrev wtih with
iabbrev Wtih With
iabbrev wya way
iabbrev Wya Way
iabbrev yera year
iabbrev Yera Year
iabbrev yeras years
iabbrev Yeras Years
iabbrev ytou you
iabbrev Ytou You
iabbrev yuo you
iabbrev Yuo You
iabbrev yuor your
iabbrev Yuor Your

" Days of weeks
iabbrev monday Monday
iabbrev Monday Monday
iabbrev tuesday Tuesday
iabbrev Tuesday Tuesday
iabbrev wednesday Wednesday
iabbrev Wednesday Wednesday
iabbrev thursday Thursday
iabbrev Thursday Thursday
iabbrev friday Friday
iabbrev Friday Friday
iabbrev saturday Saturday
iabbrev Saturday Saturday
iabbrev sunday Sunday
iabbrev Sunday Sunday

" Months
iabbrev january January
iabbrev January January
iabbrev february February
iabbrev February February
iabbrev march March
iabbrev March March
iabbrev april April
iabbrev April April
iabbrev june June
iabbrev June June
iabbrev july July
iabbrev July July
iabbrev august August
iabbrev August August
iabbrev september September
iabbrev September September
iabbrev october October
iabbrev October October
iabbrev november November
iabbrev November November
iabbrev december December
iabbrev December December

