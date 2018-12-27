-- Main menu configuration
-- standart awesome library
local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup").widget

--------------------------------------------------------------------------------

local M = {} --for menu

local myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end },
   { "manual", RC.vars.terminal .. " -x man awesome" },
   { "edit config", string.format("%s %s", RC.vars.editor, awesome.conffile) },
   { "edit theme", string.format("%s %s", RC.vars.editor, ".config/awesome/themes/cesious/theme.lua") },
   { "restart", awesome.restart }
}

local myexitmenu = {
   { "log out", function() awesome.quit() end, "/usr/share/icons/Arc-Maia/actions/24@2x/system-log-out.png" },
   { "suspend", "systemctl suspend", "/usr/share/icons/Arc-Maia/actions/24@2x/gnome-session-suspend.png" },
   { "hibernate", "systemctl hibernate", "/usr/share/icons/Arc-Maia/actions/24@2x/gnome-session-hibernate.png" },
   { "reboot", "systemctl reboot", "/usr/share/icons/Arc-Maia/actions/24@2x/view-refresh.png" },
   { "shutdown", "poweroff", "/usr/share/icons/Arc-Maia/actions/24@2x/system-shutdown.png" }
}

M.before = {
   { "Terminal", RC.vars.terminal, "/usr/share/icons/Adwaita/32x32/apps/utilities-terminal.png" },
   { "Browser", RC.vars.browser, "/usr/share/icons/hicolor/24x24/apps/chromium.png" },
   { "Files", RC.vars.filemanager, "/usr/share/icons/Adwaita/32x32/apps/system-file-manager.png" },
   -- other triads can be put here
}

M.after = {
   { "Awesome", myawesomemenu, "/usr/share/awesome/icons/awesome16.png" },
   { "Exit", myexitmenu, "/usr/share/icons/Arc-Maia/actions/24@2x/system-restart.png" },
   -- other triads can be put here
}


return M
