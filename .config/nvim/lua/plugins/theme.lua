return { -- finally a beautiful theme
  {"ellisonleao/gruvbox.nvim"},
  {"webhooked/kanso.nvim"},
  {"mcchrish/zenbones.nvim", dependencies = "rktjmp/lush.nvim"},
  {
    "mellow-theme/mellow.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme("mellow")
    end,
  },
}
