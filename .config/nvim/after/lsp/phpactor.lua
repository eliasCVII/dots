local util = require "lspconfig.util"

return {
  cmd = { "phpactor", "language-server" },
  filetypes = { "php" },
  root_markers = {"composer.json"}
}
