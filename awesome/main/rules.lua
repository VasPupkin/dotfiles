-- Standard awesome library
local awful     = require("awful")
-- Theme handling library
local beautiful = require("beautiful")

local _M = {}


function _M.get(clientkeys, clientbuttons)
    local rules = {
        -- All clients will match this rule.
        { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
		     titlebars_enabled = true,
                     screen = awful.screen.preferred,
		     size_hints_honor = false,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen+awful.placement.centered }},
	-- Floating clients.
	{ rule_any = {
	     instance = { "DTA",  -- Firefox addon DownThemAll.
			  "copyq"},  -- Includes session name in class.
	     class = { "Arandr",
		       "Gpick",
		       "Kruler",
		       "MessageWin",  -- kalarm.
		       "Sxiv",
		       "Wpa_gui",
		       "pinentry",
		       "veromix",
		       "xtightvncviewer"},
	     name = {"Event Tester" },  -- xev.
	     role = {"AlarmWindow",  -- Thunderbird's calendar.
		     "pop-up"}},       -- e.g. Google Chrome's (detached) Developer Tools.
	  properties = { floating = true }},

	-- other individual
	-- rules specifc for home
	-- Firefox to always map on tags number 1 of screen 1.
	{ rule = { class = "Firefox" },
	  properties = { tag = RC.tags[1][1], titlebars_enabled = false} },
	-- Set FBReader tag 1 screen 8
	{ rule = { instance = "fbreader" },
	  properties = { tag = RC.tags[1][8], titlebars_enabled = false } },
	-- vlc media player
	{ rule = { instance = "vlc" },
	  properties = { tag = RC.tags[1][6] } },
	-- Set Rhythmbox tag 1 screen 6
	{ rule = { class = "Rhythmbox" },
	  properties = { tag = RC.tags[1][6], titlebars_enabled = false } },
	-- Mint Update
	{ rule = { class = "MintUpdate.py" },
	  properties = { tag = RC.tags[1][7] } },
	-- Transmission
	{ rule = { class = "Transmission-gtk" },
	  properties = { tag = RC.tags[1][6] } },
	-- No titlebars windows(progs)
	{ rule_any = { 
	     class = {"Gnome-terminal",
		      "Emacs", -- Emacs24 in original
		      "/usr/lib/firefox/plugin-container", -- fullscreen browser video (flash-plugin)
		      "Xed",
		      "Chromium-browser",
		      "mpv",
		      "Zathura",
		      "Gcr-prompter",
		      "Soffice" },
	     instance = { "libreoffice" },
	     name = { "LibreOffice" }},
	  properties = { titlebars_enabled = false} },
    }    
    return rules
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
