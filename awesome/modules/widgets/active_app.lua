local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local config = require("modules.widgets.config")
local dpi = beautiful.xresources.apply_dpi

local function create_active_app_widget(s)
    local appicon = wibox.widget.imagebox()
    local appname = wibox.widget {
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox,
        font = beautiful.widget_font_base .. '8',
    }

    local icon_margin = wibox.container.margin(appicon, config.margin.left + dpi(10), config.margin.right - dpi(6), config.margin.top, config.margin.bottom)
    local text_margin = wibox.container.margin(appname, config.margin.left, config.margin.right + dpi(10), config.margin.top, config.margin.bottom)

    local active_app_widget = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        icon_margin,
        text_margin,
    }

    local update_widget = function()
        local c = client.focus
        if c ~= nil then
            appname.text = " " .. c.name .. " "
            if c.icon then
                appicon:set_image(gears.surface.load_uncached(c.icon))
            else
                appicon:set_image(gears.surface.load_uncached(beautiful.widget_default_icon))
            end
        end
    end

    update_widget()
    client.connect_signal("focus", function(c)
        update_widget()
    end)

    local active_app_widget_layout = wibox.container.place(active_app_widget)
    active_app_widget_layout.halign = "center"
    active_app_widget_layout.valign = "center"

    local active_app_background = wibox.widget {
        {
            active_app_widget_layout,
            widget = wibox.container.background,
            shape = gears.shape.rounded_rect,
            forced_width = dpi(200),
            bg = beautiful.widgets_background,
        },
        widget = wibox.container.margin,
        left = config.margin.left,
        right = config.margin.right,
        top = config.margin.top,
        bottom = config.margin.bottom,
    }

    return active_app_background
end

return create_active_app_widget
