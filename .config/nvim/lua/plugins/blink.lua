vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("^1"),
  },
})

-- Lazy load on first insert mode entry
local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  group = group,
  once = true,
  callback = function()
    require("blink.cmp").setup({
      keymap = { preset = "super-tab" },
      appearance = {
        nerd_font_variant = "mono",
        -- use_nvim_cmp_as_default = true,
      },
      completion = {
        documentation = { auto_show = false },
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
            enabled = true,
          },
        },
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
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    })
  end,
})
