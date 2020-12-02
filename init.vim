language en_US

set nocompatible 
set encoding=UTF-8
filetype plugin indent on

syntax on
set background=dark

let mapleader = ","

" Escape from insert and terminal modes
inoremap jk <ESC>
tnoremap jk <C-\><C-n>

" Toggle last buffer
nnoremap <SPACE><TAB> :b#<CR>

" Split terminal below
set splitbelow
set splitright
nmap <leader>z :split term://zsh<CR> :res -10<CR>

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
set smartindent
set smarttab

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

" Frontend
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'othree/html5.vim'
Plug 'JulesWang/css.vim'
Plug 'ap/vim-css-color'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" .NET
Plug 'OmniSharp/omnisharp-vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'tag': '0.1.155',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ionide/Ionide-vim', {
      \ 'do':  'make fsautocomplete',
      \}

" Python
Plug 'davidhalter/jedi-vim'

" General
Plug 'morhetz/gruvbox'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-sleuth'
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
let g:OmniSharp_selector_findusages = 'fzf'
augroup omnisharp_commands
    autocmd!

    " Contextual commands based on cursor position
    autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
    autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
    autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
    autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)

    autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)
    autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
augroup END

" Gruvbox
autocmd vimenter * ++nested colorscheme gruvbox

" Deoplete
let g:deoplete#enable_at_startup = 1

" NERDTree
map <leader>t :NERDTreeToggle<CR>
map <leader>n :NERDTreeFind<CR>

" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
let g:ackhighlight = 1
nnoremap <leader>f :Ack!<Space>
