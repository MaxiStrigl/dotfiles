local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi

local color = beautiful.bg_normal

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

local session = require("widgets.topbar.session")
local taglist = require("widgets.topbar.taglist")
local clock = require('widgets.topbar.clock')
local launcher = require("widgets.topbar.launcher")


beautiful.systray_icon_spacing = dpi(12)
local systray = wibox.widget.systray()


awful.screen.connect_for_each_screen(function(s)
  s.topbar = awful.wibar({
    screen = s,
    position = beautiful.bar_position,
    height = beautiful.bar_height,
    type = "dock",
    bg = color,
  })

  local bar_taglist = taglist.init(s)

  s.topbar:setup {
    layout = wibox.layout.align.horizontal,
    spacing = dpi(10),
    expand = "none",
    { -- left
      widget(session),
      bar_taglist,
      layout = wibox.layout.fixed.horizontal, },
    { layout = wibox.layout.fixed.horizontal, },
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
      layout = wibox.layout.fixed.horizontal, }

  }
end)
