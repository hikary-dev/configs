local awful = require("awful")
local wibox = require("wibox")
local widgets = require("modules.widgets")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi

local panel = {}

function panel.setup_panel(s)
    s.panel = wibox({
        screen = s,
        type = "dock",
        position = "top",
    })

    s.panel.visible = true
    s.panel.stretch = false
    s.panel.width = s.geometry.width
    s.panel.height = dpi(28)

    s.panel:struts { top = dpi(28) }

    local right_widgets = wibox.layout.fixed.horizontal()
    right_widgets.spacing = dpi(2)
    right_widgets:add(widgets.time_widget(s))
    --right_widgets:add(widgets.volume(s))

    s.panel:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        widgets.active_app(s),
        widgets.taglist(s),
        right_widgets,
    }
end

awful.screen.connect_for_each_screen(function(s)
    panel.setup_panel(s)
    if s.index == 3 then
        gears.wallpaper.centered(beautiful.wallpaper, s)
    else 
        gears.wallpaper.maximized(beautiful.wallpaper, s)
    end
end)

return panel
