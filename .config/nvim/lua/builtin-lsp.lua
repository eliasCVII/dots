-- vim.lsp.config["lua-language-server"] = {
--   cmd = { "lua-language-server" },
--   root_markers = { ".luarc.json" },
--   filetypes = { "lua" },
-- }

-- vim.lsp.enable("lua-language-server")

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--     if client:supports_method("textDocument/formatting") then
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         buffer = ev.buf,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
--         end,
--       })
--     end
--   end,
-- })

vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
  },
})
