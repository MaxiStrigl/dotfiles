pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
require("awful.hotkeys_popup.keys")


require("config.error_handling")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")


-- init configs
require("config.layout")
require("config.tags")
require("config.wallpaper")

require("bindings")
require("rules")

-- init widgets
require("widgets.topbar")
require("widgets.launcher")


-- {{{ Mouse bindings
root.buttons(gears.table.join(
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))
-- }}}


-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  c.shape = gears.shape.rounded_rect

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

--client.connect_signal("manage", function (c)
    -- c.shape = function(cr,w,h)
    --     gears.shape.rounded_rect(cr,w,h,5)
    -- end
-- end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
