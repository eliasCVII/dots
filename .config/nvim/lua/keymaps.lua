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

-- Notes bindings
vim.keymap.set("n", "<leader>nn", "<Cmd>Note new<CR>")
vim.keymap.set("n", "<leader>nR", "<Cmd>Note render<CR>")
vim.keymap.set("n", "<leader>nV", "<Cmd>Note viewer<CR>")
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
vim.keymap.set("n", "<leader>fs", utils.on_save)
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>wv", "<Cmd>vsplit<CR>")
vim.keymap.set("n", "<leader>ws", "<Cmd>split<CR>")
vim.keymap.set("n", "<leader>wq", "<Cmd>quit<CR>")
vim.keymap.set("n", "<leader>fp", "<Cmd>Telescope find_files search_dirs={'~/.config/nvim'}<CR>") -- for "private config" files in ~/.config/nvim
vim.keymap.set("n", "<leader>ot", "<Cmd>ToggleTerm direction=float<CR>")
vim.keymap.set("n", "<leader>oT", "<Cmd>ToggleTerm direction=horizontal<CR>")
vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>")
vim.keymap.set("n", "<leader>bp", "<Cmd>bprev<CR>")
-- vim.keymap.set("n", "<leader>bf", "<Cmd>FzfLua buffers<CR>")
vim.keymap.set("n", "<leader>bt", "<Cmd>FzfLua tabs<CR>")

-- File browsing bindings
vim.keymap.set("n", "<leader>e", "<Cmd>lua MiniFiles.open()<CR>", {})

-- LSP binds
local map = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = "LSP: " .. desc })
end
-- vim.keymap.set("n", "<leader>gf", utils.autoformat, {})
map("<leader>gf", utils.autoformat, "Format")
map("<leader>rn", vim.lsp.buf.rename, "Rename")
map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
map("K", vim.lsp.buf.hover, "Hover documentation")
-- map("<leader>gD", vim.lsp.buf.declaration, "Goto Declaration")
-- map("<leader>gd", vim.lsp.buf.definition, "Goto Definition")
-- map("<leader>gr", vim.lsp.buf.references, "Goto Reference")

-- Zen Mode
vim.keymap.set("n", "<leader>tz", "<Cmd>ZenMode<CR>")

-- source %
vim.keymap.set("n", "<leader><leader>x", "<Cmd>source%<CR>")

-- Toggle colorcolumn on and off
vim.keymap.set("n", "<F1>", function()
  utils.toggle_colorcolumn()
end)

-- vim.keymap.set("n", "<F2>", function()
--   utils.toggle_diagnostics()
-- end)

vim.keymap.set("n", "<leader>tl", function()
  utils.toggle_numbers()
end)

-- vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float)

-- Telescope
vim.keymap.set(
  "n",
  "<leader>tp",
  ":lua require'telescope'.extensions.project.project{}<CR>",
  { noremap = true, silent = true }
)

vim.keymap.set("n", "<leader>th", "<Cmd>Telescope help_tags<CR>")
-- vim.keymap.set("n", "<leader>tg", "<Cmd>lua Snacks.picker.grep()<CR>")
vim.keymap.set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>")

vim.keymap.set("n", "<leader>p", "<Cmd>Precognition toggle<CR>")
vim.keymap.set("n", "<leader>Th", "<Cmd>Hardtime toggle<CR>")

vim.keymap.set("n", "<leader>Tn", "<Cmd>tabnew<CR>")
vim.keymap.set("n", "<leader>Tc", "<Cmd>tabclose<CR>")
vim.keymap.set("n", "<A-,>", "<Cmd>tabnext<CR>")
vim.keymap.set("n", "<A-.>", "<Cmd>tabprevious<CR>")
