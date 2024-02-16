local utils = require("utils")

-- Neovim navigation

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", "<Cmd>wincmd k<CR>")
vim.keymap.set("n", "<c-j>", "<Cmd>wincmd j<CR>")
vim.keymap.set("n", "<c-h>", "<Cmd>wincmd h<CR>")
vim.keymap.set("n", "<c-l>", "<Cmd>wincmd l<CR>")

-- clear highlight
vim.keymap.set("n", "<leader>h", "<Cmd>nohlsearch<CR>")

-- Maximizer
vim.keymap.set("n", "<leader>m", "<Cmd>MaximizerToggle<CR>")

-- Notes bindings
vim.keymap.set("n", "<leader>nn", "<Cmd>Note new<CR>")
vim.keymap.set("n", "<leader>nR", "<Cmd>Note render<CR>")
vim.keymap.set("n", "<leader>nd", "<Cmd>Note delete<CR>")
vim.keymap.set("n", "<leader>nv", "<Cmd>Note view<CR>")
vim.keymap.set("n", "<leader>nV", "<Cmd>Viewer<CR>")
vim.keymap.set("n", "<leader>ng", "<Cmd>Note graph<CR>")
vim.keymap.set("n", "<leader>ne", "<Cmd>Note edit<CR>")
vim.keymap.set("n", "<leader>nr", "<Cmd>Note rename<CR>")
vim.keymap.set("n", "<leader>nf", "<Cmd>Note rename_ref<CR>")

-- Timew bindings
vim.keymap.set("n", "<leader>tn", "<Cmd>Timew start<CR>")
vim.keymap.set("n", "<leader>ts", "<Cmd>Timew stop<CR>")
vim.keymap.set("n", "<leader>tc", "<Cmd>Timew continue<CR>")
vim.keymap.set("n", "<leader>tC", "<Cmd>Timew cancel<CR>")
vim.keymap.set("n", "<leader>td", "<Cmd>Timew delete<CR>")

-- Doom like keybinds
vim.keymap.set("n", "<leader>fs", "<Cmd>write<CR>")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>fr", "<Cmd>Telescope frecency<CR>")
vim.keymap.set("n", "<leader>wv", "<Cmd>vsplit<CR>")
vim.keymap.set("n", "<leader>ws", "<Cmd>split<CR>")
vim.keymap.set("n", "<leader>wq", "<Cmd>quit<CR>")
vim.keymap.set("n", "<leader>fp", "<Cmd>Telescope find_files search_dirs={'~/.config/nvim'}<CR>") -- for "private config" files in ~/.config/nvim

-- Neo-tree bindings
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", {})
vim.keymap.set("n", "<leader>bf", "<Cmd>Neotree buffers reveal float<CR>", {})

-- Lsp binds
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
