local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi

local color = beautiful.bg_normal

local type = 0

local widget = function(inner_widget)
  return wibox.widget {
    widget = wibox.container.margin,
    top = dpi(beautiful.bar_item_padding + 1),
    bottom = dpi(beautiful.bar_item_padding + 1),
    left = dpi(4),
    right = dpi(4),
    {
      inner_widget,
      layout = wibox.layout.fixed.horizontal
    }
  }
end

local corner = wibox.widget {
  image = gears.color.recolor_image(beautiful.left_corner, beautiful.bg_normal),
  forced_width = dpi(10),
  forced_height = dpi(10),
  valign = "center",
  align = "center",
  widget = wibox.widget.imagebox,
}

local corner_right = wibox.widget {
  image = gears.color.recolor_image(beautiful.right_corner, beautiful.bg_normal),
  forced_width = dpi(10),
  forced_height = dpi(10),
  valign = "center",
  align = "center",
  widget = wibox.widget.imagebox,
}

local session = require("widgets.topbar.session")
local taglist = require("widgets.topbar.taglist")
local clock = require('widgets.topbar.clock')
local launcher = require("widgets.topbar.launcher")

beautiful.systray_icon_spacing = dpi(12)
local systray = wibox.widget.systray()

awful.screen.connect_for_each_screen(function(s)
  local bar_taglist = taglist.init(s)

  local bar_content = {
    layout = wibox.layout.align.horizontal,
    spacing = dpi(10),
    expand = "none",
    { -- left
      widget(session),
      bar_taglist,
      layout = wibox.layout.fixed.horizontal,
    },
    {
      layout = wibox.layout.fixed.horizontal,
      corner,
    },
    {
      widget(wibox.widget {
        widget = wibox.container.margin,
        top = dpi(1),
        bottom = dpi(1),
        {
          systray,
          layout = wibox.layout.fixed.horizontal,
        }
      }),
      clock,
      widget(launcher),
      layout = wibox.layout.fixed.horizontal,
    }
  }

  if type == 0 or type == 1 then
    -- Create the top bar
    s.topbar = awful.wibar({
      screen = s,
      position = "top",
      height = beautiful.bar_height,
      type = "dock",
      bg = color,
    })


    s.topbar:setup(bar_content)

    if type == 1 then
      -- Create the bar directly below the top bar
      s.lowerbar = awful.wibar {
        screen = s,
        width = s.geometry.width, -- Width of the screen
        height = dpi(10),         -- Height of the new bar
        x = 0,
        y = beautiful.bar_height, -- Position it right below the top bar
        bg = "#FF000000",         -- Red color
        type = "dock",            -- Makes it behave like a dock
        ontop = false,            -- Ensures it stays below the topbar
      }

      s.lowerbar:setup {
        layout = wibox.layout.align.horizontal,
        corner,
        nil,
        corner_right,
      }
    end
  elseif type == 2 then
    s.topbar = awful.wibar({
      position = "top",
      screen = s,
      bg = "#EE0000",
      width = s.geometry.width - beautiful.useless_gap * 2,
      height = dpi(20),
      shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 10)
      end
    })

    awful.placement.top(s.mywibox, { margins = beautiful.useless_gap * 2 })
    s.padding = { top = s.padding.bottom + beautiful.useless_gap * 2 }
  end
end)
