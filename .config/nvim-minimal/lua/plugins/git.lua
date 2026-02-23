vim.pack.add({
  "https://www.github.com/lewis6991/gitsigns.nvim",
  "https://www.github.com/tpope/vim-fugitive",
})

require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  signcolumn = true,
  current_line_blame = false,
})
