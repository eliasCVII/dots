return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Formatters
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.clang_format,

        -- Diagnostics
        -- null_ls.builtins.diagnostics.flake8, NOTE: will be deprecated
        -- null_ls.builtins.diagnostics.cpplint, NOTE: will be deprecated

        -- Hover
        -- null_ls.builtins.hover.*

        -- Completion
        -- null_ls.builtins.completion.*

        -- Code Action
        -- null_ls.builtins.code_actions.shellcheck,
      },

    })
  end,
}
