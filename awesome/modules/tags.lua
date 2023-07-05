local awful = require("awful")
local sharedtags = require("lib.sharedtags")

local tags = sharedtags({
    { name = "1", screen = 1, layout = awful.layout.layouts[2] },
    { name = "2", screen = 1, layout = awful.layout.layouts[3] },
    { name = "3", screen = 3, layout = awful.layout.layouts[5] },
    { name = "4", screen = 2, layout = awful.layout.layouts[5] },
    { name = "5", screen = 2, layout = awful.layout.layouts[5] },
    { name = "6", screen = 1, layout = awful.layout.layouts[3] },
    { name = "7", screen = 1, layout = awful.layout.layouts[2] },
    { name = "8", screen = 2, layout = awful.layout.layouts[2] },
    { name = "9", screen = 2, layout = awful.layout.layouts[2] },
    { name = "10", screen = 1, layout = awful.layout.layouts[2] },
})

return tags
