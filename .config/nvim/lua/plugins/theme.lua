return { -- finally a beautiful theme
  { "webhooked/kanso.nvim" },
  { "mcchrish/zenbones.nvim",        dependencies = "rktjmp/lush.nvim" },
  { dir = "~/repo/monochrome.nvim/", dev = true },
  { 'kungfusheep/mfd.nvim',          opts = { bright_comments = true } },
  { "sainnhe/gruvbox-material" },
  {
    "mellow-theme/mellow.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_enable_bold = 1
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
}
