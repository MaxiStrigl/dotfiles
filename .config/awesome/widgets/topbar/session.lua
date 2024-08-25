local beautiful = require("beautiful")

local button = require("lib.button")

return button.create_image_onclick(beautiful.arch_icon, beautiful.arch_icon, function()
  awesome.emit_signal("launcher::toggle")
end)
