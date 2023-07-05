local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local function create_taglist(s)
    local update = function(self, c3, index, objects)
        local app_icons = {}
        for _, c in ipairs(c3:clients()) do
            if c.icon then
                local client_icon = wibox.widget.imagebox()
                client_icon.image = c.icon
                table.insert(app_icons, client_icon)
            end
        end

        if #app_icons > 0 then
            local layout = wibox.layout.fixed.horizontal()
            layout.spacing = dpi(2)

            for i = 1, #app_icons do
                layout:add(app_icon)
                --local app_icon = app_icons[i]
                --local margin = wibox.container.margin(app_icon, dpi(5), 5, dpi(5), dpi(5))
                --layout:add(margin)
            end

            self:set_widget(layout)
        end
    end

    local taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        widget_template = {
            {
                {
                    id = 'icon_role',
                    widget = wibox.widget.imagebox,
                },
                layout = wibox.layout.align.horizontal,
            },
            id = 'background_role',
            widget = wibox.container.background,
            update_callback = update,
            create_callback = update,
        },
        layout = {
            spacing = dpi(2),
            layout = wibox.layout.fixed.horizontal,
        },
    }

    return taglist
end

return create_taglist
