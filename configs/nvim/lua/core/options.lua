-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.swapfile = false                  -- Don't use swapfile
opt.backup = false                    -- Don't create backup file 


-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.showmatch = true        -- Highlight matching parenthesis
--opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus=3            -- Set global statusline
--opt.cmdheight = 2           -- space in command line for message
--opt.cursorline = true       -- highlight the curret line

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.autoindent = true       -- Autoindent new lines
opt.smartindent = true      -- Autoindent new lines based on filejj
opt.smarttab = true         -- Auto tabs based shfitwidth, tabstop 
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.shiftwidth = 4          -- Shfir 4 spaces when tab

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 700        -- ms to wait for trigger an event

-----------------------------------------------------------
-- spell check 
-----------------------------------------------------------
opt.spell = true            -- Enable spell check
opt.spelllang = { 'en_us' } -- Set spell check language to english

-----------------------------------------------------------
-- terminal settings 
-----------------------------------------------------------
vim.cmd [[
augroup custom_term
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
augroup END
]]
