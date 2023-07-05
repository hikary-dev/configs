local executer = require("modules/executer")

executer.execute_commands({
  "nm-applet",
  "blueman-applet",
  "volumeicon",
  "xset r rate 250 40",
  "setxkbmap -option 'grp:alt_shift_toggle' us,ru",
  "feh --bg-scale ~/wallpapers/wallpaper.jpg"
})
