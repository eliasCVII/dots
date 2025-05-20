return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = false },
    picker = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = true },
  },
  keys = {
    -- LSP
    {"gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition",},
    {"gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration",},
    {"gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References",},
    {"gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation",},
    {"gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition",},

    -- Search
    {"<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File",},
    {"<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" },},
    {"<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics",},
    {"<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics",},
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },

    -- Other
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>ht", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.diagnostics():map("<F2>")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
