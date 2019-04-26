" plugins
let mpwd = '/home/simon/.config/nvim/plugged'
let mgocode =  '/home/simon/.config/nvim/plugged/gocode/nvim/symlink.sh'
call plug#begin(mpwd)
	Plug 'tpope/vim-rhubarb'           " Depenency for fugitive
  Plug 'ctrlpvim/ctrlp.vim'          " Dependancy for tagbar

  Plug 'tpope/vim-fugitive'					      " git
	Plug 'tpope/vim-surround'					      " quoting
	Plug 'rbgrouleff/bclose.vim'			      " close buffer without window
  Plug 'majutsushi/tagbar'
  Plug 'neomake/neomake'
  
  " themes
  Plug 'vim-airline/vim-airline'
  Plug 'joshdick/onedark.vim'
  
  Plug 'w0rp/ale', { 'for': 'go' }
  Plug 'sebdah/vim-delve', { 'for': 'go'}	
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }     
	Plug 'nsf/gocode', { 'rtp': 'vim', 'do': mgocode, 'for': 'go' }    

  Plug 'leafgarland/typescript-vim', { 'for': 'ts' } 
  Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }
  Plug 'mattn/emmet-vim', { 'for': ['css', 'html'] }
  Plug 'adamclerk/vim-razor', { 'for': 'cshtml' }
  Plug 'rust-lang/rust.vim', { 'for': 'rs' }
  Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': './install.sh' }
  Plug 'plasticboy/vim-markdown', { 'for': 'md' }
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

" deo
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#pointer = 1

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

" neomake
let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

" tagbar
let g:airline#extensions#tabline#show_tabs = 0

" ale
let g:ale_fix_on_save = 1
:let g:ale_linters = {
\    'go': ['goimports', 'go build'],
\    'markdown': []
\}
:let g:ale_fixers = {
\    'go': ['goimports', 'gofmt'],
\    'javascript': ['prettier']
\}
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1

" go
let g:neomake_go_gometalinter_maker = {
\ 'args': [
\   '--tests',
\   '--enable-gc',
\   '--concurrency=3',
\   '--fast',
\   '-D', 'aligncheck',
\   '-D', 'dupl',
\   '-D', 'gocyclo',
\   '-D', 'gotype',
\   '-E', 'misspell',
\   '-E', 'unused',
\   '%:p:h',
\ ],
\ 'append_file': 0,
\ 'errorformat':
\   '%E%f:%l:%c:%trror: %m,' .
\   '%W%f:%l:%c:%tarning: %m,' .
\   '%E%f:%l::%trror: %m,' .
\   '%W%f:%l::%tarning: %m'
\ }
let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
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

" delve
let g:delve_new_command = "new"
let g:delve_backend = "native"

" Fixes: https://github.com/neovim/neovim/issues/5990
let $VTE_VERSION="100"
set guicursor=

" emmet

" markdown
au! BufRead,BufFilePre,BufNewFile *.markdown setf markdown
au! BufRead,BufFIlePre,BufNewFile *.md       setf markdown

" epub
au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

" rust
let g:coc_force_debug = 1

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

" commands
command! -register MakeTags !ctags -R .

" workspaces
function! DevWorkspace()
  let g:netrw_list_hide = netrw_gitignore#Hide()
  normal! gg
  wincmd l
  sp
  wincmd j
  terminal
  file Console
  resize 10
  
  wincmd k
endfunction
command! -register Dev call DevWorkspace()

