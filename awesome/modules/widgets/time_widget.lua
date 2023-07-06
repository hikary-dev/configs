local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local config = require("modules.widgets.config")
local dpi = beautiful.xresources.apply_dpi

local function create_time_widget(s)
    local date_widget_text = wibox.widget.textclock("%a, %b %d ")
    date_widget_text.font = beautiful.widget_font
    local date_widget_icon_base = wibox.widget {
        image  = beautiful.widget_calendar_icon,
        resize = true,
        forced_width = dpi(16),
        forced_height = dpi(16),
        widget = wibox.widget.imagebox,
    }
    local date_widget_icon = wibox.container.margin(date_widget_icon_base, config.margin.left, config.margin.right, config.margin.top + 1, config.margin.bottom)

    local time_widget_text = wibox.widget.textclock("%H:%M")
    time_widget_text.font = beautiful.widget_font
    local time_widget_icon_base = wibox.widget {
        image  = beautiful.widget_clock_icon,
        resize = true,
        forced_width = dpi(16),
        forced_height = dpi(16),
        widget = wibox.widget.imagebox
    }
    local time_widget_icon = wibox.container.margin(time_widget_icon_base, config.margin.left, config.margin.right - 3, config.margin.top + 1, config.margin.bottom)

    local time_widget = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        date_widget_icon,
        date_widget_text,
        time_widget_icon,
        time_widget_text,
    }

    local time_widget_layout = wibox.container.place(time_widget)
    time_widget_layout.halign = "center"
    time_widget_layout.valign = "center"

    local time_background = wibox.widget {
        screen=s,
        {
            time_widget_layout,
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

    return time_background
end

return create_time_widget
