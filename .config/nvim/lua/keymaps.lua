-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", "<Cmd>wincmd k<CR>")
vim.keymap.set("n", "<c-j>", "<Cmd>wincmd j<CR>")
vim.keymap.set("n", "<c-h>", "<Cmd>wincmd h<CR>")
vim.keymap.set("n", "<c-l>", "<Cmd>wincmd l<CR>")

vim.keymap.set("n", "<leader>h", "<Cmd>nohlsearch<CR>")

-- Notes keymaps
vim.keymap.set("n", "<leader>nn", "<Cmd>Note new<CR>")
vim.keymap.set("n", "<leader>nR", "<Cmd>Note render<CR>")
vim.keymap.set("n", "<leader>nd", "<Cmd>Note delete<CR>")
vim.keymap.set("n", "<leader>nv", "<Cmd>Note view<CR>")
vim.keymap.set("n", "<leader>nV", "<Cmd>Viewer<CR>")
vim.keymap.set("n", "<leader>ng", "<Cmd>Note graph<CR>")
vim.keymap.set("n", "<leader>ne", "<Cmd>Note edit<CR>")
vim.keymap.set("n", "<leader>nr", "<Cmd>Note rename<CR>")
vim.keymap.set("n", "<leader>nf", "<Cmd>Note rename_ref<CR>")

-- Doom like keybinds
vim.keymap.set("n", "<leader>fs", "<Cmd>write<CR>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>fr", "<Cmd>Telescope frecency<CR>")

-- Neo-tree bindings
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", {})
vim.keymap.set("n", "<leader>bf", "<Cmd>Neotree buffers reveal float<CR>", {})
