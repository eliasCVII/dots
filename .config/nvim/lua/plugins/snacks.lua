return {
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
    -- Search
    { "<leader>cR", function() Snacks.rename.rename_file() end,          desc = "Rename File", },
    { "<leader>sw", function() Snacks.picker.grep_word() end,            desc = "Visual selection or word", mode = { "n", "x" }, },
    { "<leader>/",  function() Snacks.picker.lines() end,                desc = "Buffer Lines" },
    -- { "<leader>tg", function() Snacks.picker.grep() end, desc = "Grep" },

    -- Other
    { "<leader>ht", function() Snacks.picker.colorschemes() end,         desc = "Colorschemes" },

    -- Buffers
    { "<leader>bf", function() Snacks.picker.buffers() end,              desc = "Buffers" },

    -- Words
    { "]]",         function() Snacks.words.jump(vim.v.count1) end,      desc = "Next Reference",           mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end,     desc = "Prev Reference",           mode = { "n", "t" } },
  }
}
