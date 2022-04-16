" plugins
let mpwd = '/home/simon/.config/nvim/plugged'

call plug#begin(mpwd)
  Plug 'tpope/vim-rhubarb'           " Depenency for fugitive
  Plug 'ctrlpvim/ctrlp.vim'          " Dependancy for tagbar

  Plug 'tpope/vim-fugitive'					      " git
  Plug 'tpope/vim-surround'					      " quoting
  Plug 'rbgrouleff/bclose.vim'			      " close buffer without window
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'

  " autocomplete
  Plug 'prabirshrestha/asyncomplete.vim'
  
  " themes
  Plug 'vim-airline/vim-airline'
  Plug 'joshdick/onedark.vim'
  
  " debug
  Plug 'nvim-lua/plenary.nvim'
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'

  " langs
  Plug 'simrat39/rust-tools.nvim'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'OmniSharp/omnisharp-vim'
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
set mouse=n
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
syntax enable
colorscheme onedark

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

" omnisharp
let g:OmniSharp_server_use_mono=1
let g:OmniSharp_highlighting=2
augroup omnisharp_commands
  autocmd!

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ofu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ofi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>opd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>opi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ot <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>od <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ofs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ofx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>ogcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>oca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>oca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>o. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>o. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>o= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>orn <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>ore <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osp <Plug>(omnisharp_stop_server)
augroup END

" Fixes: https://github.com/neovim/neovim/issues/5990
let $VTE_VERSION="100"
set guicursor=

lua << EOF

-- lsp
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.gopls.setup{
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
}
require'lspconfig'.html.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.rust_analyzer.setup{} 
require'lspconfig'.texlab.setup{} 
require'lspconfig'.vimls.setup{}
require'lspconfig'.yamlls.setup{}

-- lldb
local ext_path = os.getenv('HOME') .. '/.vscode/extensions/'
local lldbext_path = ext_path .. 'vadimcn.vscode-lldb-1.6.10/'
local codelldb_path = lldbext_path .. 'adapter/codelldb'
local liblldb_path = lldbext_path .. 'lldb/lib/liblldb.so'

-- dap
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = codelldb_path,
  name = 'lldb'
}
dap.configurations.c = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}
dap.configurations.rs = dap.configurations.c
dap.configurations.cpp = dap.configurations.c

-- unity
local unity_path = ext_path .. "unity.unity-debug-3.0.2/"

dap.adapters.unity = {
  type = 'executable',
  command = 'mono',
  args = { unity_path .. "bin/UnityDebug.exe" },
  name = 'unity'
}
dap.configurations.cs = {
  {
    name = "Unity Editor",
    type = "unity",
    request = "launch",
    path = "Library/EditorInstance.json",
    __exceptionOptions = {},
  }
}

-- omnisharp
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/simon/.local/bin/OmniSharp"
require'lspconfig'.omnisharp.setup{
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) };
}

-- rust
local opts = {
    tools = { -- rust-tools options
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,

        -- Whether to show hover actions inside the hover window
        -- This overrides the default hover handler 
        hover_with_actions = true,

        -- how to execute terminal commands
        -- options right now: termopen / quickfix
        executor = require("rust-tools/executors").termopen,

        runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {

            -- Only show inlay hints for the current line
            only_current_line = false,

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",

            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = true,

            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",

            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,

            -- The color of the hints
            highlight = "Comment",
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                {"╭", "FloatBorder"}, {"─", "FloatBorder"},
                {"╮", "FloatBorder"}, {"│", "FloatBorder"},
                {"╯", "FloatBorder"}, {"─", "FloatBorder"},
                {"╰", "FloatBorder"}, {"│", "FloatBorder"}
            },

            -- whether the hover action window gets automatically focused
            auto_focus = false
        },

        -- settings for showing the crate graph based on graphviz and the dot
        -- command
        crate_graph = {
            -- Backend used for displaying the graph
            -- see: https://graphviz.org/docs/outputs/
            -- default: x11
            backend = "x11",
            -- where to store the output, nil for no output stored (relative
            -- path from pwd)
            -- default: nil
            output = nil,
            -- true for all crates.io and external crates, false only the local
            -- crates
            -- default: true
            full = true,
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {}, -- rust-analyer options

    -- debugging stuff
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
    }
}

require('rust-tools').setup(opts)

require("dapui").setup()
require('telescope').setup()
EOF

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
nnoremap <leader>w :Bclose<cr>
nnoremap <leader>d :lua require'dapui'.toggle()<cr>
nnoremap <leader>b :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <F2> :Lexplore<cr>
nnoremap <F5> :lua require'dap'.continue()<cr>
nnoremap <F9> :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <F10> :lua require'dap'.step_over()<cr>
nnoremap <F11> :lua require'dap'.step_into()<cr>

" autocomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)


