local g = vim.g
local o = vim.o

-- Functional wrapper for mapping custom keybindings
local function map(mode, key, command)
    vim.api.nvim_set_keymap(mode, key, command, { silent = true })
end

-- Better editor UI
o.number = true
o.numberwidth = 6
o.signcolumn = 'yes'
--o.cursorline = true

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = true

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true



-- Better folds (don't fold by default)
o.foldmethod = 'indent'
o.foldlevelstart = 99
o.foldnestmax = 3
o.foldminlines = 1

-- Disable arrow keys for learning 
map("n", "<Up>", "<Nop>")
map("n", "<Left>", "<Nop>")
map("n", "<Right>", "<Nop>")
map("n", "<Down>", "<Nop>")

map("i", "<Up>", "<Nop>")
map("i", "<Left>", "<Nop>")
map("i", "<Right>", "<Nop>")
map("i", "<Down>", "<Nop>")
