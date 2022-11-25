local utils_ok, utils = pcall(require, 'user.utils')
if not utils_ok then
  print 'Unable to load csharpls without utils'
  return 
end

return {
  settings = {
    csharpls = {
      init_options = {
        AutomaticWorkspaceInit = true,
      },
      filetypes = { "cs" },
      root_dir = function(fname)
        return utils.root_pattern '*.sln'(fname) or utils.find_git_ancestor(fname)
      end,
    }
  }
}
