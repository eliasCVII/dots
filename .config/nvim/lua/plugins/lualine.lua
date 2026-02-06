return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        disabled_filetypes = { "undotree" },
        -- "", "", "" ""
        component_separators = { left = ":", right = ":" },
        section_separators = { left = "", right = "" },
      },
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_b = { "diff" },
        lualine_c = {
          {
            'filename',
            file_status = true,
            newfile_status = false,
            path = 3,
            shorting_target = 40,
            symbols = {
              modified = '[+]', -- Text to show when the file is modified.
              readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]', -- Text to show for newly created file before first write
            }
          }
        },
        lualine_x = { "clock", "filetype" },
        lualine_y = {
          "branch"
          -- {
          --   "timew",
          --   spinners = false,
          --   active = "",
          --   inactive = "󰚌 ",
          --   padding = { left = 1, right = 1 },
          -- },
        },
        lualine_z = {
          "progress",
          "location",
          -- {
          --   require("noice").api.status.command.get,
          --   cond = require("noice").api.status.command.has,
          -- },
        },
      },
      inactive_sections = {
        lualine_a = { "clock" },
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
