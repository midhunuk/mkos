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
map('i', 'jk', '<Esc>')
map('v', 'jk', '<Esc>')
map('x', 'jk', '<Esc>')

-- Better window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Resize with arrows
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- hold on to last copied register
map('v', 'p','"_dp')
map("x", "<leader>p", [["_dP]])

-- map for file explorer
map('n', '<Leader>e', ':Ex<CR>')

-- map for close and save using leader key
map('n', '<Leader>w', ':w<CR>')
map('n', '<Leader>q', ':q!<CR>')

--map for tabs selection
map('n', '<Leader>1', '1gt<CR>')
map('n', '<Leader>2', '2gt<CR>')
map('n', '<Leader>3', '3gt<CR>')
map('n', '<Leader>4', '4gt<CR>')
map('n', '<Leader>5', '5gt<CR>')
map('n', '<Leader>6', '6gt<CR>')
map('n', '<Leader>7', '7gt<CR>')
map('n', '<Leader>8', '8gt<CR>')
map('n', '<Leader>9', '9gt<CR>')
map('n', '<Leader>l', 'gt<CR>')
map('n', '<Leader>h', 'gT<CR>')

-- joining line using J will put the cursor where it was rather than moving to the end of the line
map("n", "J", "mzJ`z")

-- half page jumping keeps the cursor in the center of the screen
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- mapping to move the selected lines up and down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- keeps the search lines in the middle 
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- copies to the clipboard 
map("n", "<leader>y", [["+y]])
map("v", "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- deletes to the void register\
map("n", "<leader>d", [["_d]])
map("v", "<leader>d", [["_d]])
