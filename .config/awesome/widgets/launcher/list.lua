local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naugty = require("naughty")

local dpi = require("beautiful.xresources").apply_dpi

local selected = 1
local suggestions = {}

-- Define list_widget
local list_widget = wibox.widget {
  spacing = dpi(8),
  layout = wibox.layout.fixed.vertical,
}

local separator = wibox.widget {
  forced_height = 1,
  color = "#515151",
  widget = wibox.widget.separator

}

-- Given a list of elements generate the list
function list_widget:set_elements(list)
  suggestions = list
  selected = 1
  list_widget:reset()

  list_widget:add(separator)

  for i, app in ipairs(list) do
    local item_layout = wibox.widget {
      {
        {
          {
            image = app.icon,
            forced_width = 30,
            forced_height = 30,
            expand = "none",
            align = "center",
            valign = "center",
            widget = wibox.widget.imagebox
          },
          {
            text = app.name,
            font = "Poppins, SemiBold 12",
            valign = "center",
            widget = wibox.widget.textbox
          },
          layout = wibox.layout.fixed.horizontal,
          spacing = 10,
        },
        top = dpi(12),
        bottom = dpi(12),
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
      },
      shape = gears.shape.rounded_rect,
      shape_border_color = "#BAC2DE50",
      bg = beautiful.bg_light,
      widget = wibox.container.background
    }

    if i == selected then
      item_layout.shape_border_width = 2
    end

    list_widget:add(item_layout)
  end
  return list_widget
end

function list_widget:navigate_down()
  list_widget.children[selected].shape_border_width = 0
  selected = selected + 1

  if selected > #list_widget.children then
    selected = 1
  end

  list_widget.children[selected].shape_border_width = 2
end

function list_widget:navigate_up()
  list_widget.children[selected].shape_border_width = 0
  selected = selected - 1

  if selected <= 0 then
    selected = #list_widget.children
  end

  list_widget.children[selected].shape_border_width = 2
end

function list_widget:run()
  suggestions[selected]:launch()
end

-- Return the constructed list_widget
return list_widget
