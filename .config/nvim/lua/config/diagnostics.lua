-- Diagnostics config
local map = vim.keymap.set
local palette = {
  err = "#51202A",
  warn = "#3B3B1B",
  info = "#1F3342",
  hint = "#1E2E1E",
}

vim.api.nvim_set_hl(0, "DiagnosticErrorLine", { bg = palette.err, blend = 20 })
vim.api.nvim_set_hl(0, "DiagnosticWarnLine", { bg = palette.warn, blend = 15 })
vim.api.nvim_set_hl(0, "DiagnosticInfoLine", { bg = palette.info, blend = 10 })
vim.api.nvim_set_hl(0, "DiagnosticHintLine", { bg = palette.hint, blend = 10 })
vim.api.nvim_set_hl(0, "DapBreakpointSign", { fg = "#FF0000", bg = nil, bold = true })
vim.fn.sign_define("DapBreakpoint", {
  text = "●", -- a large dot; change as desired
  texthl = "DapBreakpointSign", -- the highlight group you just defined
  linehl = "", -- no full-line highlight
  numhl = "", -- no number-column highlight
})

local sev = vim.diagnostic.severity

vim.diagnostic.config({
  signs = { priority = 9999, severity = { min = "WARN", max = "ERROR" } },

  -- Show all diagnostics as underline (for their messages type `<Leader>ld`)
  underline = { severity = { min = "HINT", max = "ERROR" } },

  -- Show more details immediately for errors on the current line
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    severity = { min = "ERROR", max = "ERROR" },
  },

  linehl = {
    [sev.ERROR] = "DiagnosticErrorLine",
    [sev.WARN] = "DiagnosticWarnLine",
    [sev.INFO] = "DiagnosticInfoLine",
    [sev.HINT] = "DiagnosticHintLine",
  },

  update_in_insert = false,
})

local diagnostic_goto = function(next, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = next and 1 or -1, float = true, severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
map("n", "<leader>ld", "<Cmd>lua vim.diagnostic.open_float()<CR>", { desc = "" })
