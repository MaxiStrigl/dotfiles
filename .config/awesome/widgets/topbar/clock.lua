local wibox = require("wibox")
local beautiful = require("beautiful")

local clock_format = "%A %B %d, %H:%M"

local clock = wibox.widget.textclock()
clock.font = "poppins, SemiBold 12"
clock.format = "<span foreground='#fefefe'>"..clock_format.."</span>"

return clock
