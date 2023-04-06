local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    "wbthomason/packer.nvim",
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
    },
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    "nvim-lualine/lualine.nvim",
    "nvim-treesitter/nvim-treesitter",
    "lewis6991/gitsigns.nvim",
    "airblade/vim-gitgutter",
    "tpope/vim-fugitive",
    "github/copilot.vim",
    "simrat39/rust-tools.nvim",
    {
        "williamboman/mason.nvim",
        lazy = false,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
    },
    "neovim/nvim-lspconfig",
    "glepnir/lspsaga.nvim",
    -- "is0n/jaq-nvim",
    {},
    "tpope/vim-commentary", -- Add operator for adding comments
    "tpope/vim-fugitive",   -- Git integration
    "tpope/vim-repeat",     -- Repeat more commands
    "tpope/vim-rsi",        -- Readline mappings for insert and command mode
    "tpope/vim-surround",   -- mappings for wrapping objects
    "vim-scripts/scratch.vim", -- Easy tmp buffer
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
            char_highlight_list = {
                "IndentBlanklineIndent1",
                "IndentBlanklineIndent2",
                "IndentBlanklineIndent3",
                "IndentBlanklineIndent4",
                "IndentBlanklineIndent5",
                "IndentBlanklineIndent6",
            },
        },
    },
    "goolord/alpha-nvim", -- startup screen
    "google/vim-jsonnet",
    -- "rking/ag.vim",       -- search with ag in vim
    "godlygeek/tabular",  -- formatter
    "takac/vim-commandcaps", -- correct mistyped commands like :Wq
    "HiPhish/nvim-ts-rainbow2",
    {
        -- need to use fork for bug fix
        -- https://github.com/spamwax/hop.nvim
        "phaazon/hop.nvim",
        branch = "v2", -- optional but strongly recommended
        -- hop var should work..
        opts = { keys = "etovxqpdygfblzhckisuran" },
        config = function(hop, opts)
            hop = require("hop")
            hop.setup(opts)
            local directions = require("hop.hint").HintDirection

            vim.keymap.set("n", "<space><space>", function()
                hop.hint_anywhere()
            end, { remap = true })

            vim.keymap.set("n", "<space>j", function()
                hop.hint_lines({ direction = directions.AFTER_CURSOR })
            end, { remap = true })

            vim.keymap.set("n", "<space>k", function()
                hop.hint_lines({ direction = directions.BEFORE_CURSOR })
            end, { remap = true })

            vim.keymap.set("n", "<space>w", function()
                hop.hint_words({ direction = directions.AFTER_CURSOR })
            end, { remap = true })

            vim.keymap.set("n", "<space>b", function()
                hop.hint_words({ direction = directions.BEFORE_CURSOR })
            end, { remap = true })
        end,
    },
    "kkharji/sqlite.lua",
    "nvim-telescope/telescope-smart-history.nvim",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        config = function(telescope, opts)
            telescope = require("telescope")
            opts = {
                defaults = {
                    prompt_prefix = " ",
                    history = {
                        path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
                        limit = 100,
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    mappings = {
                        n = {
                            ["<esc>"] = require("telescope.actions").close,
                            ["<CR>"] = require("telescope.actions").select_default,
                            ["<C-x>"] = require("telescope.actions").select_horizontal,
                            ["<C-v>"] = require("telescope.actions").select_vertical,
                            ["<C-t>"] = require("telescope.actions").select_tab,
                            ["<Tab>"] = require("telescope.actions").toggle_selection
                                + require("telescope.actions").move_selection_worse,
                            ["<S-Tab>"] = require("telescope.actions").toggle_selection
                                + require("telescope.actions").move_selection_better,
                            ["<C-q>"] = require("telescope.actions").send_to_qflist
                                + require("telescope.actions").open_qflist,
                            ["<M-q>"] = require("telescope.actions").send_selected_to_qflist
                                + require("telescope.actions").open_qflist,
                            ["j"] = require("telescope.actions").move_selection_next,
                            ["k"] = require("telescope.actions").move_selection_previous,
                            ["H"] = require("telescope.actions").move_to_top,
                            ["M"] = require("telescope.actions").move_to_middle,
                            ["L"] = require("telescope.actions").move_to_bottom,
                            ["<Down>"] = require("telescope.actions").move_selection_next,
                            ["<Up>"] = require("telescope.actions").move_selection_previous,
                            ["gg"] = require("telescope.actions").move_to_top,
                            ["G"] = require("telescope.actions").move_to_bottom,
                            ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
                            ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
                            ["<PageUp>"] = require("telescope.actions").results_scrolling_up,
                            ["<PageDown>"] = require("telescope.actions").results_scrolling_down,
                            ["?"] = require("telescope.actions").which_key,
                        },
                        i = {
                            ["<C-n>"] = require("telescope.actions").cycle_history_next,
                            ["<C-p>"] = require("telescope.actions").cycle_history_prev,
                        },
                    },
                },
            }
            telescope.setup(opts)
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function(null_ls, opts)
            null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.completion.spell,
                    null_ls.builtins.formatting.black,
                    -- null_ls.builtins.diagnostics.flake8,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.rustfmt,
                    -- null_ls.builtins.diagnostics.codespell,
                    null_ls.builtins.diagnostics.zsh,
                    null_ls.builtins.code_actions.shellcheck,
                    null_ls.builtins.diagnostics.shellcheck,
                },
            })
        end,
    },
    "folke/trouble.nvim",
}

