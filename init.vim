"> load plugins
call plug#begin(stdpath('data') . 'vimplug')
" telescope 
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'

" lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'onsails/lspkind-nvim'
    Plug 'tami5/lspsaga.nvim'

" fsharp support
    Plug 'ionide/Ionide-vim', { 'do':  'make fsautocomplete'}

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
    Plug 'lewis6991/spellsitter.nvim'

" bar 
    Plug 'NTBBloodbath/galaxyline.nvim', { 'branch': 'main' }
" theme/ui
    Plug 'Mofiqul/vscode.nvim'
    Plug 'folke/lsp-colors.nvim'
    Plug 'danilamihailov/beacon.nvim'
    Plug 'romgrk/barbar.nvim'
    Plug 'RRethy/vim-illuminate'
    Plug 'karb94/neoscroll.nvim'
    Plug 'sindrets/diffview.nvim'

" misc
    Plug 'tpope/vim-ragtag'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'windwp/nvim-autopairs'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    
" snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'rafamadriz/friendly-snippets'

" icons
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'

" filetree
    Plug 'kyazdani42/nvim-tree.lua' 

" diagnostics
    Plug 'folke/trouble.nvim'

" kitty 
    Plug 'fladson/vim-kitty'

" search
    Plug 'ggandor/lightspeed.nvim' 

" comments
    Plug 'numToStr/Comment.nvim'
 
call plug#end()


let g:vscode_style = "dark"
colorscheme vscode

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
set mouse+=a  " mouse support !changed to += but may just need to be =!
set clipboard+=unnamedplus
set signcolumn=yes
set termguicolors

" >> Configurations << (?)
" set leader key to ,
let g:mapleader=" "

" >> KEY BINDINGS <<
" >> Telescope bindings
nnoremap <Leader>`         <cmd>lua require'telescope.builtin'.builtin{}<CR>
nnoremap <Leader>;         <cmd>lua require'telescope.builtin'.buffers{}<CR>
nnoremap <Leader>/         <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>
nnoremap <Leader>'         <cmd>lua require'telescope.builtin'.marks{}<CR>
nnoremap <Leader>gf        <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <Leader>f         <cmd>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <Leader>b         <cmd>lua require'telescope.builtin'.file_browser{}<CR>

" >> Lsp key bindings
nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>pd    <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent> gD            <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gu            :Lspsaga lsp_finder<CR>
nnoremap <silent> gU            <cmd>TroubleToggle lsp_references<cr> 
nnoremap <silent> gi            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>k     <cmd>Lspsaga signature_help<CR>
nnoremap <silent> gf            <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>r     <cmd>Lspsaga rename<CR>
nnoremap <silent> K             <cmd>Lspsaga hover_doc<CR>
"TODO map this to alt enter
nnoremap <silent> <leader>a     <cmd>Lspsaga code_action<CR> 
nnoremap <silent> <leader>d      <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

" diagnostics
nnoremap <silent> <leader>xx         <cmd>TroubleToggle<cr>
nnoremap <silent>         ge        :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>         gp        :Lspsaga diagnostic_jump_prev<CR>

" >> Window management
nnoremap <leader>h      <c-w>h
nnoremap <leader>l      <c-w>l
nnoremap <leader>k      <c-w>k
nnoremap <leader>j      <c-w>j
nnoremap <leader>q      :q<CR> " close window
nnoremap <silent>       <leader>1 :BufferGoto 1<CR>
nnoremap <silent>       <leader>2 :BufferGoto 2<CR>
nnoremap <silent>       <leader>3 :BufferGoto 3<CR>
nnoremap <silent>       <leader>4 :BufferGoto 4<CR>
nnoremap <silent>       <leader>5 :BufferGoto 5<CR>
nnoremap <silent>       <leader>6 :BufferGoto 6<CR>
nnoremap <silent>       <leader>7 :BufferGoto 7<CR>
nnoremap <silent>       <leader>8 :BufferGoto 8<CR>
nnoremap <silent>       <leader>9 :BufferLast<CR>

" >> Tabs 
nnoremap <silent>       <leader>]  :BufferNext<CR>
nnoremap <silent>       <leader>[  :BufferPrevious<CR>
nnoremap <silent>       <leader>w  :BufferClose<CR>
nnoremap <silent>       <leader>t  <cmd>lua require('tree-barbar').toggle()<CR> " file tree toggle 

" Diff
nnoremap <silent> <leader>vh <cmd>DiffviewFileHistory<CR>
nnoremap <silent> <leader>vd <cmd>DiffviewOpen<CR>
nnoremap <silent> <leader>vc <cmd>DiffviewClose<CR>

" Misc
nnoremap <silent> <leader>nh <cmd>:noh<CR> " remove highlights

" >> LUA SCRIPTS <<
lua <<EOF
require("completion")
require("lsp")
require("statusbar")
require("treesitter")
require('autopair-config')
require('comment-config')
require('diffview-config')
require('filetree')
require('saga')
require('smooth-scrolling')
require('snippets')
require('spellcheck')
require('tree-barbar')
require('auto-tag-config')
EOF
