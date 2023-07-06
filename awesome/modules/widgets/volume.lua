local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local config = require("modules.widgets.config")
local dpi = beautiful.xresources.apply_dpi

local function get_current_volume()
    -- Replace this with your function to get the current volume level
    return 50
end

local function create_volume_widget(s)
    local volume_level = get_current_volume()
    local volume_widget_text = wibox.widget {
        text = tostring(volume_level),
        font = beautiful.widget_font,
        widget = wibox.widget.textbox,
    }
    local volume_widget_icon_base = wibox.widget {
        image  = beautiful.widget_volume_icon,
        resize = true,
        forced_width = dpi(16),
        forced_height = dpi(16),
        widget = wibox.widget.imagebox,
    }
    local volume_widget_icon = wibox.container.margin(volume_widget_icon_base, config.margin.left, config.margin.right, config.margin.top + 1, config.margin.bottom)

    local volume_widget_bar = wibox.widget {
        max_value = 100,
        value = volume_level,
        forced_height = dpi(10),
        forced_width = dpi(100),
        bar_shape = gears.shape.rounded_bar,
        color = beautiful.widget_volume_bar_color,
        background_color = beautiful.widget_volume_bar_bg_color,
        border_width = 0,
        widget = wibox.widget.progressbar,
    }

    local volume_widget = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        volume_widget_icon,
        volume_widget_text,
        volume_widget_bar,
    }

    local volume_widget_layout = wibox.container.place(volume_widget)
    volume_widget_layout.halign = "center"
    volume_widget_layout.valign = "center"

    local volume_background = wibox.widget {
        screen=s,
        {
            volume_widget_layout,
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

    return volume_background
end

return create_volume_widget
