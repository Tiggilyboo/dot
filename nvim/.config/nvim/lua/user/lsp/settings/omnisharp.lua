local pid = vim.fn.getpid()
local omnisharp_bin = vim.env.HOME .. '/.vscode/extensions/ms-dotnettools.csharp-1.25.2-win32-x64/.omnisharp/1.39.2-net6.0/OmniSharp.dll'
local utils_ok, utils = pcall(require, 'user.utils')
if not utils_ok then
  print 'Unable to configure omnisharp without user.utils'
  return
end

return {
  cmd = { "dotnet", omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
  enable_editorconfig_support = true,
  enable_import_completion = true,
  enable_ms_build_load_projects_on_demand = false, -- if it gets slow
  enable_roslyn_analyzers = true,
  analyze_open_documents_only = true,
  sdk_include_prereleases = true,
  RoslynExtensionOptions = {
    enableAnalyzersSupport = true,
  },
  FormattingOptions = {
    enableEditorConfigSupport = true,
  },
  root_dir = function (fname)
    return utils.root_pattern '*.csproj'(fname) or utils.root_pattern '*.sln'(fname) or utils.find_git_ancestor(fname)
  end,
}
