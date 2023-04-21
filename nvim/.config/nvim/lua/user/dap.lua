local util_ok, utils = pcall(require, "user.utils")
if not util_ok then
  print "Unable to load dap without utils"
  return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

-- load launchjs configurations
local dap_vscode_ok, dap_vscode = pcall(require, "dap.ext.vscode")
if not dap_vscode_ok then
  print('Unable to load dap vscode for launchjs')
else
  local fname = vim.fn.expand('%:r')
  local path = utils.root_pattern '*.sln'(fname) or utils.find_git_ancestor('.')
  if path then
    print('Loading launchjs from ' .. path .. '/.vscode/launch.json')
    dap_vscode.load_launchjs(path .. '/.vscode/launch.json', {
      coreclr = { 'cs' }
    })
  else
    print('Unable to find launchjs folder')
  end
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end


-- setup language adapters
dap.adapters.coreclr = {
  type = 'executable',
  command = vim.env.HOME .. '/.local/bin/netcoredbg.exe',
  args= {'--interpreter=vscode'}
}
dap.configurations.cs = {
  {
    type = 'coreclr',
    name = "launch - netcoredbg",
    request = 'launch',
    program = function()
      local fname = vim.fn.expand('%:r')
      local path = utils.root_pattern '*.sln'(fname) or utils.find_git_ancestor('.')
      if path and utils.path.is_dir(path) then
        local filepath = utils.path.join(path, fname .. '.dll')
        print('Trying to open: ' .. filepath)
        if utils.path.is_file(filepath) then
          return filepath
        end
      end

      return vim.fn.input('Path to dll', path, 'file')
    end,
  },
}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/codelldb',
    args = { "--port", "${port}" },
  }
}
dap.configurations.rust = {
  {
    name = "Debug",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to target: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.rust
dap.configurations.cpp = dap.configurations.rust

dapui.setup {
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  }
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

-- automatically open
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
