local rnu = vim.wo.rnu
local nu = vim.wo.nu

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

vim.diagnostic.config({
  signs = { priority = 9999, severity = { min = "WARN", max = "ERROR" } },

  -- Show all diagnostics as underline (for their messages type `<Leader>ld`)
  underline = { severity = { min = "HINT", max = "ERROR" } },

  -- Show more details immediately for errors on the current line
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    --severity = { min = "ERROR", max = "ERROR" },
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
})

local signs = {
  Error = "\u{f06a} ", -- nf-fa-exclamation_circle
  Warn = "\u{f071} ", -- nf-fa-exclamation_triangle
  Hint = "\u{f0eb} ", -- nf-fa-lightbulb_o
  Info = "\u{f05a} ", -- nf-fa-info_circle
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

do
  local orig = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig(contents, syntax, opts, ...)
  end
end

local function lsp_on_attach(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client then
    return
  end

  local bufnr = ev.buf
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  if client:supports_method("textDocument/codeAction", bufnr) then
    vim.keymap.set("n", "<leader>oi", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
        bufnr = bufnr,
      })
      vim.defer_fn(function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, 50)
    end, opts)
  end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup("lsp_attach"), callback = lsp_on_attach })

vim.lsp.config["*"] = {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
}

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

do
  local luacheck = require("efmls-configs.linters.luacheck")
  local stylua = require("efmls-configs.formatters.stylua")

  local flake8 = require("efmls-configs.linters.flake8")
  local black = require("efmls-configs.formatters.black")

  local prettier_d = require("efmls-configs.formatters.prettier_d")
  local eslint_d = require("efmls-configs.linters.eslint_d")

  local shellcheck = require("efmls-configs.linters.shellcheck")
  local shfmt = require("efmls-configs.formatters.shfmt")

  local cpplint = require("efmls-configs.linters.cpplint")
  local clangfmt = require("efmls-configs.formatters.clang_format")

  local go_revive = require("efmls-configs.linters.go_revive")
  local gofumpt = require("efmls-configs.formatters.gofumpt")

  local phplint = require("efmls-configs.linters.phpcs")
  local phpfmt = require("efmls-configs.formatters.phpcbf")

  vim.lsp.config("efm", {
    filetypes = {
      "c",
      "cpp",
      "css",
      "go",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "markdown",
      "python",
      "sh",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "php",
    },
    init_options = { documentFormatting = false },
    settings = {
      languages = {
        c = { clangfmt, cpplint },
        go = { gofumpt, go_revive },
        cpp = { clangfmt, cpplint },
        css = { prettier_d },
        html = { prettier_d },
        javascript = { eslint_d, prettier_d },
        javascriptreact = { eslint_d, prettier_d },
        -- json = { eslint_d, fixjson },
        -- jsonc = { eslint_d, fixjson },
        -- lua = { luacheck, stylua },
        markdown = { prettier_d },
        python = { flake8, black },
        sh = { shellcheck, shfmt },
        typescript = { eslint_d, prettier_d },
        typescriptreact = { eslint_d, prettier_d },
        vue = { eslint_d, prettier_d },
        svelte = { eslint_d, prettier_d },
        php = { phplint, phpfmt },
      },
    },
  })
end
