vim.g.mapleader   = " "
vim.opt.swapfile  = false

vim.o.mousescroll = 'ver:10,hor:6'             -- Customize mouse scroll
vim.o.switchbuf   = 'usetab'                   -- Use already opened buffers when switching
vim.o.shada       = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

vim.cmd('filetype plugin indent on')
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

-- Relative line numbers
vim.opt.nu             = true
vim.opt.rnu            = true

-- 2 space tab
vim.opt.expandtab      = true
vim.opt.tabstop        = 2
vim.opt.shiftwidth     = 2
vim.opt.softtabstop    = 2

-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.smartindent    = true
vim.opt.breakindent    = true
vim.o.breakindentopt   = 'list:-1' -- Add padding for lists (if 'wrap' is set)

vim.o.formatoptions    = 'brqnl1j' -- Improve comment editing

-- Enable incremental searching
vim.opt.incsearch      = true
vim.opt.hlsearch       = true

-- Disable text wrap
vim.opt.wrap           = false

-- Better splitting
vim.opt.splitbelow     = true
vim.opt.splitright     = true

-- Enable mouse mode
vim.opt.mouse          = "a"

-- Enable ignorecase + smartcase for better searching
vim.opt.ignorecase     = true
vim.opt.smartcase      = true

-- Decrease updatetime to 200ms
-- vim.opt.updatetime = 100

-- Set completeopt to have a better completion experience
vim.opt.completeopt    = { "menuone", "noselect" }

-- Enable persistent undo history
vim.opt.undofile       = true

-- Enable 24-bit color
vim.opt.termguicolors  = true

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn     = "yes"

-- Enable access to System Clipboard
vim.opt.clipboard      = "unnamed,unnamedplus"

-- Enable cursor line highlight
vim.opt.cursorline     = true

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
vim.opt.foldcolumn     = "1"
vim.opt.foldlevel      = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable     = true

-- Always keep 8 lines above/below cursor unless at start/end of file
vim.opt.scrolloff      = 10

-- Place a column line
vim.opt.colorcolumn    = "80"

vim.o.spelloptions     = 'camel' -- Treat camelCase word parts as separate word

vim.opt.list           = true
vim.o.fillchars        = 'eob: ,fold:╌'
vim.opt.listchars      = { tab = "»  ", trail = "·", nbsp = "␣", extends = "…", precedes = "…" }

vim.opt.conceallevel = 2

vim.o.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part

-- Pattern for a start of numbered list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]
