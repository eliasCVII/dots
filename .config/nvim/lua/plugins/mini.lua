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
      mappings = {
        toggle_info    = '<S-Tab>',
        toggle_preview = '<Tab>',
        move_down      = '<C-j>',
        move_up        = '<C-k>',
      }
    })

    -- Bracket movement
    require("mini.bracketed").setup() -- TODO: learn mappings

    -- Remove whitespace
    require("mini.trailspace").setup()

    -- Extra features
    require("mini.extra").setup() -- TODO: add keymap for pickers: hipattern, git_, buf_line

    -- Highlight indent scope
    require("mini.indentscope").setup({})

    require("mini.tabline").setup() -- TODO: fuk this

    require("mini.bufremove").setup()

    require("mini.diff").setup({
      view = {
        style = 'sign',
        signs = { add = '', change = '', delete = '' }
      }
    })

    local miniclue = require('mini.clue')
    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = { 'n', 'x' }, keys = '<Leader>' },

        -- `[` and `]` keys
        { mode = 'n',          keys = '[' },
        { mode = 'n',          keys = ']' },

        -- Built-in completion
        { mode = 'i',          keys = '<C-x>' },

        -- `g` key
        { mode = { 'n', 'x' }, keys = 'g' },

        -- Marks
        { mode = { 'n', 'x' }, keys = "'" },
        { mode = { 'n', 'x' }, keys = '`' },

        -- Registers
        { mode = { 'n', 'x' }, keys = '"' },
        { mode = { 'i', 'c' }, keys = '<C-r>' },

        -- Window commands
        { mode = 'n',          keys = '<C-w>' },

        -- `z` key
        { mode = { 'n', 'x' }, keys = 'z' },
      },

      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
    })

    local hipatterns = require('mini.hipatterns')
    hipatterns.setup({
      highlighters = {
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        idea      = { pattern = '%f[%w]()IDEA()%f[%W]', group = 'MiniHipatternsNote' },
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
  end,
}
