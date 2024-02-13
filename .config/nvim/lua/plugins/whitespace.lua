return {
  "cappyzawa/trim.nvim",
  config = function ()
    require("trim").setup({
      ft_blocklist = {"markdown"},
      trim_on_write = true
    })
  end
}
