local awful = require("awful")
local gears = require("gears")

local set_wallpaper = function()
  local hour = os.date("*t").hour

  if hour >= 8 and hour < 12 then
    awful.spawn.with_shell("feh --bg-scale ~/dotfiles/wallpapers/morning.jpg")
  elseif hour >= 12 and hour < 18 then
    awful.spawn.with_shell("feh --bg-scale ~/dotfiles/wallpapers/day.jpg")
  elseif hour >= 18 and hour < 22 then
    awful.spawn.with_shell("feh --bg-scale ~/dotfiles/wallpapers/evening.jpg")
  else
    awful.spawn.with_shell("feh --bg-scale ~/dotfiles/wallpapers/night.jpg")
  end
end

function minutes_until_next_hour()
  local current_time = os.date("*t")

  local minutes_until = 60 - current_time.min

  return minutes_until
end

function time_until_hour(target_hour)
  -- Get the current time
  local current_time = os.date("*t")
  local current_hour = current_time.hour

  -- Calculate the hours until the target hour
  local hours_until = target_hour - current_hour

  -- If the target hour has already passed today, calculate for the next day
  if hours_until < 0 then
    hours_until = hours_until + 24
  end

  return hours_until
end

local get_next_timeout = function()
  local minutes = minutes_until_next_hour()
  local hours = 0

  local hour = os.date("*t").hour

  if hour >= 8 and hour < 12 then
    hours = time_until_hour(12)
  elseif hour >= 12 and hour < 18 then
    hours = time_until_hour(18)
  elseif hour >= 18 and hour < 22 then
    hours = time_until_hour(22)
  else
    hours = time_until_hour(8)
  end

  return hours * minutes * 60
end

local wallpaper_timer = gears.timer({ timeout = get_next_timeout() })
wallpaper_timer:connect_signal("timeout", function()
  set_wallpaper()
  wallpaper_timer.timeout = get_next_timeout()
  wallpaper_timer:again()
end)

set_wallpaper()
wallpaper_timer:start()
