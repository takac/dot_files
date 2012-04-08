set t_Co=256

color molokai
cmap W w
cmap Q q
set history=700

set wrap
set linebreak

filetype plugin on
filetype indent on
"LATEX
let g:tex_flavor='latex'


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

set directory=$HOME/.vim/tmp
set backupdir=$HOME/.vim/backup
set clipboard+=unnamed "
set mouse=a " use mouse everywhere

set shiftwidth=4 " auto-indent amount when using cindent, 
" >>, << and stuff like that
set softtabstop=4 " when hitting tab or backspace, how many spaces 
"should a tab be (see expandtab)
set tabstop=4 " real tabs should be 8, and they will show with 

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
"x highlight current line
set cul                                          
set pastetoggle=<F2>


"" ABBREVATIONS ""
iabbrev env environment
iabbrev enviroment environment
iabbrev AL artificial life
iabbrev GPr genetic programming
iabbrev GAl genetic algorithm
iabbrev teh the
iabbrev adn and

""" CREAM ABBR """

iabbrev accesories accessories
iabbrev accomodate accommodate
iabbrev acheive achieve
iabbrev acheiving achieving
iabbrev acn can
iabbrev acommodate accommodate
iabbrev acomodate accommodate
iabbrev acommodated accommodated
iabbrev acomodated accommodated
iabbrev adn and
iabbrev agian again
iabbrev ahppen happen
iabbrev ahve have
iabbrev ahve have
iabbrev allready already
iabbrev almsot almost
iabbrev alos also
iabbrev alot a lot
iabbrev alreayd already
iabbrev alwasy always
iabbrev amke make
iabbrev anbd and
iabbrev andthe and the
iabbrev appeares appears
iabbrev aplyed applied
iabbrev artical article
iabbrev aslo also
iabbrev audeince audience
iabbrev audiance audience
iabbrev awya away
iabbrev bakc back
iabbrev balence balance
iabbrev baout about
iabbrev bcak back
iabbrev beacuse because
iabbrev becasue because
iabbrev becomeing becoming
iabbrev becuase because
iabbrev becuse because
iabbrev befoer before
iabbrev begining beginning
iabbrev beleive believe
iabbrev bianry binary
iabbrev bianries binaries
iabbrev boxs boxes
iabbrev bve be
iabbrev changeing changing
iabbrev charachter character
iabbrev charcter character
iabbrev charcters characters
iabbrev charecter character
iabbrev charector character
iabbrev cheif chief
iabbrev circut circuit
iabbrev claer clear
iabbrev claerly clearly
iabbrev cna can
iabbrev colection collection
iabbrev comany company
iabbrev comapny company
iabbrev comittee committee
iabbrev commitee committee
iabbrev committe committee
iabbrev committy committee
iabbrev compair compare
iabbrev compleated completed
iabbrev completly completely
iabbrev comunicate communicate
iabbrev comunity community
iabbrev conected connected
iabbrev cotten cotton
iabbrev coudl could
iabbrev cpoy copy
iabbrev cxan can
iabbrev danceing dancing
iabbrev definately definitely
iabbrev develope develop
iabbrev developement development
iabbrev differant different
iabbrev differnt different
iabbrev diffrent different
iabbrev disatisfied dissatisfied
iabbrev doese does
iabbrev doign doing
iabbrev doller dollars
iabbrev donig doing
iabbrev driveing driving
iabbrev drnik drink
iabbrev ehr her
iabbrev embarass embarrass
iabbrev equippment equipment
iabbrev esle else
iabbrev excitment excitement
iabbrev exmaple example
iabbrev exmaples examples
iabbrev eyt yet
iabbrev familar familiar
iabbrev feild field
iabbrev fianlly finally
iabbrev fidn find
iabbrev firts first
iabbrev follwo follow
iabbrev follwoing following
iabbrev foriegn foreign
iabbrev fro for
iabbrev foudn found
iabbrev foward forward
iabbrev freind friend
iabbrev frmo from
iabbrev fwe few
iabbrev gerat great
iabbrev geting getting
iabbrev giveing giving
iabbrev goign going
iabbrev gonig going
iabbrev govenment government
iabbrev gruop group
iabbrev grwo grow
iabbrev haev have
iabbrev happend happened
iabbrev haveing having
iabbrev hda had
iabbrev helpfull helpful
iabbrev herat heart
iabbrev hge he
iabbrev hismelf himself
iabbrev hsa has
iabbrev hsi his
iabbrev hte the
iabbrev htere there
iabbrev htey they
iabbrev hting thing
iabbrev htink think
iabbrev htis this
iabbrev hvae have
iabbrev hvaing having
iabbrev idae idea
iabbrev idaes ideas
iabbrev ihs his
iabbrev immediatly immediately
iabbrev indecate indicate
iabbrev insted intead
iabbrev inthe in the
iabbrev iwll will
iabbrev iwth with
iabbrev jsut just
iabbrev knwo know
iabbrev knwos knows
iabbrev konw know
iabbrev konws knows
iabbrev levle level
iabbrev libary library
iabbrev librarry library
iabbrev librery library
iabbrev librarry library
iabbrev liek like
iabbrev liekd liked
iabbrev liev live
iabbrev likly likely
iabbrev littel little
iabbrev liuke like
iabbrev liveing living
iabbrev loev love
iabbrev lonly lonely
iabbrev makeing making
iabbrev mkae make
iabbrev mkaes makes
iabbrev mkaing making
iabbrev moeny money
iabbrev mroe more
iabbrev mysefl myself
iabbrev myu my
iabbrev neccessary necessary
iabbrev necesary necessary
iabbrev nkow know
iabbrev nwe new
iabbrev nwo now
iabbrev ocasion occasion
iabbrev occassion occasion
iabbrev occurence occurrence
iabbrev occurrance occurrence
iabbrev ocur occur
iabbrev oging going
iabbrev ohter other
iabbrev omre more
iabbrev onyl only
iabbrev optoin option
iabbrev optoins options
iabbrev opperation operation
iabbrev orginized organized
iabbrev otehr other
iabbrev otu out
iabbrev owrk work
iabbrev peopel people
iabbrev perhasp perhaps
iabbrev perhpas perhaps
iabbrev pleasent pleasant
iabbrev poeple people
iabbrev porblem problem
iabbrev preceed precede
iabbrev preceeded preceded
iabbrev probelm problem
iabbrev protoge protege
iabbrev puting putting
iabbrev pwoer power
iabbrev quater quarter
iabbrev questoin question
iabbrev reccomend recommend
iabbrev reccommend recommend
iabbrev receieve receive
iabbrev recieve receive
iabbrev recieved received
iabbrev recomend recommend
iabbrev reconize recognize
iabbrev recrod record
iabbrev religous religious
iabbrev rwite write
iabbrev rythm rhythm
iabbrev seh she
iabbrev selectoin selection
iabbrev sentance sentence
iabbrev seperate separate
iabbrev shineing shining
iabbrev shiped shipped
iabbrev shoudl should
iabbrev similiar similar
iabbrev smae same
iabbrev smoe some
iabbrev soem some
iabbrev sohw show
iabbrev soudn sound
iabbrev soudns sounds
iabbrev statment statement
iabbrev stnad stand
iabbrev stopry story
iabbrev stoyr story
iabbrev stpo stop
iabbrev strentgh strength
iabbrev struggel struggle
iabbrev sucess success
iabbrev swiming swimming
iabbrev tahn than
iabbrev taht that
iabbrev talekd talked
iabbrev tath that
iabbrev teh the
iabbrev tehy they
iabbrev tghe the
iabbrev thansk thanks
iabbrev themselfs themselves
iabbrev theri their
iabbrev thgat that
iabbrev thge the
iabbrev thier their
iabbrev thme them
iabbrev thna than
iabbrev thne then
iabbrev thnig thing
iabbrev thnigs things
iabbrev thsi this
iabbrev thsoe those
iabbrev thta that
iabbrev tihs this
iabbrev timne time
iabbrev tje the
iabbrev tjhe the
iabbrev tkae take
iabbrev tkaes takes
iabbrev tkaing taking
iabbrev tlaking talking
iabbrev todya today
iabbrev tongiht tonight
iabbrev tonihgt tonight
iabbrev towrad toward
iabbrev tpyo typo
iabbrev truely truly
iabbrev tyhat that
iabbrev tyhe the
iabbrev useing using
iabbrev vacumme vacuum
iabbrev veyr very
iabbrev vrey very
iabbrev waht what
iabbrev watn want
iabbrev wehn when
iabbrev whcih which
iabbrev whic which
iabbrev whihc which
iabbrev whta what
iabbrev wief wife
iabbrev wierd weird
iabbrev wihch which
iabbrev wiht with
iabbrev windoes windows
iabbrev withe with
iabbrev wiull will
iabbrev wnat want
iabbrev wnated wanted
iabbrev wnats wants
iabbrev woh who
iabbrev wohle whole
iabbrev wokr work
iabbrev woudl would
iabbrev wriet write
iabbrev wrod word
iabbrev wroking working
iabbrev wtih with
iabbrev wya way
iabbrev yera year
iabbrev yeras years
iabbrev ytou you
iabbrev yuo you
iabbrev yuor your

" Days of weeks
iabbrev monday Monday
iabbrev tuesday Tuesday
iabbrev wednesday Wednesday
iabbrev thursday Thursday
iabbrev friday Friday
iabbrev saturday Saturday
iabbrev sunday Sunday

" Months
iabbrev january January
iabbrev february February
iabbrev march March
iabbrev april April
iabbrev june June
iabbrev july July  
iabbrev august August
iabbrev september September
iabbrev october October
iabbrev november November
iabbrev december December


