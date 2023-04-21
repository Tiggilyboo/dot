local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

--if vim.fn.has('win32') then
--  local powershell_options = {
--    shell = vim.fn.executable "pwsh" and "pwsh" or "powershell",
--    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
--    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
--    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
--    shellquote = "",
--    shellxquote = "",
--  }
--
--  for option, value in pairs(powershell_options) do
--    vim.opt[option] = value
--  end
--else
--  vim.opt.shell = "bash"
--end

toggleterm.setup({
	size = 20,
	open_mapping = [[<C-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
  --shell = vim.o.shell,
	float_opts = {
		border = "curved",
	},
})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<ESC>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

