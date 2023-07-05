local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local config = require("modules.widgets.config")

local function create_taglist(s)
    local raw_taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = awful.util.table.join(
            awful.button({}, 1, function(t) t:view_only() end)
        ),
        widget_template = {
            {
                {
                    id = 'text_role',
                    widget = wibox.widget.textbox,
                    align  = "center",
                },
                widget = wibox.container.place,
            },
            id = 'background_role',
            widget = wibox.container.background,
            forced_width = dpi(30),
            forced_height = dpi(30),
            shape = gears.shape.rounded_rect,
            bg = beautiful.widgets_background,
        },
    }
    local taglist = wibox.container.margin(raw_taglist, config.margin.left, config.margin.right, config.margin.top, config.margin.bottom)

    return taglist
end

return create_taglist
