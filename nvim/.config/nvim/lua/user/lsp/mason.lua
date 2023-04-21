require("mason").setup()
require("mason-lspconfig").setup();

local servers = {
  "bashls",
  "jsonls",
  "yamlls",
  "omnisharp",
  "rust_analyzer",
  "gopls",
  "pylsp",
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "csharp_ls" then
    local csharp_opts = require "user.lsp.settings.csharp_ls"
    opts = vim.tbl_deep_extend("force", csharp_opts, opts)
  end

  if server == "omnisharp" then
    local omnisharp_opts = require "user.lsp.settings.omnisharp"
    opts = vim.tbl_deep_extend("force", omnisharp_opts, opts)
  end

  lspconfig[server].setup(opts)
end
