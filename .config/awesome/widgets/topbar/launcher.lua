local beautiful = require("beautiful")

local button = require("lib.button")

local launcher = button.create_text(beautiful.fg_dark, beautiful.fg_focus, "", 14, function()
    awesome.emit_signal("launcher::toggle")
end)

launcher.forced_width = 24

return launcher
