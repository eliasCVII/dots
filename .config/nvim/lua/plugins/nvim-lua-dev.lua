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
    commit = "8d3bce9764e627b62b07424e0df77f680d47ffdb",
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
