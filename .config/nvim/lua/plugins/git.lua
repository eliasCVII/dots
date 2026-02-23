vim.pack.add({
  "https://www.github.com/lewis6991/gitsigns.nvim" 
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
