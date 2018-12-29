-- configuration for awesome 4.+
-- Version: 22-04-2017 10:04 MSK
-- based on (lost origin)
--------------------------------------------------------------------------------------------------------
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local shape = require("gears.shape")
local wibox = require("wibox")
--local lain  = require("lain")
local vicious = require("vicious")
local menubar = require("menubar")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")

-- helpers function library
local mylib = require("main.helpers")

-- my defenition
os.setlocale("ru_RU.UTF-8")

-- calendar widget (from wawesome 3.5)
local cal    = require("myutils.cal")
local my_mem = require("myutils.mem")
local my_fs = require("myutils.fs")

-- local widhelp = require("statusbar.helpers")

-----------------------------------------------------------------------------------------------------

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")

-- {{{ Variable definitions
-- varibles TEMP, when modules ready will be removed
--markup            = lain.util.markup
local modkey = RC.vars.modkey

----------------------------------------------------------------------------------------------------

-- Error handling
dofile(RC.vars.config_dir.."main/error-handling.lua")
 
----------------------------------------------------------------------------------------------------

-- Custom Local Library
local main = {
    layouts = require("main.layouts"),
    tags    = require("main.tags"),
    menu    = require("main.menu"),
    rules   = require("main.rules"),
}

-- Custom local library: keys and mouse bindings
local binding = {
    globalbuttons = require("binding.globalbuttons"),
    clientbuttons = require("binding.clientbuttons"),
    globalkeys    = require("binding.globalkeys"),
    bindtotags    = require("binding.bindtotags"),
    clientkeys    = require("binding.clientkeys")
}

local statusbar = {
   helpers = require("statusbar.helpers"),
--   widgets = require("statusbar.widglib"),
}
-----------------------------------------------------------------------------------------------------
-- Theme
beautiful.init(RC.vars.theme_selected)

-------------------------------------------------------------------
-- my layots removed from here to mytags.lua
RC.layouts = main.layouts() -- module

-------------------------------------------------------------------
-- my tags removed from here to mytags.lua
RC.tags = main.tags() --module

-------------------------------------------------------------------

-- menu configuration removed from here to menu.lua file (see )
-- Create a laucher widget and a main menu
RC.mainmenu = awful.menu({ items = main.menu() }) -- in globalkeys
RC.launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = RC.mainmenu })

-- Menubar configuration
menubar.utils.terminal = RC.vars.terminal -- Set the terminal for applications that require it
-- }}}


-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- system tray

mysystray =  wibox.widget.systray()

