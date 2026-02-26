return { -- finally a beautiful theme
  { "webhooked/kanso.nvim", lazy = true },
  -- { "mcchrish/zenbones.nvim",        dependencies = "rktjmp/lush.nvim" },
  -- {
  --   dir = "~/repo/mfd.nvim/",
  --   dev = true,
  --   opts = { bright_comments = true }
  -- },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_transparent_background = 1
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  {
    "mellow-theme/mellow.nvim",
  },
}
