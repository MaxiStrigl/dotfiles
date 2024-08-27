local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local dpi = require("beautiful.xresources").apply_dpi

local suggestions_widget = {}
local suggestions = {}

local selected = 1

-- layout for the list of search results
local list_layout = wibox.widget {
  -- spacing = dpi(12),
  layout = wibox.layout.fixed.vertical()
}

local bottom_rounded_rect = function(cr, width, height)
  return gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true)
end

-- the widget that holds all the list items
local list_widget = wibox {
  width = 800,
  height = 240,
  ontop = true,
  screen = awful.screen.focused(),
  visible = false,
  bg = beautiful.bg_normal,
  shape = bottom_rounded_rect,
  border_width = 1,
  border_color = "#515151",
  -- widget = wibox.container.margin(list_layout, 20, 20, 10, 10)
  widget = wibox.container.margin(list_layout, 0, 0, 0, 0)
}

-- reset the list
function list_widget:reset()
  for _ = 1, #list_layout.children do
    list_layout.remove(#list_layout.children)
  end
  selected = 1
end

-- -- position of the list_widget
-- local prompt_geom = screen_center_wibox:geometry()
-- list_widget:geometry({
--   x = prompt_geom.x,
--   y = prompt_geom.y + screen_center_wibox.height
-- })

-- hide or show the list_widget
function list_widget:toggle(visible)
  self.visible = visible
end

-- given a list of elements generate the list
function list_widget:set_elements(list)
  suggestions = list
  list_layout:reset()

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
        top = dpi(10),
        bottom = dpi(10),
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
      },
      widget = wibox.container.background
    }

    if i == selected then
      item_layout.bg = beautiful.bg_light
    end

    list_layout:add(item_layout)
  end
  return list_widget
end

function list_widget:navigate_down()
  list_layout.children[selected].bg = beautiful.bg_normal
  selected = selected + 1

  if selected > #list_layout.children then
    selected = 1
  end

  list_layout.children[selected].bg = beautiful.bg_light
end

function list_widget:navigate_up()
  list_layout.children[selected].bg = beautiful.bg_normal
  selected = selected - 1

  if selected <= 0 then
    selected = #list_layout.children
  end

  list_layout.children[selected].bg = beautiful.bg_light
end

function list_widget:run()
  suggestions[selected]:launch()
end

-- add an element to the list, with it's text, icon TODO: exec path and (description)
function list_widget:add_element(text, icon)
  local item_layout = wibox.widget {
    {
      image = icon,
      forced_width = 30,
      forced_height = 30,
      expand = "none",
      widget = wibox.widget.imagebox
    },
    {
      text = text,
      font = "Poppins, SemiBold 12",
      widget = wibox.widget.textbox

    },
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
  }

  list_layout:add(item_layout)
end

return list_widget
