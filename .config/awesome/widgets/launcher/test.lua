local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local rounded_rect = function(cr, width, height)
  return gears.shape.rounded_rect(cr, width, height, 15)
end

local test_widget = wibox.widget {
    {
        {
            {
                text   = "This is a test widget",
                align  = "center",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            margins = 10,
            widget  = wibox.container.margin,
        },
        bg = beautiful.bg_focus or "#3498db",  -- Fallback color if bg_focus is not defined in your theme
        shape = rounded_rect,
        widget = wibox.container.background,
    },
  ontop = true,
    margins = 6,
    widget = wibox.container.margin,
}

return test_widget

