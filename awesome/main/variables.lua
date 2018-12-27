-- Varibale definitions
--------------------------------------------------------------------------------
-- Standard awesome library
local awful = require("awful")

local home_dir = os.getenv("HOME")

local M = {
   -- This is used later as the default terminal and editor to run.
   terminal = "xfce4-terminal",
   browser = "chromium",
   filemanager = "thunar",
   editor = "mousepad",
   
   -- Default modkey.
   -- Usually, Mod4 is the key with a logo between Control and Alt.
   -- If you do not like this or do not have such a key,
   -- I suggest you to remap Mod4 to another key using xmodmap or other tools.
   -- However, you can use another modifier like Mod1, but it may interact with others.
   modkey = "Mod4",
   
   -- files & dirs
   config_dir = awful.util.getdir("config"),
   --theme_dir = awful.util.getdir("config").."themes/",
   --theme_selected = awful.util.getdir("config").."themes/edited/theme.lua",
   --wallpaper_dir = awful.util.getdir("config").."themes/wallpapers/",
   --script_dir = awful.util.getdir("config").."scripts/",
   --icon_dir = awful.util.getdir("config").."themes/icons/22x22/",
}

return M
