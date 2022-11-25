local lsp_config_ok, lspconfig = pcall(require,'lspconfig')
if not lsp_config_ok then
  print "Unable to load utils"
  return
end

return lspconfig.util

