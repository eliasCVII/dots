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

return {
  filetypes = {
    -- "c",
    "cpp",
    "css",
    "go",
    "html",
    "markdown",
    "python",
    "sh",
    --"php",
  },
  init_options = { documentFormatting = false },
  settings = {
    languages = {
      -- c = { clangfmt, cpplint },
      go = { gofumpt, go_revive },
      cpp = { clangfmt, cpplint },
      css = { prettier_d },
      html = { prettier_d },
      markdown = { prettier_d },
      python = { flake8, black },
      sh = { shellcheck, shfmt },
      php = { phplint, phpfmt },
    },
  },
}
