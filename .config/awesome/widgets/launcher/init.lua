local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

local list_widget = require("widgets.launcher.list")
local search_handler = require("widgets.launcher.search_handler")

local last_input = ""

local prompt_label = wibox.widget {
  {
    markup = "<span foreground='#aaaaaa'> </span>",
    font = "JetBrainsMono NF, ExtraLight 16",
    fg = "#6C7086",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
  },
  right = 3,
  left = 0,
  widget = wibox.container.margin
}

local my_prompt = awful.widget.prompt()


local search_bar_layout = wibox.widget {
  prompt_label,
  my_prompt,
  layout = wibox.layout.fixed.horizontal,
}

local rounded_rect = function(cr, width, height)
  return gears.shape.partially_rounded_rect(cr, width, height, true, true, true, true, 10)
end

local top_rounded_rect = function(cr, width, height)
  return gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, 10)
end


local screen_center_wibox = wibox {
  width = 800,
  height = 55,
  ontop = true,
  screen = awful.screen.focused(),
  visible = false,
  bg = beautiful.bg_normal,
  rad = 100,
  shape = rounded_rect,
  widget = wibox.container.margin(search_bar_layout, 20, 20, 10, 10)
}

local screen_geom = screen_center_wibox.screen.geometry
screen_center_wibox:geometry({
  x = (screen_geom.width - screen_center_wibox.width) / 2,
  y = screen_geom.height * 0.2,
})

local result_list_widget = list_widget.new(screen_center_wibox)

local function show_wibox_with_prompt()
  screen_center_wibox.visible = true

  awful.prompt.run {
    font                 = "Poppins SemiBold 14",
    textbox              = my_prompt.widget,
    exe_callback         = function(input)
      screen_center_wibox.visible = false
      result_list_widget:run()
      result_list_widget:toggle(false)
    end,
    done_callback        = function()
      screen_center_wibox.visible = false
      result_list_widget:toggle(false)
    end,

    keyreleased_callback = function(_, key, _)
      if key == "Up" then
        result_list_widget:navigate_up()
      elseif key == "Down" then
        result_list_widget:navigate_down()
      end
    end,

    changed_callback     = function(input)
      if input ~= "" then
        screen_center_wibox.shape = top_rounded_rect
      else
        screen_center_wibox.shape = rounded_rect
      end

      if input ~= last_input then
        last_input = input
        local current_text = input
        if current_text and #current_text > 0 then
          result_list_widget:toggle(true)
          local app_list = search_handler(current_text)

          result_list_widget:reset()

          if app_list and #app_list > 0 then
            result_list_widget:set_elements(app_list)
          else
            naughty.notify({ text = "No apps found." })
          end

          result_list_widget:emit_signal("widget::redraw_needed")
        end
      end
    end
  }
end

awesome.connect_signal("launcher::toggle", function()
  if screen_center_wibox.visible then
    screen_center_wibox.visible = false
    result_list_widget:toggle(false)
  else
    show_wibox_with_prompt()
  end
end)
