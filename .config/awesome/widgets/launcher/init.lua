local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

local list_widget = require("widgets.launcher.list")
local search_handler = require("widgets.launcher.search_handler")

local dpi = require("beautiful.xresources").apply_dpi

local last_input = ""
local placeholder_text = "Type your command here..."

local prompt_label = wibox.widget {
  {
    image = gears.color.recolor_image(beautiful.search_icon, "#67687A"),
    forced_width = 27,
    forced_height = 27,
    align = "center",
    valign = "center",
    widget = wibox.widget.imagebox
  },
  align = "center",
  valign = "center",

  widget = wibox.container.place
}

local my_prompt = awful.widget.prompt()

local placeholder_widget = wibox.widget {
  markup = '<span color="#888888">' .. placeholder_text .. '</span>', -- You can customize the color
  font = beautiful.prompt_font,
  widget = wibox.widget.textbox,
}

local centered_prompt = wibox.widget {
  {
    {
      my_prompt,
      placeholder_widget,
      layout = wibox.layout.stack,
    },
    top = dpi(3),
    widget = wibox.container.margin
  },
  valign = "center",
  widget = wibox.container.place
}

local search_bar_layout = wibox.widget {
  {
    prompt_label,
    centered_prompt,
    forced_height = 55,
    forced_width = 800,
    spacing = dpi(6),
    layout = wibox.layout.fixed.horizontal,
  },
  left = dpi(10),
  widget = wibox.container.margin
}

local rounded_rect = function(cr, width, height)
  return gears.shape.partially_rounded_rect(cr, width, height, true, true, true, true, 15)
end

local launcher_widget = wibox.widget {
  {
    search_bar_layout,
    {
      list_widget,
      top = 0,
      left = 10,
      right = 10,
      bottom = 10,
      widget = wibox.container.margin,
    },
    spacing = 0,
    layout = wibox.layout.fixed.vertical,
  },
  forced_height = 55,
  bg = beautiful.bg_normal,
  widget = wibox.container.background,
}

local screen_center_wibox = wibox {
  width = 800,
  height = 55,
  ontop = true,
  screen = awful.screen.focused(),
  visible = false,
  bg = beautiful.bg_normal,
  rad = 100,
  shape = rounded_rect,
  border_width = 1,
  border_color = "#515151",
  -- widget = wibox.container.margin(search_bar_layout, dpi(10), dpi(10), dpi(5), dpi(5)),
  widget = launcher_widget
}

local screen_geom = screen_center_wibox.screen.geometry
screen_center_wibox:geometry({
  x = (screen_geom.width - screen_center_wibox.width) / 2,
  y = screen_geom.height * 0.2,
})

local function show_wibox_with_prompt()
  screen_center_wibox.visible = true

  awful.prompt.run {
    font                 = beautiful.prompt_font,
    textbox              = my_prompt.widget,
    exe_callback         = function(_)
      screen_center_wibox.visible = false
      screen_center_wibox.height = 55
      placeholder_widget.visible = true
      list_widget:run()
    end,
    done_callback        = function()
      screen_center_wibox.visible = false
      screen_center_wibox.height = 55
      placeholder_widget.visible = true
    end,

    keyreleased_callback = function(_, key, _)
      if key == "Up" then
        list_widget:navigate_up()
      elseif key == "Down" then
        list_widget:navigate_down()
      end
    end,

    changed_callback     = function(input)
      if input ~= "" then
        placeholder_widget.visible = false
        screen_center_wibox.height = 500
      else
        screen_center_wibox.height = 55
        placeholder_widget.visible = true
      end


      if input ~= last_input then
        last_input = input
        local current_text = input
        if current_text and #current_text > 0 then
          local app_list = search_handler(current_text)

          list_widget:reset()

          if app_list and #app_list > 0 then
            list_widget:set_elements(app_list)
          else
            naughty.notify({ text = "No apps found." })
          end

          list_widget:emit_signal("widget::redraw_needed")
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
