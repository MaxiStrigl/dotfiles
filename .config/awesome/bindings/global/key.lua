local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local gears = require("gears")
local apps = require("config.apps")
local naughty = require("naughty")
require("awful.hotkeys_popup.keys")

-- local apps = require('config.apps')
local mod = require("bindings.mod")

globalkeys = gears.table.join(
-- awesome keys

  awful.key({ mod.super, }, "s", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),

  awful.key({ mod.super, mod.ctrl }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),

  awful.key({ mod.super, mod.shift }, "q", awesome.quit,
    { description = "quit awesome", group = "awesome" }),

  -- TODO: add this to prompt
  awful.key({ mod.super }, "x",
    function()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    { description = "lua execute prompt", group = "awesome" }),

  awful.key({ mod.super }, "r", function()
      awesome.emit_signal("launcher::toggle")
    end,
    { description = "run prompt", group = "launcher" }),

  awful.key({ mod.super, }, "Return", function() awful.spawn(apps.terminal) end,
    { description = "open a terminal", group = "launcher" }),

  awful.key({}, "XF86AudioLowerVolume", function()
      awful.spawn.easy_async_with_shell("pactl set-sink-volume 0 -3%", function(stdout)
        awesome.emit_signal("popup::volume", { amount = -3 })
      end)
    end,
    { description = "lower volume", group = "launcher" }),

  awful.key({}, "XF86AudioRaiseVolume", function()
      awful.spawn.easy_async_with_shell("pactl set-sink-volume 0 +3%", function(stdout)
        awesome.emit_signal("popup::volume", { amount = 3 })
      end)
    end,
    { description = "raise volume", group = "launcher" }),

  awful.key({}, "XF86AudioMute", function()
      awful.spawn.easy_async_with_shell("pamixer -t", function(stdout)
        awesome.emit_signal("popup::volume")
      end)
    end,
    { description = "mute", group = "launcher" }),

  awful.key({}, "XF86MonBrightnessDown", function()
      awful.spawn.easy_async_with_shell("brightnessctl info", function(stdout)
        local value = tonumber(string.match(string.match(stdout, "%d+%%"), "%d+"))

        local decrease = 3

        if value == 3 then
          decrease = 2
        elseif value == 2 then
          decrease = 1
        elseif value < 2 then
          decrease = 0
        end

        awful.spawn.easy_async_with_shell("brightnessctl set " .. decrease .. "%- > /dev/null", function(stdout)
          awesome.emit_signal("popup::brightness", { amount = -decrease })
        end)
      end)
    end,
    { description = "decrease brightness", group = "launcher" }),


  awful.key({}, "XF86MonBrightnessUp", function()
      awful.spawn.easy_async_with_shell("brightnessctl set 3%+ > /dev/null", function(stdout)
        awesome.emit_signal("popup::brightness", { amount = 3 })
      end)
    end,

    { description = "increase brightness", group = "launcher" })
)

-- move between tags using arrow keys
globalkeys = gears.table.join(globalkeys,
  awful.key({ mod.super, }, "Left", awful.tag.viewprev,
    { description = "view previous", group = "tag" }),
  awful.key({ mod.super, }, "Right", awful.tag.viewnext,
    { description = "view next", group = "tag" }),
  awful.key({ mod.super, }, "Escape", awful.tag.history.restore,
    { description = "go back", group = "tag" })

)

-- focus keybinds

globalkeys = gears.table.join(globalkeys,
  --TODO: Implement alt tab

  awful.key({ mod.super, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "go back", group = "client" }),

  awful.key({ mod.super, mod.ctrl }, "j", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),

  awful.key({ mod.super, mod.ctrl }, "k", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),

  awful.key({ mod.super, mod.ctrl }, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", { raise = true }
        )
      end
    end,
    { description = "restore minimized", group = "client" }),


  awful.key({ mod.super, }, "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }
  ),
  awful.key({ mod.super, }, "k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }
  )
)


-- layout related
globalkeys = gears.table.join(globalkeys,
  awful.key({ mod.super, mod.shift }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),

  awful.key({ mod.super, mod.shift }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),

  awful.key({ mod.super, }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }),

  awful.key({ mod.super, }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),

  awful.key({ mod.super, }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),

  awful.key({ mod.super, mod.shift }, "h", function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }),

  awful.key({ mod.super, mod.shift }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }),

  awful.key({ mod.super, mod.ctrl }, "h", function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }),

  awful.key({ mod.super, mod.ctrl }, "l", function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }),

  awful.key({ mod.super, }, "space", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),

  awful.key({ mod.super, mod.shift }, "space", function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }))



for i = 1, 4 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ mod.super }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = "view tag #" .. i, group = "tag" }),

    -- Toggle tag display.
    awful.key({ mod.super, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),

    -- Move client to tag.
    awful.key({ mod.super, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }),

    -- Toggle tag on focused client.
    awful.key({ mod.super, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

root.keys(globalkeys)
