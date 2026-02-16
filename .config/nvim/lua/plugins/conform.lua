return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      php = { "pretty-php" }
    },
    formatters = {
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      -- I recommend these options. See :help conform.format for details.
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  },
}
