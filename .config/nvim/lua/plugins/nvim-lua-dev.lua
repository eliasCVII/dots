return {
  {
    "folke/neodev.nvim",
    opts = {},
    lazy = true,
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "MunifTanjim/nui.nvim",
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
