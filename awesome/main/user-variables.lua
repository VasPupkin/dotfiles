-- Standard Awesome Library
local awful = require("awful")
-- Variable definitions
----------------------------------------------------------------------------------------------------
--- my variables
local home_dir = os.getenv("HOME")

local _M ={
   terminal = "gnome-terminal",
   editor = os.getenv("EDITOR") or "nano",
      -- browser = terminal .. " -e lynx ",
   browser = "firefox",
   config_dir = awful.util.getdir("config"),
--   config_dir = "/home/emalkov/.config/awesome/",
--   theme_dir = awful.util.getdir("config").."themes/",
   theme_dir = awful.util.getdir("config").."themes/",
   theme_selected = awful.util.getdir("config").."themes/edited/theme.lua",
   wallpaper_dir = awful.util.getdir("config").."themes/wallpapers/",
   script_dir = awful.util.getdir("config").."scripts/",
   icon_dir = awful.util.getdir("config").."themes/icons/22x22/",

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
   modkey = "Mod4",

}

return _M
