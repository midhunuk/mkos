-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------

-- Load nvim color schemed
local status_ok, color_scheme = pcall(require, 'onedark')
if not status_ok then
  return
end

-- https://github.com/navarasu/onedark.nvim
require('onedark').setup {
	style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
}
color_scheme.load()
