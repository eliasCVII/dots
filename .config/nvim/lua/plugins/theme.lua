return { -- finally a beautiful theme
  { "webhooked/kanso.nvim" },
  { "mcchrish/zenbones.nvim",        dependencies = "rktjmp/lush.nvim" },
  { dir = "~/repo/monochrome.nvim/", dev = true },
  { 'kungfusheep/mfd.nvim',          opts = { bright_comments = true } },
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
