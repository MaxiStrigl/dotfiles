local beautiful = require("beautiful")
local gears = require("gears")

local button = require("lib.button")

return button.create_image_onclick(gears.color.recolor_image(beautiful.arch_icon, "#1793d0"), beautiful.arch_icon, function()
  awesome.emit_signal("dashboard::toggle")
end)
