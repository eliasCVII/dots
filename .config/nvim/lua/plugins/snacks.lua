return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      input = { enabled = false },
      picker = { enabled = true },
      notifier = { enabled = false },
      quickfile = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = true },
      indent = {
        enabled = false,
        only_scope = true,
        only_current = true,
        scope = {
          enabled = true
        },
        chunk = {
          enabled = true,
          only_current = true,
          priority = 200,
          hl = "SnacksIndentChunk",
          char = {
            corner_top = "┌",
            corner_bottom = "└",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
      },
    },
    keys = {
      -- Pickers
      { "<leader>/",  function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>tg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>th", function() Snacks.picker.help() end, desc = "Help Tags" },
      { "<leader>hk", function() Snacks.picker.todo_comments() end, desc = "Search TODOS" },
      { "<leader>ht", function() Snacks.picker.colorschemes() end,     desc = "Colorschemes" },
      { "<leader>bi", function() Snacks.picker.buffers() end,          desc = "Buffers" },

      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",           mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",           mode = { "n", "t" } },
    }
  },
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
  -- {
  --   "folke/trouble.nvim",
  --   opts = {}, -- for default options, refer to the configuration section for custom setup.
  --   cmd = "Trouble",
  -- },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
  "dtormoen/neural-open.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  -- NeuralOpen implements lazy loading internally. It needs to be loaded for recency tracking to work.
  lazy=false;
  keys = {
    { "<leader>.", "<Plug>(NeuralOpen)", desc = "Neural Open Files" },
  },
  -- opts are optional. NeuralOpen will automatically use the defaults below.
  opts = {},
}
}