-- {{{ Wibar

mytextclock = wibox.widget.textclock('<span font="'..beautiful.widget_font..'" weight="bold"> %H:%M </span>')
cal.register(mytextclock) -- from old 3.5 calendar popup

-- cache vicious

vicious.cache(vicious.widgets.dio)
vicious.cache(vicious.widgets.bat)
vicious.cache(vicious.widgets.cpu)
vicious.cache(vicious.widgets.mem)

-------------------------------------------------------------
-- my widget will be here
-- memory widget
membox = wibox.widget.textbox()
vicious.register(membox, vicious.widgets.mem, 
		 function (membox, args)
		    if args[1] < 10 then
		       return '<span font="'..beautiful.widget_font..'" color="LightGreen" weight="bold" >[M:0'..args[1]..'%]</span>'
		    else
		       return '<span font="'..beautiful.widget_font..'" color="LightGreen" weight="bold" >[M:'..args[1]..'%]</span>'
		    end
		 end, 13)
membox:buttons(gears.table.join(
		   awful.button({ }, 3, function () awful.spawn.with_shell("baobab", 1) end)))
--cpu widget
cpubox = wibox.widget.textbox()
vicious.register(cpubox, vicious.widgets.cpu,
		 function (cpubox, args)
		    if args[1] < 10 then
		       return '<span color="LightBlue" font="'..beautiful.widget_font..'" weight="bold">[C:0'..args[1]..'%]</span>'
		    else
		       return '<span color="LightBlue" font="'..beautiful.widget_font..'" weight="bold">[C:'..args[1]..'%]</span>'
		    end
		 end)
cpubox:buttons(gears.table.join(
		   awful.button({ }, 3, function () awful.spawn.with_shell("gnome-system-monitor", 1) end)))

-- batt widget
batbox = wibox.widget.textbox()
vicious.register(batbox, vicious.widgets.bat,
	function (batbox, args)
		if args[2] < 20 then
			return '<span color="red" font="'..beautiful.widget_font..'" weight="bold">[B:'..args[1]..''..args[2]..'%]</span>'
		elseif args[2] > 80 then
			return '<span color="orange" font="'..beautiful.widget_font..'" weight="bold">[B:'..args[1]..''..args[2]..'%]</span>'
		else
			return '<span color="yellow" font="'..beautiful.widget_font..'" weight="bold">[B:'..args[1]..''..args[2]..'%]</span>'
		end
	end, 61, 'BAT0')

local widget_vol = wibox.widget.textbox()
vicious.register( widget_vol, vicious.widgets.volume,
  function(widget, args)
    return '<span color="#90d0f0" font="'..beautiful.widget_font..'" weight="bold" >[' .. args[2] .. '</span>' .. "" .. '<span color="#90d0f0" font="'..beautiful.widget_font..'" weight="bold">:' .. args[1] .. "%]" .. '</span>'
  end, 1, {"Master", "-D", "pulse"})
widget_vol:buttons(gears.table.join(
--    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Speaker toggle", false) end),  -- disabled
		      awful.button({ }, 3, function () awful.spawn.with_shell("pavucontrol", 1) end),               -- Pulse Audio control panel (pavucontrol needed)
		      awful.button({ }, 4, function () awful.util.spawn("amixer -c 1 -q sset Master 1dB+", false) end),       -- vol up (master)
		      awful.button({ }, 5, function () awful.util.spawn("amixer -c 1 -q sset Master 1dB-", false) end))       -- vol down (master)
                ) --]]
--------------------------------------------------------------------------------------------------------------------------------------
-- tooltips

local tooltip_cpu = awful.tooltip({
  objects = { cpubox },
  margin_leftright = 10,
  margin_topbottom = 10,
  shape = gears.shape.rectangle,
  timer_function = function()
  local title_1 = "CPU Information"
  local title_2 = "CPU Core 1"
  local title_3 = "CPU Core 2"
  local cpu0_state = vicious.widgets.cpufreq(nil, "cpu0")
  local cpu1_state = vicious.widgets.cpufreq(nil, "cpu1")
  local temperature = statusbar.helpers.tempcheck()
  local text
  text =
     ' <span weight="bold" color="'..beautiful.fg_normal..'">'..mylib.align_center(title_1, 30)..'</span> \n'..
     ' <span weight="bold">------------------------------</span> \n'..
     ' ▪ Core t:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(temperature, 18)..'</span> °C\n\n'..
     ' <span weight="bold" color="'..beautiful.fg_normal..'">'..mylib.align_center(title_2, 30)..'</span> \n'..
     ' <span weight="bold">------------------------------</span> \n'..
     ' ▪ Usage:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.cpu, "$2"), 20)..'</span> %\n'..
     ' ▪ Frequency:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(cpu0_state[1], 14)..'</span> MHz\n\n'..
     ' <span weight="bold" color="'..beautiful.fg_normal..'">'..mylib.align_center(title_3, 30)..'</span> \n'..
     ' <span weight="bold">------------------------------</span> \n'..
     ' ▪ Usage:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.cpu, "$3"), 20)..'</span> %\n'..
     ' ▪ Frequency:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(cpu1_state[1], 14)..'</span> MHz'
   return text
   end
   })

local tooltip_mem = awful.tooltip({
  objects = { membox },
  margin_leftright = 10,
  margin_topbottom = 10,
  shape = gears.shape.rectangle,
  timer_function = function()
  local title_1 = "Memory  information"
  local title_2 = "File system information"
  local mem_used = my_mem()
  local text
  text = 
     ' <span weight="bold" color="'..beautiful.fg_normal..'">'..mylib.align_center(title_1, 30)..'</span> \n'..
     ' <span weight="bold">------------------------------</span> \n'..
     ' ▪ Memory used:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(mem_used[2], 13)..'</span> MB\n'..
     ' ▪ Memory total:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(mem_used[3], 12)..'</span> MB\n'..
     ' ▪ Memory free:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(mem_used[4], 13)..'</span> MB\n'..
     ' ▪ Memory buffered:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(mem_used[9], 9)..'</span> MB\n'..
     ' ▪ Swap usage:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.mem, "$5"), 15)..'</span> %\n'..
     ' ▪ Swap usage:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.mem, "$6"), 14)..'</span> MB\n\n'..
     ' <span weight="bold" color="'..beautiful.fg_normal..'">'..mylib.align_center(title_2, 30)..'</span> \n'..
     ' <span weight="bold">------------------------------</span> \n'..
     ' ▪ Root FS free:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.fs, "${/ avail_p}"), 13)..'</span> %\n'..
     ' ▪ Root FS available:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.fs, "${/ avail_gb}"), 7)..'</span> GB\n'
--     ' ▪ /home free:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.fs, "${/home avail_p}"), 15)..'</span> %\n'..
--     ' ▪ /home available:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.fs, "${/home avail_gb}"), 9)..'</span> GB'
   return text
   end
})

local tooltip_bat = awful.tooltip({
  objects = { batbox },
  margin_leftright = 10,
  margin_topbottom = 10,
  shape = gears.shape.rectangle,
  timer_function = function()
     local title = "Battery information"
     local stat_1 = vicious.widgets.bat(nil, "BAT0") -- table
     local stat_2 = statusbar.helpers.batstats().watt
     local stat_3 = statusbar.helpers.batstats().status
     local text
     text = ' <span weight="bold" color="'..beautiful.fg_normal..'">'..mylib.align_center(title, 30)..'</span> \n'..
	' <span weight="bold">------------------------------</span> \n'..     
	' ▪ Status:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(stat_3, 21)..'</span>\n'..
	' ▪ Remaining time:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(stat_1[3], 13)..'</span>\n'..
	' ▪ Power consumption:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(stat_2, 8)..'</span> W'
     return text
  end
  })



local tooltip_sys = awful.tooltip({
  objects = { mykeyboardlayout },
  margin_leftright = 10,
  margin_topbottom = 10,
  shape = gears.shape.rectangle,
  timer_function = function()
     local title_1 = "I/O information"
--     local stat_1 = vicious.widgets.wifi("pidr", "wlp2s0")
--     local stat_2 = statusbar.helpers.batstats().watt
--     local stat_3 = statusbar.helpers.batstats().status
     local text
     text = ' <span weight="bold" color="'..beautiful.fg_normal..'">'..mylib.align_center(title_1, 30)..'</span> \n'..
	' <span weight="bold">------------------------------</span> \n'..     
	' ▪ sda read:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.dio, "${sda read_s}"), 17)..'</span> s\n'..
	' ▪ sda write:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.dio, "${sda write_s}"), 16)..'</span> s\n'..
	' ▪ sda total:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.dio, "${sda total_s}"), 16)..'</span> s\n'..
	' ▪ sda total:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.dio, "${sda total_mb}"), 15)..'</span> MB\n'..
	' ▪ sda i/o time:<span color="'..beautiful.fg_normal..'">'..mylib.align_right(vicious.call(vicious.widgets.dio, "${sda iotime_s}"), 13)..'</span> s'
     return text
  end
  })


--------------------------------------------------------------------------------------------------------------

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, mylib.client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            RC.launcher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
	    mykeyboardlayout,
            mysystray,
	    widget_vol,
	    cpubox,
	    membox,
	    batbox,
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}
-- {{{ Mouse and key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)
--- }}}

awful.rules.rules = main.rules(
       binding.clientkeys(),
       binding.clientbuttons()
) 
-------------------------------------------------------------------
-- signals section removed to signals.lua
dofile(RC.vars.config_dir.."main/signals.lua")

-- {{{ autostart section
-- see run_once func
mylib.run_once("xautolock","-time 5 -locker " .. RC.vars.script_dir .. "locker.sh", nil, 1)
--}}}
