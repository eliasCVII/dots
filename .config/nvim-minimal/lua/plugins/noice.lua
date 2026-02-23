vim.pack.add({
  "https://github.com/folke/noice.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
})

if vim.o.filetype == "lazy" then
  vim.cmd([[messages clear]])
end

require("noice").setup({
  views = {
    cmdline_popup = {
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      filter_options = {},
    },
  },
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
    format = {
      cmdline = { pattern = "^:", icon = "", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
      input = {}, -- Used by input()
    },
  },
  presets = {
    bottom_search = true,
    command_palette = false,
  },
  hover = {
    enabled = true,
    silent = true,
    view = nil,
    opts = {},
  },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
    progress = {
      enabled = false,
    }
  },
  routes = {
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },
  },
})
