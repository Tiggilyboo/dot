" plugins
let mpwd = '/home/simon/.config/nvim/plugged'

call plug#begin(mpwd)
	Plug 'tpope/vim-rhubarb'           " Depenency for fugitive
  Plug 'ctrlpvim/ctrlp.vim'          " Dependancy for tagbar

  Plug 'tpope/vim-fugitive'					      " git
	Plug 'tpope/vim-surround'					      " quoting
	Plug 'rbgrouleff/bclose.vim'			      " close buffer without window
  Plug 'majutsushi/tagbar'
  Plug 'wsdjeg/FlyGrep.vim'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  
  " themes
  Plug 'vim-airline/vim-airline'
  Plug 'joshdick/onedark.vim'

  "Plug 'OmniSharp/omnisharp-vim'
  Plug 'CraneStation/cranelift.vim'

call plug#end()

" vim
set noswapfile
set tabstop=2
set shiftwidth=2
set expandtab
set secure
set number
set wildmenu
set autoread
set noshowmode
set nospell
set noerrorbells
set novisualbell
set ignorecase
set smartcase
set clipboard=unnamedplus
set completeopt=menu
set encoding=utf-8
au CursorHold * checktime
filetype plugin on
filetype plugin indent on

" netrw
let g:netrw_banner = 0
let g:netrw_browse_split = 4  " Previous window
let g:netrw_altv = 1
let g:netrw_winsize = 22
let g:netrw_liststyle = 3
let g:netrw_browsex_viewer = "links"

" python pathing
let pyp2  = systemlist('readlink -f "/usr/bin/python2.7"')[0]
let g:python_host_prog=pyp2
let pyp3  = systemlist('readlink -f "/usr/bin/python3"')[0]
let g:python3_host_prog=pyp3

" themes
syntax on
colorscheme onedark

" ctrlp 
let g:ctrlp_map = ''

" airline
let g:airline_theme='onedark'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_symbols = {}
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_detect_whitespace=0
let g:airline_section_warning=''

" tagbar
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#ale#enabled = 1

let g:tagbar_type_go = {
\ 'ctagstype' : 'go',
\ 'kinds'     : [
    \ 'p:package',
    \ 'i:imports:1',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
\ ],
\ 'sro' : '.',
\ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
\ },
\ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
\ },
\ 'ctagsbin'  : 'gotags',
\ 'ctagsargs' : '-sort -silent'
\ }
let g:go_fmt_command = "goimports"
let g:go_term_mode = "split"
let g:go_metalinter_autosave = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_list_type = "quickfix"
let g:go_metalinter_command = ""
let g:go_metalinter_deadline = "5s"
let g:go_metalinter_enabled = [
\ 'deadcode',
\ 'gas',
\ 'goconst',
\ 'gocyclo',
\ 'golint',
\ 'gosimple',
\ 'ineffassign',
\ 'vet',
\ 'vetshadow'
\]

" lsp
lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.clangd.setup{}
lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.html.setup{}
lua require'lspconfig'.jsonls.setup{}
lua require'lspconfig'.pyls.setup{}
lua require'lspconfig'.rust_analyzer.setup{}
lua require'lspconfig'.texlab.setup{}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.yamlls.setup{}

" Fixes: https://github.com/neovim/neovim/issues/5990
let $VTE_VERSION="100"
set guicursor=

" markdown
au! BufRead,BufFilePre,BufNewFile *.markdown setf markdown
au! BufRead,BufFIlePre,BufNewFile *.md       setf markdown

" epub
au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

" leader key
let mapleader = ","
let g:mapleader = ","

" remaps
tnoremap <Esc> <C-\><C-n>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <F3> :TagbarToggle<cr>
nnoremap <leader>w :Bclose<cr>
nnoremap <C-Up> <Plug>(ale_previous_wrap)
nnoremap <C-Down> <Plug>(ale_next_wrap)
nnoremap <F2> :Lexplore<cr>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <leader>s :FlyGrep<cr>

" commands
command! -register MakeTags !ctags -R .
