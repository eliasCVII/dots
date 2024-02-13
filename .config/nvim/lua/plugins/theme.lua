-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- return {
--   "catppuccin/nvim",
--   lazy = false,
--   -- name = "phoenix",
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme "catppuccin"
--     require("catppuccin").setup({
--       flavour = 'mocha',
--       background = {
--         light = 'latte',
--         dark = 'mocha',
--       },
--       transparent_background = true,
--       show_end_of_buffer = false,
--       term_colors = false
--     })
--   end
-- }

-- return {
--   'miikanissi/modus-themes.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme "modus"
--     require("modus-themes").setup({
--       style = 'auto',
--       transparent = false,
--       variant = "tinted",
--     })
--   end
-- }

return { -- finally a beautiful theme
  "mellow-theme/mellow.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "mellow"
  end
}
