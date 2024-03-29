return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright" },
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({})
          end,
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      {
        "j-hui/fidget.nvim",
        opts = {
          progress = {
            suppress_on_insert = true,
            ignore_empty_message = true,
            ignore_done_already = true,
          },
        },
      },
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      -- lspconfig.hls.setup({
      --   filetypes = { "haskell", "lhaskell", "cabal" },
      --   capabilities = capabilities,
      --   settings = {
      --     haskell = {
      --       cabalFormattingProvider = "cabalfmt",
      --       formattingProvider = "ormolu",
      --     },
      --   },
      --   update_in_insert = false,
      --   single_file_support = true,
      -- })
      lspconfig.racket_langserver.setup({
        capabilities = capabilities
      })
    end,
  },
}
