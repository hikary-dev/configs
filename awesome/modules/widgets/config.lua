local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local config = {}

config.margin = {
    left = dpi(4),
    right = dpi(4),
    top = dpi(4),
    bottom = dpi(4),
}

return config
