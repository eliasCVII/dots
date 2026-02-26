return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.lsp.config["*"] = {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      }
      -- Enable tailwindcss globally
      vim.lsp.enable("tailwindcss")
    end,
  },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    event = "VeryLazy",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    event = { "VeryLazy", "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "https://github.com/creativenull/efmls-configs-nvim",
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
      sources = {
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}
