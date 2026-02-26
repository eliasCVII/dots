return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
        keywords = {
          NOTE = { icon = " ", color = "hint", alt = { "INFO", "IDEA" }
          }
        }
    },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  }
}
