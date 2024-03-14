return {
  {
    dir = "~/code/nvim-plugins/timew",
    -- "eliasCVII/timew",
    name = "timew",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },

    opts = {
      summary_sort = "month",
      delete_sort = "month",
      size = {
        width = 75,
        height = 15,
      },
    },
  },
}
