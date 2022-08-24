-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------
-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

--Remap space as leader key
--leader key \ by default
-- yet to be tested
map('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable arrow keys
map('n', '<up>', '<nop>')
map('n', '<up>', '<nop>')
map('n', '<down>', '<nop>')
map('n', '<left>', '<nop>')

map('i', '<right>', '<nop>')
map('i', '<down>', '<nop>')
map('i', '<left>', '<nop>')
map('i', '<right>', '<nop>')

-- Map Esc to ff  in insert, visual and visual block mode
map('i', 'ff', '<Esc>')
map('v', 'ff', '<Esc>')
map('x', 'ff', '<Esc>')

-- Stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- hold on to last copied register
map('v', 'p','"_dp')

-- map for file explorer
map('n', '<Leader>e', ':NvimTreeOpen<CR>')
