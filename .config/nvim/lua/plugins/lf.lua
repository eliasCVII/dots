return {
  "lmburns/lf.nvim",
  dependencies = {"akinsho/toggleterm.nvim"},
  lazy = false,
  config = function()
    vim.g.lf_netrw = 1

    require("lf").setup({
      escape_quit = false,
      border = "single",
      winblend = 0,
    })
  end,
}
