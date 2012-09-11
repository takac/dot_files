set t_Co=256

color Tomorrow-Night

cmap W w
cmap Q q

"Ack-grep plugin
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
"NerdTree shortcut
map <leader>nt :NERDTreeToggle<CR>
:noremap <F3> :NERDTreeToggle<CR>

:noremap <F4> :set hlsearch! hlsearch?<CR>

filetype plugin on
filetype indent on
"LATEX
let g:tex_flavor='latex'


" Fast editing of the .vimrc
map <leader>e :tabe ~/.vimrc<cr>
" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

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

set directory=$HOME/.vim/tmp
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
set backupdir=$HOME/.vim/backup
set showcmd
syntax on
set hlsearch

set history=1000  

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

"x highlight current line
set cul                                          


"" ABBREVATIONS ""
ab env environment
ab enviroment environment
ab AL artificial life
ab GPr genetic programming
ab GAl genetic algorithm
ab adn and
"
""" CREAM ABBR """

ab accesories accessories
ab accomodate accommodate
ab acheive achieve
ab acheiving achieving
ab acn can
ab acommodate accommodate
ab acomodate accommodate
ab acommodated accommodated
ab acomodated accommodated
ab adn and
ab agian again
ab ahppen happen
ab ahve have
ab allready already
ab almsot almost
ab alos also
ab alot a lot
ab alreayd already
ab alwasy always
ab amke make
ab anbd and
ab andthe and the
ab appeares appears
ab aplyed applied
ab artical article
ab aslo also
ab audeince audience
ab audiance audience
ab awya away
ab bakc back
ab balence balance
ab baout about
ab bcak back
ab beacuse because
ab becasue because
ab becomeing becoming
ab becuase because
ab becuse because
ab befoer before
ab begining beginning
ab beleive believe
ab bianry binary
ab bianries binaries
ab boxs boxes
ab bve be
ab changeing changing
ab charachter character
ab charcter character
ab charcters characters
ab charecter character
ab charector character
ab cheif chief
ab circut circuit
ab claer clear
ab claerly clearly
ab cna can
ab colection collection
ab comany company
ab comapny company
ab comittee committee
ab commitee committee
ab committe committee
ab committy committee
ab compair compare
ab compleated completed
ab completly completely
ab comunicate communicate
ab comunity community
ab conected connected
ab cotten cotton
ab coudl could
ab cpoy copy
ab cxan can
ab danceing dancing
ab definately definitely
ab develope develop
ab developement development
ab differant different
ab differnt different
ab diffrent different
ab disatisfied dissatisfied
ab doese does
ab doign doing
ab doller dollars
ab donig doing
ab driveing driving
ab drnik drink
ab ehr her
ab embarass embarrass
ab equippment equipment
ab esle else
ab excitment excitement
ab exmaple example
ab exmaples examples
ab eyt yet
ab familar familiar
ab feild field
ab fianlly finally
ab fidn find
ab firts first
ab follwo follow
ab follwoing following
ab foriegn foreign
ab fro for
ab foudn found
ab foward forward
ab freind friend
ab frmo from
ab fwe few
ab gerat great
ab geting getting
ab giveing giving
ab goign going
ab gonig going
ab govenment government
ab gruop group
ab grwo grow
ab haev have
ab happend happened
ab haveing having
ab hda had
ab helpfull helpful
ab herat heart
ab hge he
ab hismelf himself
ab hsa has
ab hsi his
ab hte the
ab htere there
ab htey they
ab hting thing
ab htink think
ab htis this
ab hvae have
ab hvaing having
ab idae idea
ab idaes ideas
ab ihs his
ab immediatly immediately
ab indecate indicate
ab insted intead
ab inthe in the
ab iwll will
ab iwth with
ab jsut just
ab knwo know
ab knwos knows
ab konw know
ab konws knows
ab levle level
ab libary library
ab librarry library
ab librery library
ab librarry library
ab liek like
ab liekd liked
ab liev live
ab likly likely
ab littel little
ab liuke like
ab liveing living
ab loev love
ab lonly lonely
ab makeing making
ab mkae make
ab mkaes makes
ab mkaing making
ab moeny money
ab mroe more
ab mysefl myself
ab myu my
ab neccessary necessary
ab necesary necessary
ab nkow know
ab nwe new
ab nwo now
ab ocasion occasion
ab occassion occasion
ab occurence occurrence
ab occurrance occurrence
ab ocur occur
ab oging going
ab ohter other
ab omre more
ab onyl only
ab optoin option
ab optoins options
ab opperation operation
ab orginized organized
ab otehr other
ab otu out
ab owrk work
ab peopel people
ab perhasp perhaps
ab perhpas perhaps
ab pleasent pleasant
ab poeple people
ab porblem problem
ab preceed precede
ab preceeded preceded
ab probelm problem
ab protoge protege
ab puting putting
ab pwoer power
ab quater quarter
ab questoin question
ab reccomend recommend
ab reccommend recommend
ab receieve receive
ab recieve receive
ab recieved received
ab recomend recommend
ab reconize recognize
ab recrod record
ab religous religious
ab rwite write
ab rythm rhythm
ab seh she
ab selectoin selection
ab sentance sentence
ab seperate separate
ab shineing shining
ab shiped shipped
ab shoudl should
ab similiar similar
ab smae same
ab smoe some
ab soem some
ab sohw show
ab soudn sound
ab soudns sounds
ab statment statement
ab stnad stand
ab stopry story
ab stoyr story
ab stpo stop
ab strentgh strength
ab struggel struggle
ab sucess success
ab swiming swimming
ab tahn than
ab taht that
ab talekd talked
ab tath that
ab teh the
ab tehy they
ab tghe the
ab thansk thanks
ab themselfs themselves
ab theri their
ab thgat that
ab thge the
ab thier their
ab thme them
ab thna than
ab thne then
ab thnig thing
ab thnigs things
ab thsi this
ab thsoe those
ab thta that
ab tihs this
ab timne time
ab tje the
ab tjhe the
ab tkae take
ab tkaes takes
ab tkaing taking
ab tlaking talking
ab todya today
ab tongiht tonight
ab tonihgt tonight
ab towrad toward
ab tpyo typo
ab truely truly
ab tyhat that
ab tyhe the
ab useing using
ab vacumme vacuum
ab veyr very
ab vrey very
ab waht what
ab watn want
ab wehn when
ab whcih which
ab whic which
ab whihc which
ab whta what
ab wief wife
ab wierd weird
ab wihch which
ab wiht with
ab windoes windows
ab withe with
ab wiull will
ab wnat want
ab wnated wanted
ab wnats wants
ab woh who
ab wohle whole
ab wokr work
ab woudl would
ab wriet write
ab wrod word
ab wroking working
ab wtih with
ab wya way
ab yera year
ab yeras years
ab ytou you
ab yuo you
ab yuor your

" Days of weeks
ab monday Monday
ab tuesday Tuesday
ab wednesday Wednesday
ab thursday Thursday
ab friday Friday
ab saturday Saturday
ab sunday Sunday

" Months
ab january January
ab february February
ab march March
ab april April
ab june June
ab july July  
ab august August
ab september September
ab october October
ab november November
ab december December

