pcall(require, "luarocks.loader")
require("awful.autofocus")
hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
require("utils")
require("startup")

-- Variables
awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

config_path = gears.filesystem.get_configuration_dir()
local terminal = "alacritty"
local modkey = "Mod4"

-- Theme and Layouts
beautiful.init(config_path .. "theme/theme.lua")
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.fair,
    awful.layout.suit.max,
}

-- Modules
require("modules")

-- Key Bindings
root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

local globalkeys = awful.util.table.join(
    -- Hotkeys popup
    awful.key({ modkey }, "/", show_help, {description = "Hotkeys", group = "Awesome"}),

    -- Tag navigation
    awful.key({ modkey }, "Left", awful.tag.viewprev, {description = "Prev tag", group = "tag"}),
    awful.key({ modkey }, "Right", awful.tag.viewnext, {description = "Next tag", group = "tag"}),

    -- Client focus navigation
    awful.key({ modkey }, "Tab", function() change_focused_client(1) end, {description = "Change focused client to next", group = "Client"}),
    awful.key({ modkey, "Shift" }, "Tab", function() change_focused_client(-1) end, {description = "Change focused client to previous", group = "Client"}),

    -- AwesomeWM
    awful.key({ modkey, "Control" }, "r", awesome.restart, {description = "Reload awesome", group = "awesome"}),

    -- Layout navigation
    awful.key({ modkey }, "space", function() awful.layout.inc(1) end, {description = "Next layout", group = "layout"}),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end, {description = "Previous layout", group = "layout"}),

    -- Terminal and Applications
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end, {description = "Terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "Return", function() awful.spawn("alacritty --class alfloat") end, {description = "Float terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "p", function() awful.spawn("flameshot gui") end, {description = "Screenshot manager", group = "launcher"}),
    awful.key({ modkey }, "d", function() awful.spawn("rofi -show") end, {description = "Run prompt", group = "launcher"}),

    -- LockScreen
    awful.key({ modkey, "Control" }, "l", function () awful.spawn(config_path .. "scripts/lock.sh") end, {description = "Lock screen", group = "awesome"})

)

local clientkeys = gears.table.join(
    awful.key({ modkey }, "f", toggle_fullscreen, {description = "Toggle fullscreen", group = "Client"}),
    awful.key({ modkey }, "c", function(c) c:kill() end, {description = "Kill focused client", group = "Client"}),
    awful.key({ modkey }, "q", awful.client.floating.toggle, {description = "Toggle floating", group = "client"})
)

-- Tag navigation
for i = 1, 10 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9, function()
            tags[i]:view_only()
        end)
    )
end

-- Move client to tag
for i = 1, 10 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                client.focus:move_to_tag(tags[i])
            end
        end)
    )
end

-- Add or remove tag
for i = 1, 10 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            awful.tag.viewtoggle(tags[i])
        end)
    )
end

root.keys(globalkeys)
-- Signals 
client.connect_signal("request::titlebars", function(c)
    -- Установите рамку окна на ноль
    c.border_width = 0
end)

client.connect_signal("focus", function(c)
    c.shape = gears.shape.rounded_rect
end)

client.connect_signal("unfocus", function(c)
    c.shape = gears.shape.rounded_rect
end)

-- Rules
local clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

awful.rules.rules = {
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    { rule = { class = "vivaldi-sable" }, properties = { tags = {tags[1], tags[3], tags[5]} } },
    { rule = { class = "pycharm" }, properties = { tag = tags[2] } },
    { rule = { class = "telegram-desktop" }, properties = { tag = tags[3] } },
    { rule = { class = "discord" }, properties = { tag = tags[4] } },
    { rule = { class = "keepassxc" }, properties = { tag = tags[4] } },
    { rule = { class = "wireguird" }, properties = { tag = tags[6] } },
    { rule = { class = "Blueman-manager" }, properties = { tag = tags[6] } },
    { rule = { class = "Pavucontrol" }, properties = { tag = tags[6],  floating = false } },
    { rule = { class = "alwireguard" }, properties = { tag = tags[6] } },
    { rule = { class = "alfloat" }, properties = { floating = true, placement = awful.placement.top_right + awful.placement.right, ontop = true } }
}

-- Autostart
awful.spawn.with_shell(config_path .. "scripts/autorun.sh")

-- Garbage collector
gears.timer {
    timeout = 30,
    autostart = true,
    callback = function()
        collectgarbage()
    end
}

-- Mouse enter
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)


-- AutoLockScreen
awful.spawn.with_shell("xautolock -time 30 -locker 'betterlockscreen -l dim' &")

root.buttons(gears.table.join(
    awful.button({}, 1, function () awful.spawn.with_shell("xidlehook --poke") end)
))