require("lazy").setup(plugins)
-- require("alpha").setup(require("alpha.themes.startify").config)

vim.keymap.set("n", "<leader><enter>", ":nohlsearch<CR>")
vim.g.mapleader = "§"
vim.g.maplocalleader = "§"
vim.keymap.set("n", "<leader>f", ":lua vim.lsp.buf.format()<CR>")
-- disable gitgutter and use gitsigns instead, but keep movements from
-- gitgutter
vim.g.gitgutter_signs = false

vim.cmd([[

set listchars=tab:▸\ ,eol:¬,trail:●,extends:❯,precedes:❮,nbsp:☠
set matchtime=2                     " How many tenths of a second to blink
set wildignore+=*/target/*

set whichwrap+=<,>,h,l
set matchpairs+=<:>                 " match, to be used with %
set clipboard+=unnamedplus

" Sexy cursors
" set guicursor=n-c:block-Cursor-blinkon0
" set guicursor+=v:block-vCursor-blinkon0
" set guicursor+=i:ci-ver20-iCursor
" highlight iCursor guifg=white guibg=white
" hi MatchParen guifg=lightblue guibg=darkblue

set backupdir=~/.local/state/nvim/backup//
" Make those folders automatically if they don't already exist.
" Should auto do now
" if !isdirectory(expand(&undodir))
"     call mkdir(expand(&undodir), "p")
" endif
" if !isdirectory(expand(&backupdir))
"     call mkdir(expand(&backupdir), "p")
" endif
" if !isdirectory(expand(&directory))
"     call mkdir(expand(&directory), "p")
" endif

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

nnoremap <silent> gf gF

" TODO toggle colorcolumn
nnoremap <leader>c :set colorcolumn=79<CR>
nnoremap <leader>n :set number!<CR>

nnoremap <leader>e :e ~/.config/nvim/init.lua<CR>
nnoremap <leader>l :set list!<CR>
" save
nnoremap <leader>s :w<CR>

nnoremap <silent> <leader><CR> :set hlsearch!<CR>
" nnoremap <silent> <F7> :set spell!<CR>

" Cycle buffers quickly
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <silent> <C-j> :bprev<CR>

" Use current selection for Acking all files in cwd
" vnoremap <silent> <leader>a :<C-U>let @/=GetVisual()<CR> :set hls<CR>:Ag "<C-R>/"<CR>
" nnoremap <silent> <leader>a :let @/='<C-R>=expand("<cword>")<CR>'<CR>:Ag <cword><CR>:set hls<CR>

" Execute search with pattern
function! DoSearch(pattern)
    let l:escaped_pattern = escape(a:pattern, '\\/.*$^~[]')
    let l:escaped_pattern = substitute(l:escaped_pattern, "\n$", "", "")

    " Don't use default behaviour for matching boundaries
    " execute "normal ?\\<" . l:pattern . "\\>"
    " let @/ = "\\<" . l:pattern . "\\>"

    execute "normal ?" . l:escaped_pattern
    let @/ = l:escaped_pattern
    set hls
endfunction

" From visual selection execute search
function! VisualSelectionSearch() range
    let l:saved_reg = @"
    execute "normal! vgvy"
    call DoSearch(@")
    let @" = l:saved_reg
endfunction


" Searching with visual selections
vnoremap <silent> * :call VisualSelectionSearch()<CR>
vnoremap <silent> # :call VisualSelectionSearch()<CR>

" Put word under cursor into search register and highlight
nnoremap <silent> * :call DoSearch(expand("<cword>"))<CR>
nnoremap <silent> # :call NormalSearch(expand("<cword>"))<CR>

" Navigate through wrapped lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k
" Git merge symbols search
nnoremap <leader>i /^\(<<<<<<<\\|=======$\\|>>>>>>>\)<CR>

" autocmd FileType yaml IndentLinesEnable
autocmd FileType yaml set shiftwidth=2 tabstop=2

" When vimrc is edited, reload it
" autocmd! bufwritepost .vimrc source ~/.vimrc

" Hide imports for java files
autocmd! BufEnter *.java :setlocal foldexpr=HideImportFold(v:lnum) foldmethod=expr foldlevel=0
" autocmd! BufEnter *.py :setlocal foldexpr=HideCopyRight(v:lnum) foldmethod=expr foldlevel=0

" check my english
autocmd FileType rst set spell
autocmd FileType rst set spelllang=en
autocmd FileType rst set tw=79
autocmd FileType md set spell
autocmd FileType md set spelllang=en
autocmd FileType md set tw=79
autocmd FileType markdown set spell
autocmd FileType markdown set spelllang=en
autocmd FileType markdown set tw=79
autocmd FileType gitcommit set spell
autocmd FileType gitcommit set spelllang=en

" Remove whitespace, keep position
function! RemoveTrailingWhiteSpace() range
    normal mzHmy
    let l:range = a:firstline . "," . a:lastline
    if a:firstline == a:lastline
        let l:range = "%"
    endif
    silent! exec l:range . 's/\s\+$//g'
    normal 'yz<CR>
    normal `z
endfunction
" Synonym for Remove.. I can't always remember which one!
command! -nargs=0 -range DeleteTrailingWhiteSpace <line1>,<line2>call RemoveTrailingWhiteSpace()
command! -nargs=0 -range RemoveTrailingWhiteSpace <line1>,<line2>call RemoveTrailingWhiteSpace()

command! -nargs=0 SyntaxHighlighting call SynStack()

" Helpful Expansions
" expand to current dir of file
cabbr <expr> %% expand('%:p:h')
cabbr <expr> %d expand('%:p:h')
" expand current file
cabbr <expr> %f expand('%')
" expand to home
cabbr <expr> %h expand('$HOME')
]])

-- vim.opt.showcmd = true
-- vim.opt.laststatus = 2
-- vim.opt.autowrite = true
-- vim.opt.autoread = true

vim.opt.undofile = true   --                        " So is persistent undo ...
vim.opt.autoindent = true -- indent at the same level of the previous line
vim.opt.cursorline = true -- highlight current line :set cul
vim.opt.backspace = "2"
vim.opt.backup = true     --                          " backups are nice ...
--vim.opt.clipboard ="unnamed"
-- set cmdheight=1                     " The commandbar height
vim.opt.cpoptions = "aABceFsmq"
vim.opt.hid = true        --                             " Change buffer - without saving
vim.opt.ignorecase = true --            " Ignore case when searching
vim.opt.incsearch = true  --               " Make search act like search in modern browsers
vim.opt.linebreak = true  --

vim.opt.wrap = false      --                          " Wrap long lines
vim.opt.number = true     --                          " Set line numbers
vim.opt.numberwidth = 5   -- " Show line numbers up to size 99999
vim.opt.report = 0        -- " Tell us when anything is changed via status line
vim.opt.termguicolors = false

vim.opt.showmatch = true --                       " Show matching bracets when text indicator is over them
vim.opt.smartcase = true --                       " Use smartcase searching
vim.opt.scrolloff = 6    --                     " Minimal number of screen lines to keep above and below the cursor.

vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.shiftwidth = 4    --                    " Auto-indent amount when using cindent,
vim.opt.softtabstop = 4   --                   " When hitting tab or backspace, how many spaces
vim.opt.expandtab = true  --
vim.opt.tabstop = 4       --                       " Real tabs should be 4, and they will show with

vim.opt.timeoutlen = 2500 --
-- vim.opt.swapfile = false
vim.cmd([[
autocmd ColorScheme * highlight MatchParen guifg=white guibg=none ctermfg=white ctermbg=none
]])
vim.cmd.colorscheme("gruvbox")

vim.opt.termguicolors = true

--Line numbers

vim.cmd([[
" Couldn't translate to vim.opt ..
" TODO Use XDG_STATE..
set viminfo='10,\"100,:200,%,n~/.local/state/nvim/viminfo
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :200  :  up to 200 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
]])

vim.cmd([[
highlight CopilotSuggestion ctermfg=8 guifg=white guibg=#5c6370
]])

require("gitsigns").setup()
require("mason").setup()
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
require("mason-lspconfig").setup({
    ensure_installed = {
        "rust_analyzer",
        "lua_ls",
        "terraformls",
        "tflint",
        "yamlls",
        "bashls",
        "pyright",
    },
})

-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspsaga").setup({})
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
vim.keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<cr>", { silent = true })
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })

require("lspconfig").lua_ls.setup({
    -- capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})

require("lspconfig").pyright.setup({
    -- capabilities = capabilities,
})

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "gruvbox",
    },
    sections = {
        lualine_a = {
            {
                "filename",
                path = 1,
            },
        },
    },
})
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    view = {
        adaptive_size = true,
    },
})

require("telescope").load_extension("smart_history")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
vim.keymap.set("n", "<c-p>", builtin.find_files, {})
vim.keymap.set("n", "<c-t>", builtin.builtin, {})
-- vim.keymap.set('n', '<c-p>', builtin.resume, {})
--vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
vim.keymap.set("n", "fg", builtin.live_grep, {})
vim.keymap.set("n", "<Space>fh", builtin.help_tags, {})

require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all"
    ensure_installed = {
        "c",
        "lua",
        "rust",
        "ruby",
        "vim",
        "markdown",
        "markdown_inline",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        "yaml",
        "toml",
        "graphql",
        "bash",
        "regex",
        "go",
        "dart",
        "java",
        "php",
        "haskell",
        "ocaml",
        "r",
        "ruby",
        "scala",
        "swift",
        "tsx",
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
    rainbow = {
        enable = true,
        -- list of languages you want to disable the plugin for
        disable = { "jsx", "cpp" },
        -- Which query to use for finding delimiters
        query = "rainbow-parens",
        -- Highlight the entire buffer all at once
        strategy = require("ts-rainbow").strategy.global,
    },
})
-- vim.cmd [[
-- let test#strategy = "vimux"
-- ]]

-- vim.keymap.set('n', '<leader>t', ':TestNearest<CR>')
-- vim.keymap.set('n', '<leader>T', ':TestFile<CR>')

vim.cmd([[
" autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async=false})
]])

require("trouble").setup()

vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

require("indent_blankline").setup()

vim.g.indent_blankline_filetype = { "json", "yaml" }

require("rust-tools").setup({
    server = {
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
})

vim.cmd([[
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
iabbrev acommodated accommodated
iabbrev Acommodated Accommodated
iabbrev acomodate accommodate
iabbrev Acomodate Accommodate
iabbrev acomodated accommodated
iabbrev Acomodated Accommodated
iabbrev adn and
iabbrev Adn And
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
iabbrev aplyed applied
iabbrev Aplyed Applied
iabbrev appeares appears
iabbrev Appeares Appears
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
iabbrev bianries binaries
iabbrev Bianries Binaries
iabbrev bianry binary
iabbrev Bianry Binary
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
iabbrev enviroment environment
iabbrev Enviroment Environment
iabbrev enviroment environment
iabbrev Enviroment Environment
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
iabbrev exprot export
iabbrev Exprot Export
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
iabbrev foudn found
iabbrev Foudn Found
iabbrev foward forward
iabbrev Foward Forward
iabbrev freind friend
iabbrev Freind Friend
iabbrev frmo from
iabbrev Frmo From
iabbrev fro for
iabbrev Fro For
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
iabbrev librarry library
iabbrev Librarry Library
iabbrev librery library
iabbrev Librery Library
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
iabbrev opperation operation
iabbrev Opperation Operation
iabbrev optoin option
iabbrev Optoin Option
iabbrev optoins options
iabbrev Optoins Options
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
iabbrev reivew review
iabbrev Reivew Review
iabbrev religous religious
iabbrev Religous Religious
iabbrev reveiw review
iabbrev Reveiw Review
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
]])
