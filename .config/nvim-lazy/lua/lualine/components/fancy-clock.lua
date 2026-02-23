local component = require("lualine.component"):extend()

local clocks = {
  "󰔟 ",
  "󱦟 ",
}

local spinner_count = 1

local function get_spinner(icons)
  local spinner = icons[spinner_count]
  spinner_count = spinner_count + 1
  if spinner_count > #icons then
    spinner_count = 1
  end
  return spinner .. os.date("%H:%M")
end

component.init = function(self, options)
  component.super.init(self, options)
end

component.update_status = function(self)
  return get_spinner(clocks)
end

return component
