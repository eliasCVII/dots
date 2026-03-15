return {
  {
    'whonore/Coqtail',
    lazy = false,
    filetypes = 'coq',
    init = function()
      vim.g.loaded_coqtail = 1
      vim.g["coqtail#supported"] = 0
    end,
  },
  {
    'tomtomjhj/vsrocq.nvim',
    filetypes = 'coq',
    dependecies = {
      'whonore/Coqtail',
    },
    opts = {
      vsrocq = {
        proof = { mode = "Continuous" },
        completiom = { enable = true },
        diagnostics = { full = true }
      }
      -- lsp = { ... }
    },
  },
}
