"> load plugins
call plug#begin(stdpath('data') . 'vimplug')
" telescope 
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
   
" lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'onsails/lspkind-nvim'

" auto-complete
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

" signiture help
    Plug 'ray-x/lsp_signature.nvim'

" tree-sitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" bar 
    Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }
    Plug 'kyazdani42/nvim-web-devicons'  " needed for galaxyline icons

" theme
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'folke/lsp-colors.nvim'

" misc
    Plug 'tpope/vim-ragtag'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'chun-yang/auto-pairs'

" useful command stuff
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    
" snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'rafamadriz/friendly-snippets'

" nerdtree
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'PhilRunninger/nerdtree-visual-selection'
    Plug 'preservim/nerdtree'

call plug#end()


colorscheme PaperColor

" basic settings
syntax on
set number
set relativenumber
set ignorecase      " ignore case
set smartcase     " but don't ignore it, when search string contains uppercase letters
set nocompatible
set incsearch        " do incremental searching
set visualbell
set expandtab
set tabstop=4
set ruler
set smartindent
set shiftwidth=4
set hlsearch
set virtualedit=all
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set encoding=utf8 " for nerdtree fonts
set autoindent
set mouse=a  " mouse support
set clipboard+=unnamedplus

" >> Configurations << (?)
" set leader key to ,
let g:mapleader=" "
" >> setup nerdcomment key bindings
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
" >> use nerd fonts in git status
let g:NERDTreeGitStatusUseNerdFonts = 1 
" you should install nerdfonts by yourself. default: 0
let g:NERDTreeMinimalUI = 1

 

" >> KEY BINDINGS <<
" >> Telescope bindings
nnoremap <Leader>pp <cmd>lua require'telescope.builtin'.builtin{}<CR>
" most recently used files
nnoremap <Leader>m <cmd>lua require'telescope.builtin'.oldfiles{}<CR>
" find buffer
nnoremap <Leader>; <cmd>lua require'telescope.builtin'.buffers{}<CR>
" find in current buffer
nnoremap <Leader>/ <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>
" bookmarks
nnoremap <Leader>' <cmd>lua require'telescope.builtin'.marks{}<CR>
" git files
nnoremap <Leader>f <cmd>lua require'telescope.builtin'.git_files{}<CR>
" all files
nnoremap <Leader>bfs <cmd>lua require'telescope.builtin'.find_files{}<CR>
" ripgrep like grep through dir
nnoremap <Leader>rg <cmd>lua require'telescope.builtin'.live_grep{}<CR>

" >> Lsp key bindings
" definition
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
"declaration
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
"references
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
"implementation
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
"signiture help
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"formatting
nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>
"rename
nnoremap <silent> <leader>r    <cmd>lua vim.lsp.buf.rename()<CR>
"hover <- information on hover
nnoremap <silent> K    <cmd>lua vim.lsp.buf.hover()<CR>
"code action
nnoremap <silent> <leader>ca    <cmd>lua vim.lsp.buf.code_action()<CR>

" completion
nnoremap <silent> <leader>co    <cmd>lua vim.lsp.buf.completion()<CR>

" document highlight
" document symbol
" publish diagnostics
" range formatting
" type definition 
" log messages
" show message
" show message request
" apply edit
" symbol


" >> NERDtree map
nnoremap <leader>t :NERDTreeToggle<CR>

" >> window movement 
nnoremap <leader>h <c-w>h
nnoremap <leader>l <c-w>l
nnoremap <leader>k <c-w>k
nnoremap <leader>j <c-w>j

" >> close windows
nnoremap <leader>q :q<CR>

" >> tabs 
" next-tab
nmap  <leader>] gt 
"prev-tab
nmap  <leader>[ gT

" >> AutoCmd <<


" >> LUA SCRIPTS <<
lua <<EOF
require("completion")
require("lsp")
require("treesitter")
require("statusbar")
require('snippets')
EOF
