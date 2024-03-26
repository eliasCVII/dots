return {
  {
    "Olical/conjure",
    ft = { "clojure", "racket" }, -- etc
    dependencies = { "PaterJason/cmp-conjure" },
    config = function(_, opts)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
      -- Set configuration options here
      vim.g["conjure#debug"] = true
    end,
  },
  "wlangstroth/vim-racket",
}
