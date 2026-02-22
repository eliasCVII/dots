return {
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy",
  -- lazy = false,
  config = function()
    require("smart-splits").setup({
      default_amount = 5,
    })
    vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
  end,
}
