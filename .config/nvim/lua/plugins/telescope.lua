return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-project.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          entry_prefix = " ",
          prompt_prefix = " ",
          selection_caret = " ",
          selection_strategy = "reset",
          order_by = "recent",
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          project = {
            base_dirs = {
              "~/texnotes",
              "~/dots/",
              "~/code/nvim-plugins",
              "~/org",
            },
            hidden_files = true,
            theme = "dropdown",
            order_by = "recent",
            sync_with_nvim_tree = true,
            on_project_selected = function(prompt_bufnr)
              -- Do anything you want in here. For example:
              require("telescope._extensions.project.actions").change_working_directory(
                prompt_bufnr,
                true
              )
            end,
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>.", builtin.find_files, {})
      vim.keymap.set("n", "<leader>tg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})

      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("project")
    end,
  },
}
