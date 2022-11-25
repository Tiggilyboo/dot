local colorscheme = "onedark"
local default_style = "dark"

local onedark_ok, onedark = pcall(require, "onedark")
if not onedark_ok then
  print "Unable to load colorscheme"
  return
end

onedark.setup {
  style = default_style,
  toggle_style_key = "<leader>cst",
  toggle_style_list = { "dark", "light" },
}
onedark.load()

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  print "Unable to set colorscheme"
  return
end
