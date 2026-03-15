return {
  'chomosuke/typst-preview.nvim',
  lazy = false,
  -- ft = "typsy",
  version = '1.*',
  opts = {
    open_cmd = 'zen-browser %s -P typst-preview --class typst-preview',
    dependencies_bin = {
      ['tinymist'] = 'tinymist',
    },
  },
}
