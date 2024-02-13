-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Notes keymaps
vim.keymap.set("n", "<leader>nn", ":Note new<CR>")
vim.keymap.set("n", "<leader>nR", ":Note render<CR>")
vim.keymap.set("n", "<leader>nd", ":Note delete<CR>")
vim.keymap.set("n", "<leader>nv", ":Note view<CR>")
vim.keymap.set("n", "<leader>nV", ":Viewer<CR>")
vim.keymap.set("n", "<leader>ng", ":Note graph<CR>")
vim.keymap.set("n", "<leader>ne", ":Note edit<CR>")
vim.keymap.set("n", "<leader>nr", ":Note rename<CR>")
vim.keymap.set("n", "<leader>nf", ":Note rename_ref<CR>")

-- Doom like keybinds
vim.keymap.set("n", "<leader>fs", ":w<CR>")
vim.keymap.set("i", "jk", "<Esc>")
-- vim.keymap.set("n", "<leader>.", "<Cmd>Neotree toggle<CR>")

-- Neo-tree bindings
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", {})
vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
