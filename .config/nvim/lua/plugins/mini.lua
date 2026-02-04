return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  version = false,
  config = function()
    -- Better surroundings, in visual or normal mode
    require("mini.surround").setup({})

    -- Filesystem navigation+modifications
    require("mini.files").setup({
      windows = {
        max_number = math.huge,
        preview = false,
        width_focus = 30,
        width_nofocus = 15,
        width_preview = 55,
      },
      mappings = {
        go_in = "l",
        go_in_plus = "<CR>",
      },
    })

    -- some out of the box settings
    require("mini.basics").setup({
      options = {
        basic = false,
        extra_ui = false,
        win_borders = "default",
      },
      mappings = {
        basic = false,
        option_toggle_prefix = "",
        windows = false,
        move_with_alt = true,
      },
      autocommands = {
        basic = false,
      },
    })

    require("mini.pairs").setup({})

    -- Move selected blocks
    require("mini.move").setup({
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",

        -- Move current line in Normal mode
        line_left = "",
        line_right = "",
        line_down = "",
        line_up = "",
      },
    })

    -- gS
    require("mini.splitjoin").setup()

    require("mini.misc").setup()

    require("mini.misc").setup_restore_cursor()

    -- Great picker for anything
    local win_config = function()
      local height = 20
      local width = 70
      return {
        config = {
          anchor = "NW",
          height = height,
          width = width,
          row = math.floor(0.5 * vim.o.lines - (height / 2)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        },
        prompt_prefix = " : ",
      }
    end
    require("mini.pick").setup({
      window = win_config(),
    })

    -- Bracket movement
    require("mini.bracketed").setup() -- TODO: learn mappings

    -- Remove whitespace
    require("mini.trailspace").setup()

    -- Extra features
    require("mini.extra").setup()
    require("mini.git").setup();
    require("mini.diff").setup();

    require("mini.indentscope").setup({})
  end,
}
