local utils = require("utils")

-- setup leader
vim.g.mapleader = " "

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
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

-- Doom like keybinds
vim.keymap.set("n", "<leader>fs", utils.on_save)
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>wv", "<Cmd>vsplit<CR>")
vim.keymap.set("n", "<leader>ws", "<Cmd>split<CR>")
vim.keymap.set("n", "<leader>wq", "<Cmd>quit<CR>")
vim.keymap.set("n", "<leader>oT", "<Cmd>vertical term<CR>")
vim.keymap.set("n", "<leader>oT", "<Cmd>horizontal term<CR>")
vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>")
vim.keymap.set("n", "<leader>bp", "<Cmd>bprev<CR>")

-- File browsing bindings
vim.keymap.set("n", "<leader>e", "<Cmd>lua MiniFiles.open()<CR>", {})

-- LSP
local opts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "<leader>ff", utils.autoformat, { desc= "Format" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc="Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc="Code Action" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc ="Hover documentation" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Diagnostic popup" })
vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)

-- source %
vim.keymap.set("n", "<leader><leader>x", "<Cmd>source%<CR>")

-- Toggle colorcolumn on and off
vim.keymap.set("n", "<F1>", function()
  utils.toggle_colorcolumn()
end)

-- Toggle diagnostics
vim.keymap.set("n", "<F2>", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- Turn on/off gutter numbers
vim.keymap.set("n", "<leader>tl", function()
  utils.toggle_numbers()
end)

-- Telescope
vim.keymap.set(
  "n",
  "<leader>tp",
  ":lua require'telescope'.extensions.project.project{}<CR>",
  { noremap = true, silent = true }
)

-- Pickers
vim.keymap.set("n", "<leader>th", "<Cmd>Pick help<CR>")
vim.keymap.set("n", "<leader>tg", "<Cmd>Pick grep_live<CR>")
vim.keymap.set("n", "<leader>bi", "<Cmd>Pick buffers<CR>")
vim.keymap.set("n", "<leader>hk", "<Cmd>Trouble todo<CR>", { desc = "Search for matching patterns" })

-- Tab movement
vim.keymap.set("n", "<leader>Tn", "<Cmd>tabnew<CR>")
vim.keymap.set("n", "<leader>Tc", "<Cmd>tabclose<CR>")
vim.keymap.set("n", "<A-,>", "<Cmd>tabnext<CR>")
vim.keymap.set("n", "<A-.>", "<Cmd>tabprevious<CR>")

-- Git utils
vim.keymap.set("n", "]h", "<Cmd>Gitsigns next_hunk<CR>")
vim.keymap.set("n", "[h", "<Cmd>Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "<Leader>gh", "<Cmd>lua MiniDiff.toggle_overlay()<CR>")
vim.keymap.set("n", "<leader>gb", "<Cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle inline blame" })
vim.keymap.set("n", "<leader>gw", "<Cmd>Gitsigns toggle_word_diff<CR>", { desc = "Toggle word diff" })
vim.keymap.set("n", "<leader>gp", "<Cmd>Pick git_hunks<CR>", { desc = "Search git hunks" })
vim.keymap.set("n", "<leader>gsh", "<Cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>guh", "<Cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Undo hunk stage" })
vim.keymap.set("n", "<leader>gsb", "<Cmd>Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
vim.keymap.set("n", "<leader>gub", "<Cmd>Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
vim.keymap.set("n", "<leader>gc", "<Cmd>Git commit<CR>", { desc = "git commit" })
vim.keymap.set("n", "<leader>gg", "<Cmd>Git<CR>", { desc = "fugitive" })
vim.keymap.set("n", "<leader>gd", "<Cmd>Gvdiffsplit<CR>", { desc = "Open diff in vsplit" })

-- Other bullshit
vim.keymap.set("n", "<leader>X", "<Cmd>lua MiniBufremove.delete()<CR>", { desc = "Delete this buffer" })
vim.keymap.set("n", "<leader>bs", utils.browser_sync, { desc = "Launch Browser-Sync" })
vim.keymap.set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>")

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Buffer shit
vim.keymap.set('n', '<leader>rb', function()
  local old_name = vim.fn.expand('%')
  local new_name = vim.fn.input('New file name: ', old_name)
  if new_name ~= '' and new_name ~= old_name then
    vim.cmd('saveas ' .. new_name)
    vim.fn.delete(old_name)
    print('File renamed to: ' .. new_name)
  end
end, { desc = 'Rename current file' })
