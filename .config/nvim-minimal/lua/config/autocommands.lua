local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("hlyank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_on_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("check_reload"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Set filetype for .env and .env.* files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("env_filetype"),
  pattern = { "*.env", ".env.*" },
  callback = function()
    vim.opt_local.filetype = "sh"
  end,
})

-- Format on save (ONLY real file buffers, ONLY when efm is attached)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = augroup("format_on_save"),
--   pattern = {
--     "*.lua",
--     "*.py",
--     "*.go",
--     "*.js",
--     "*.jsx",
--     "*.ts",
--     "*.tsx",
--     "*.json",
--     "*.css",
--     "*.scss",
--     "*.html",
--     "*.sh",
--     "*.bash",
--     "*.zsh",
--     "*.c",
--     "*.cpp",
--     "*.h",
--     "*.hpp",
--     "*.php",
--   },
--   callback = function(args)
--     -- avoid formatting non-file buffers (helps prevent weird write prompts)
--     if vim.bo[args.buf].buftype ~= "" then
--       return
--     end
--     if not vim.bo[args.buf].modifiable then
--       return
--     end
--     if vim.api.nvim_buf_get_name(args.buf) == "" then
--       return
--     end
--
--     local has_efm = false
--     for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
--       if c.name == "efm" then
--         has_efm = true
--         break
--       end
--     end
--     if not has_efm then
--       return
--     end
--
--     pcall(vim.lsp.buf.format, {
--       bufnr = args.buf,
--       timeout_ms = 2000,
--       filter = function(c)
--         return c.name == "efm"
--       end,
--     })
--   end,
-- })
