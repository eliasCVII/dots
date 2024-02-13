local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.filetype.add({
  extension = {
    tex = 'tex',
  }
})

require("vim-options")
require("keymaps")
require("lazy").setup("plugins")

-- run on texnotes folder only?
local dir = "~/texnotes"
if vim.loop.cwd() == vim.fn.expand(dir) then
  require("texnotes")
  require("texnotes-watcher")
end