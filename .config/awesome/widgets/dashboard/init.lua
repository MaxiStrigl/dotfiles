local naughty = require("naughty")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local keygrabber = require("awful.keygrabber")

local dashboard_grabber

-- Create the widget
local dashboard = wibox({ visible = false, ontop = true, type = "dock", screen = screen.primary })
awful.placement.maximize(dashboard)

dashboard.bg = beautiful.dashboard_bg or beautiful.exit_screen_bg or beautiful.wibar_bg or "#111111"
dashboard.fg = beautiful.dashboard_fg or beautiful.exit_screen_fg or beautiful.wibar_fg or "#FEFEFE"


local function screen_mask(s, bg)
  local mask = wibox({ visible = false, ontop = true, type = "splash", screen = s })
  awful.placement.maximize(mask)
  mask.bg = bg
  return mask
end

local function set_visibility(v)
  for s in screen do
    s.dashboard.visible = v
  end
end

local function dashboard_hide()
  keygrabber.stop(dashboard_grabber)
  set_visibility(false)
end

-- Add dashboard or mask to each screen
awful.screen.connect_for_each_screen(function(s)
  if s == screen.primary then
    s.dashboard = dashboard
  else
    s.dashboard = screen_mask(s, dashboard.bg)
  end
end)

awesome.connect_signal("dashboard::toggle", function()
  dashboard_grabber = keygrabber.run(function(_, key, event)
    if event == 'release' then return end
    if key == 'Escape' or key == 'q' then
      dashboard_hide()
    end
  end)
  set_visibility(true)
end)
