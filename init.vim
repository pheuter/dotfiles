language en_US

set nocompatible 
set encoding=UTF-8
filetype plugin indent on

syntax on
set background=dark

let mapleader = ","

set clipboard^=unnamed,unnamedplus
set t_RV=
set t_Co=256
set number
set showmatch
set visualbell
set hidden

set hlsearch
set smartcase
set ignorecase
set incsearch

set autoindent
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2

set ruler
set undolevels=1000
set backspace=indent,eol,start

set nobackup
set nowritebackup
set noswapfile
set noundofile

set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'

" Frontend
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'othree/html5.vim'
Plug 'JulesWang/css.vim'
Plug 'ap/vim-css-color'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" .NET
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'tag': '0.1.155',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ionide/Ionide-vim', {
      \ 'do':  'make fsautocomplete',
      \}

Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'

" General
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'

call plug#end()

" Fzf
nnoremap <C-b> :Buffers<CR>
nnoremap <leader><leader> :Commands<CR>
nnoremap <C-p> :Files<CR>

" Prettier
let g:prettier#autoformat = 1
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#print_width = 120
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'false'

" Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" Omnisharp
let g:ale_linters = { 'cs': ['OmniSharp'] }

" Gruvbox
autocmd vimenter * ++nested colorscheme gruvbox

" Deoplete
let g:deoplete#enable_at_startup = 1

" NERDTree
map <leader>t :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
