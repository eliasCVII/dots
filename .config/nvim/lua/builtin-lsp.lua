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
  update_in_insert = false,
})

local signs = {
  Error = "\u{f06a} ", -- nf-fa-exclamation_circle
  Warn = "\u{f071} ",  -- nf-fa-exclamation_triangle
  Hint = "\u{f0eb} ",  -- nf-fa-lightbulb_o
  Info = "\u{f05a} ",  -- nf-fa-info_circle
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

local diagnostic_goto = function(next, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = next and 1 or -1, float = true, severity = severity })
  end
end
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
vim.keymap.set("n", "<leader>ld", "<Cmd>lua vim.diagnostic.open_float()<CR>", { desc = "" })
