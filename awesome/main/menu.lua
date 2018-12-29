-- home menu configuration
-- standart awesome library
local awful = require("awful")
local beautiful = require("beautiful")

----------------------------------------------------------------------------------------------------

local M = {}  -- menu
local _M = {} -- module

----------------------------------------------------------------------------------------------------
-- local variables  temporary from rc.lua
--- my variables
local terminal = "gnome-terminal"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor
-- browser = terminal .. " -e lynx "
-- browser = "firefox"
--------NEW-----------------------------------------
-- markup            = lain.util.markup
local home_dir          = os.getenv("HOME")
local config_dir        = awful.util.getdir("config")
local theme_dir         = config_dir.."/themes/"
-- local wallpaper_dir     = theme_dir.."/wallpapers/"
local script_dir        = config_dir.."/scripts/"
local icon_dir          = theme_dir.."/icons/22x22/"

----------------------------------------------------------------------------------------------------

-- {{{ Menu
-- Create a launcher widget and a main menu

M.awesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end, icon_dir .."/actions/preferences-desktop-keyboard-shortcuts.png"},
   { "manual", terminal .. " -e 'man awesome'", icon_dir .."/actions/help-contents.png" },
   --   { "edit config", editor_cmd .." ".. config_dir .."/rc.lua" },
   { "restart", awesome.restart, icon_dir .."/actions/view-refresh.png" },
   { "quit", function() awful.util.spawn_with_shell("".. script_dir .."exit.sh") end, icon_dir .."/actions/application-exit.png" },
}

-- cinnamon menu items
M.cinnamonmenu = {
   { "Control Center" , "cinnamon-control-center", icon_dir .. "/categories/preferences-desktop.png" },
   { "Settings" , "cinnamon-settings", icon_dir .. "/categories/preferences-other.png" },
}

-- office menu items
M.officemenu = {
   { "Emacs", "emacs", icon_dir .."/apps/emacs.png" },
   { "Text editor", "xed", icon_dir .."/apps/accessories-text-editor.png" },
   { "Libre Office", "libreoffice", icon_dir .."/mimetypes/text-x-generic-template.png" },
   { "LO Writer", "libreoffice --writer", icon_dir .."/mimetypes/x-office-document.png" },
   { "LO Calc", "libreoffice --calc", icon_dir .."/mimetypes/x-office-spreadsheet.png" },
   { "LO Draw", "libreoffice --draw", icon_dir .."/mimetypes/x-office-drawing.png" },
   { "LO Impress", "libreoffice --impress", icon_dir .."/mimetypes/x-office-presentation.png" },
   { "Pdfmod", "pdfmod", icon_dir .."/mimetypes/application-pdf.png" },
   { "Scan to Pdf", "gscan2pdf", icon_dir .."/apps/scanner.png" },
   { "FB Reader", "FBReader", icon_dir .."/apps/fbreader.png" },
}

-- Graphics menu
M.graphicsmenu = {
   { "Gimp", "gimp", icon_dir .."/apps/gimp.png" },
   { "Dark Table", "darktable", icon_dir .."/apps/darktable.png" },
   { "Blender", "blender", icon_dir .."/apps/blender.png" },
   { "Pix", "pix", icon_dir .."/apps/pix.png" },
}
-- goog gmrs submenu
M.goggames = {
   { "Baldurs Gate EE", "'/home/vozgen/Games/Baldurs Gate Enhanced Edition/start.sh'", icon_dir .."/games/bg1.png" },
   { "Baldurs Gate 2 EE", "'/home/vozgen/Games/Baldurs Gate 2 Enhanced Edition/start.sh'", icon_dir .."/games/bg2.png" },
   { "Balrum", "'/home/vozgen/Games/Balrum/start.sh'", icon_dir .."/games/balrum.png" },
   { "Door Kickers", "'/home/vozgen/Games/Door Kickers/start.sh'", icon_dir .."/games/dkickers.png" },
   { "Enter the Gungeon", "'/home/vozgen/Games/Enter the Gungeon/start.sh'", icon_dir .."/games/entergungeon.png" },
   { "Eschalon Book I", "'/home/vozgen/Games/Eschalon Book I/start.sh'", icon_dir .."/games/eschalon.png" },
   { "Eye of the Beholder", "'/home/vozgen/Games/Eye of the Beholder/start.sh'", icon_dir .."/games/eob.png" },
   { "Halcyon 6 Starbase Commander", "'/home/vozgen/Games/Halcyon 6 Starbase Commander/start.sh'", icon_dir .."/games/halcyon.png" },
   { "Icewind Dale EE", "'/home/vozgen/Games/Icewind Dale Enhanced Edition/start.sh'", icon_dir .."/games/iwd.png" },
--   { "", "'/home/vozgen/Games//start.sh'" },
   { "Paper Sorcerer", "'/home/vozgen/Games/PaperSorcerer/start.sh'", icon_dir .."/games/papersorceror.png" },
   { "Papers, PLease", "'/home/vozgen/Games/Papers, Plaese/launch.sh'", icon_dir .."/games/papiers.png" },
   { "Darkest Dungeon", "'/home/vozgen/Games/Darkest Dungeon/start.sh'", icon_dir .."/games/ddungeon.png" },
   { "Tyranny", "/home/vozgen/Games/Tyranny/start.sh", icon_dir .."/games/tyranny.png" },
   { "Pillars of Eternity", "'/home/vozgen/Games/Pillars of Eternity/start.sh'", icon_dir .."/games/pillars.png" },
   { "Planescape Torment EE", "'/home/vozgen/Games/Planescape Torment Enhanced Edition/start.sh'", icon_dir .."/games/planescape.png" },
   { "Torment Tides of Numenera", "'/home/vozgen/Games/Torment Tides of Numenera/start.sh'", icon_dir .."/games/torment.png" },
   { "Torchlight 2", "'/home/vozgen/Games/Torchlight 2/start.sh'", icon_dir .."/games/torchlight.png" },
   { "Terraria", "'/home/vozgen/Games/Terraria/start.sh'", icon_dir .."/games/terraria.png" },
   { "This War Of Mine", "'/home/vozgen/Games/This War Of Mine/start.sh'", icon_dir .."/games/warmine.png" },
   { "Starbound", "'/home/vozgen/Games/Starbound/start.sh'", icon_dir .."/games/starbound.png" },
   { "Star Crawlers", "'/home/vozgen/Games/StarCrawlers/start.sh'", icon_dir .."/games/starcrawlers.png" },
   { "Stardew Valley", "'/home/vozgen/Games/Stardew Valley/start.sh'", icon_dir .."/games/stardew.png" },
   { "stellaris_v1.6.2", "'/home/vozgen/Games/stellaris_v1.6.2/start.sh'", icon_dir .."/games/stellaris.png" },
   { "Sunless Sea", "'/home/vozgen/Games/Sunless Sea/start.sh'", icon_dir .."/games/sunlesssea.png" },
   { "Sunless Sea Zubmariner", "'/home/vozgen/Games/Sunless Sea Zubmariner/start.sh'", icon_dir .."/games/sunlessseaz.png" },
}

-- doom (zandronum) launcher
M.doomgame = {
   { "Zandronum", terminal .. " -e ".. home_dir .."/Games/Doom/Zandronum/launch.sh", icon_dir .."/apps/zandronum.png" },
   { "Doom + MoC", terminal .. " -e ".. home_dir .."/Games/Doom/Zandronum/launch_d1.sh", icon_dir .."/apps/doom.png" },
   { "Doom II + MoC", terminal .. " -e ".. home_dir .."/Games/Doom/Zandronum/launch_d2.sh", icon_dir .."/apps/doom2.png" },
   { "Doom II TNT", terminal .. " -e ".. home_dir .."/Games/Doom/Zandronum/launch_tnt.sh", icon_dir .."/apps/doom3.png" },
   { "Doom II Plutonia", terminal .. " -e ".. home_dir .."/Games/Doom/Zandronum/launch_evo.sh", icon_dir .."/apps/doom3.png" },
   { "Doom II wads", terminal .. " -e ".. home_dir .."/Games/Doom/Zandronum/wadlaunch.sh", icon_dir .."/apps/doom3.png" },
   { "GZDoom", terminal .. " -e ".. home_dir .."/Games/Doom/launchers/gzdoom.sh", icon_dir .."/apps/gzdoom.png" },
   { "Hexen", terminal .. " -e ".. home_dir .."/Games/Doom/launchers/hexen.sh", icon_dir .."/apps/hexen.png" },
   { "Hexen DD", terminal .. " -e ".. home_dir .."/Games/Doom/launchers/hexendd.sh", icon_dir .."/apps/hexen.png" },
   { "Heretic", terminal .. " -e ".. home_dir .."/Games/Doom/launchers/heretic.sh", icon_dir .."/apps/heretic.png" },
   { "Doom BD", terminal .. " -e ".. home_dir .."/Games/Doom/launchers/bd_black.sh", icon_dir .."/apps/doom.png" },
   { "Doom II BD", terminal .. " -e ".. home_dir .."/Games/Doom/launchers/bd_black2.sh", icon_dir .."/apps/doom2.png" },
}

-- Games menu
M.gamesmenu = {
   { "DosBox", "dosbox", icon_dir .."/apps/dosbox.png" },
   { "GOG games", goggames, icon_dir .. "/apps/gog.png" },
   { "Play on linux", "playonlinux", icon_dir .."/apps/playonlinux.png" },
   { "Doom Engines", doomgame, icon_dir .."/apps/doom3.png" },
   { "Hexen II", terminal .. " -e ".. home_dir .."/Games/Hexen/start.sh", icon_dir .."/apps/hexen.png" },
   { "OpenTTD", "/home/vozgen/Games/OpenTTD/openttd", icon_dir .."/games/openttd.png" },
}

-- Multimedia menu
M.multimediamenu = {
   { "Vlc", "vlc", icon_dir .."/apps/vlc.png" },
   { "Rhythmbox", "rhythmbox", icon_dir .."/apps/mplayer.png" },
   { "Volume control", "pavucontrol", icon_dir .."/apps/audio-speakers.png"},
}

-- Internet app menu
M.internetmenu = {
   { "Mozilla Firefox", "firefox", icon_dir .."/apps/firefox.png" },
   { "Chromium", "chromium-browser", icon_dir .."/apps/chromium-browser.png" },
   { "Transmission", "transmission-gtk", icon_dir .."/apps/transmission.png" },
}

-- Utility menu
M.utilitymenu = {
   { "IP calculator", "gip", icon_dir .."/apps/calculator.png" },
   { "Disk usage", "baobab", icon_dir .."/apps/baobab.png" },
   { "System monitor", "gnome-system-monitor", icon_dir .."/apps/utilities-system-monitor.png" },
   { "Disk info", "gnome-disk", icon_dir .."/apps/drive-harddisk.png" },
   { "Calculator", "gnome-calculator" },
   { "System Log", "gnome-sysstem-log", icon_dir .."/mimetypes/text-x-generic.png" },
   { "Users and Groups", "cinnamon-settings-users", icon_dir .."/apps/system-users.png" },
   { "Synaptic Package manager", "synaptic-pkexec", icon_dir .."/apps/synaptic.png" },
   { "Printers", "system-config-printer", icon_dir .."/apps/printer.png" },
   { "Driver Manager", "driver-manager", icon_dir .."/apps/mintdrivers.png" },
   { "Keyboard Layout", "gkbd-keyboard-display", icon_dir .."/apps/input-keyboard.png" },
   { "ISO to USB stick", "'mintstick -m iso'", icon_dir .."/apps/usb-creator-kde.png" },
   { "Archive manager", "file-roller", icon_dir .."/apps/archive-manager.png" },

}

----------------------------------------------------------------------------------------------------
function _M.get()
-- Main menu
   local menu_items = {
      --   { "Office", M.officemenu, icon_dir .. "/categories/applications-office.png" },
      { "Internet", M.internetmenu, icon_dir .. "/categories/applications-internet.png" },
      { "Graphic", M.graphicsmenu, icon_dir .. "/categories/applications-graphics.png" },
      --   { "Games", M.gamesmenu, icon_dir .. "/categories/applications-games.png" },
      --   { "Multimedia", M.multimediamenu, icon_dir .. "/categories/applications-multimedia.png" },
      { "Utilities", M.utilitymenu, icon_dir .."/categories/applications-utilities.png" },
      { "Browser", browser, icon_dir .."/apps/web-browser.png" },
      { "File Manager", "nemo", icon_dir .."/apps/system-file-manager.png" },       
      { "Open Terminal", terminal, icon_dir .."/apps/utilities-terminal.png" },
      --			     { "---------------",""},
      { "Cinnamon", M.cinnamonmenu, icon_dir .. "/categories/applications-system.png" },
      --			     { "Awesome restart", awesome.restart, icon_dir .."/actions/view-refresh.png" },
      { "Awesome", M.awesomemenu, beautiful.awesome_icon },
      { "Quit",  function () awful.util.spawn_with_shell("".. script_dir .."exit.sh") end, icon_dir .."/actions/application-exit.png" },
   }

   return menu_items
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
