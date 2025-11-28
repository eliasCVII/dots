local ns = vim.api.nvim_create_namespace("my_namespace")

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  update_in_insert = false,
  severity_sort = true,
})

local rnu = vim.wo.rnu
local nu = vim.wo.nu

