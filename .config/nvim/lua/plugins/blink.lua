return {
  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    version = "1.*",
    dependencies = { "L3MON4D3/LuaSnip" },
    build = "cargo build --release",
    opts = {
      completion = {
        menu = {
          winblend = vim.o.pumblend,
          draw = {
            columns = {
              { "label",     "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        list = {
          selection = { preselect = false, auto_insert = false },
        },
        trigger = { show_in_snippet = false },
        ghost_text = { enabled = true },
      },
      keymap = {
        ["<C-e>"] = { "hide", "fallback" },

        ["<C-j>"] = { "select_next", "show" },
        ["<C-k>"] = { "select_prev" },

        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      appearance = {
        nerd_font_variant = "normal",
        kind_icons = {
          Array = " ",
          Boolean = "󰨙 ",
          Class = " ",
          Codeium = "󰘦 ",
          Color = " ",
          Control = " ",
          Collapsed = " ",
          Constant = "󰏿 ",
          Constructor = " ",
          Copilot = " ",
          Enum = " ",
          EnumMember = " ",
          Event = " ",
          Field = " ",
          File = " ",
          Folder = " ",
          Function = "󰊕 ",
          Interface = " ",
          Key = " ",
          Keyword = " ",
          Method = "󰊕 ",
          Module = " ",
          Namespace = "󰦮 ",
          Null = " ",
          Number = "󰎠 ",
          Object = " ",
          Operator = " ",
          Package = " ",
          Property = " ",
          Reference = " ",
          Snippet = " ",
          String = " ",
          Struct = "󰆼 ",
          TabNine = "󰏚 ",
          Text = " ",
          TypeParameter = " ",
          Unit = " ",
          Value = " ",
          Variable = "󰀫 ",
        },
      },
      cmdline = {
        enabled = false,
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
      },

      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },

      signature = { enabled = true },
      snippets = { preset = "luasnip" },
    },
  },
}
