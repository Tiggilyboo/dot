" plugins
call plug#begin()
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
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  
  " themes
  Plug 'vim-airline/vim-airline'
  Plug 'joshdick/onedark.vim'
  
  " debug
  Plug 'nvim-lua/plenary.nvim'
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'

  " langs
  Plug 'simrat39/rust-tools.nvim'
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
"set mouse=n
set laststatus=3 " global status bar
au CursorHold * checktime
filetype plugin on
filetype plugin indent on

" Fixes: https://github.com/neovim/neovim/issues/5990
let $VTE_VERSION="100"
set guicursor=

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
let g:OmniSharp_highlighting=3
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


lua << EOF
-- nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- lsp
local nvim_lsp = require('lspconfig')
local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

nvim_lsp.bashls.setup{ on_attach = on_attach, capabilities = capabilities }
nvim_lsp.clangd.setup{ on_attach = on_attach, capabilities = capabilities }
nvim_lsp.html.setup{ on_attach = on_attach, capabilities = capabilities }
nvim_lsp.jsonls.setup{ on_attach = on_attach, capabilities = capabilities }
nvim_lsp.pylsp.setup{ on_attach = on_attach, capabilities = capabilities }
nvim_lsp.rust_analyzer.setup{ on_attach = on_attach, capabilities = capabilities } 
nvim_lsp.texlab.setup{ on_attach = on_attach, capabilities = capabilities } 
nvim_lsp.vimls.setup{ on_attach = on_attach, capabilities = capabilities }
nvim_lsp.yamlls.setup{ on_attach = on_attach, capabilities = capabilities }

-- golang lsp
nvim_lsp.gopls.setup{
    on_attach = on_attach, capabilities = capabilities,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
}

-- unity lsp
local pid = vim.fn.getpid()
local omnisharp_bin = os.getenv('HOME') .. "/.cache/bin"
nvim_lsp.omnisharp.setup{
  on_attach = on_attach, capabilities = capabilities,
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) };
}

-- nvim-cmp
local cmp = require 'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
  },
}

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

-- rust
local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        executor = require("rust-tools/executors").termopen,
        runnables = {
            use_telescope = true
        },
        debuggables = {
            use_telescope = true
        },
        inlay_hints = {
            only_current_line = false,
            only_current_line_autocmd = "CursorHold",
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
        },
        hover_actions = {
            border = {
                {"╭", "FloatBorder"}, {"─", "FloatBorder"},
                {"╮", "FloatBorder"}, {"│", "FloatBorder"},
                {"╯", "FloatBorder"}, {"─", "FloatBorder"},
                {"╰", "FloatBorder"}, {"│", "FloatBorder"}
            },
            auto_focus = false
        },
        crate_graph = {
            backend = "x11",
            output = nil,
            full = true,
        }
    },
    server = {}, 
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
inoremap <C-p> <C-x><C-o>

" autocomplete

