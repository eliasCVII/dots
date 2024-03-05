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
        -- ensure_installed = { "lua_ls", "pyright" },
        -- handlers = {
        --   function(server_name) -- default handler (optional)
        --     require("lspconfig")[server_name].setup({})
        --   end,
        -- },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} },
      -- { "folke/neoconf.nvim", cmd = "Neoconf", config = false },
    },
    -- setup = {},
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.bashls.setup({
        capabilities = capabilities,
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })
      lspconfig.texlab.setup({
        capabilities = capabilities,
      })

    end,
  },
}
