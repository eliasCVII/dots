local utils = require("utils")

-- setup leader
vim.g.mapleader = " "

-- Neovim navigation

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", "<Cmd>wincmd k<CR>")
vim.keymap.set("n", "<c-j>", "<Cmd>wincmd j<CR>")
vim.keymap.set("n", "<c-h>", "<Cmd>wincmd h<CR>")
vim.keymap.set("n", "<c-l>", "<Cmd>wincmd l<CR>")

-- Navigate through terminals
vim.keymap.set("t", "<esc>", "[[<C-><C-n>]]")
vim.keymap.set("t", "jk", [[<C-\><C-n>]])
vim.keymap.set("t", "<c-k>", "<Cmd>wincmd k<CR>")
vim.keymap.set("t", "<c-j>", "<Cmd>wincmd j<CR>")
vim.keymap.set("t", "<c-h>", "<Cmd>wincmd h<CR>")
vim.keymap.set("t", "<c-l>", "<Cmd>wincmd l<CR>")

-- clear highlight
vim.keymap.set("n", "<leader>h", "<Cmd>nohlsearch<CR>")

-- Maximizer
vim.keymap.set("n", "<leader>m", "<Cmd>MaximizerToggle<CR>")

-- Notes bindings
vim.keymap.set("n", "<leader>nn", "<Cmd>Note new<CR>")
vim.keymap.set("n", "<leader>nR", "<Cmd>Note render<CR>")
vim.keymap.set("n", "<leader>nV", "<Cmd>Viewer<CR>")
vim.keymap.set("n", "<leader>ng", "<Cmd>Note graph<CR>")
vim.keymap.set("n", "<leader>nf", "<Cmd>Note rename reference<CR>")
vim.keymap.set("n", "<leader>no", "<Cmd>Note open menu<CR>")
vim.keymap.set("n", "<leader>np", "<Cmd>Note new project<CR>")
vim.keymap.set("n", "<leader>nm", "<Cmd>Note manage<CR>")

-- Timew bindings
vim.keymap.set("n", "<leader>tn", "<Cmd>Timew start<CR>")
vim.keymap.set("n", "<leader>ts", "<Cmd>Timew stop<CR>")
vim.keymap.set("n", "<leader>tc", "<Cmd>Timew continue<CR>")
vim.keymap.set("n", "<leader>tC", "<Cmd>Timew cancel<CR>")
vim.keymap.set("n", "<leader>td", "<Cmd>Timew delete<CR>")
vim.keymap.set("n", "<leader>tS", "<Cmd>Timew summary<CR>")

-- Doom like keybinds
vim.keymap.set("n", "<leader>fs", "<Cmd>write<CR>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>wv", "<Cmd>vsplit<CR>")
vim.keymap.set("n", "<leader>ws", "<Cmd>split<CR>")
vim.keymap.set("n", "<leader>wq", "<Cmd>quit<CR>")
vim.keymap.set("n", "<leader>fp", "<Cmd>Telescope find_files search_dirs={'~/.config/nvim'}<CR>") -- for "private config" files in ~/.config/nvim
vim.keymap.set("n", "<leader>ot", "<Cmd>ToggleTerm<CR>")

-- File browsing bindings
vim.keymap.set("n", "<leader>e", "<Cmd>lua MiniFiles.open()<CR>", {})
vim.keymap.set("n", "<leader>bf", "<Cmd>Neotree buffers reveal float<CR>", {})

-- LSP binds
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

-- Zen Mode
vim.keymap.set("n", "<leader>tz", "<Cmd>ZenMode<CR>")

-- source %
vim.keymap.set("n", "<leader><leader>x", "<Cmd>source%<CR>")

-- Toggle colorcolumn on and off
vim.keymap.set("n", "<F1>", function()
	utils.toggle_colorcolumn()
end)

-- Telescope
vim.keymap.set(
	"n",
	"<leader>tp",
	":lua require'telescope'.extensions.project.project{}<CR>",
	{ noremap = true, silent = true }
)

vim.keymap.set("n", "<leader>th", "<Cmd>Telescope help_tags<CR>")

vim.keymap.set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>")

-- mini.visits
vim.keymap.set("n", "<leader>a", "<Cmd>lua MiniVisits.add_label()<CR>", {})
vim.keymap.set("n", "<C-e>", "<Cmd>lua MiniVisits.select_label()<CR>", {})
