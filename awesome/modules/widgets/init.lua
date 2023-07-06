local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local taglist = require("modules.widgets.taglist")
local time_widget = require("modules.widgets.time_widget")
local active_app = require("modules.widgets.active_app")
local volume = require("modules.widgets.volume")


return {
    taglist = taglist,
    active_app = active_app,
    volume = volume,
    time_widget = time_widget
}
