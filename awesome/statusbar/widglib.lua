-- required libraries
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local vicious = require("vicious")

-- Theme handling library
local beautiful = require("beautiful")

-- calendar widget (from wawesome 3.5)
local cal = require("myutils.cal")


----------------------------------------------------------------------------------------------------

local W = {} 

-- Keyboard map indicator and switcher
W.kbdlayout = awful.widget.keyboardlayout()

-- textclock widget
W.txtclock = wibox.widget.textclock('<span font="'..beautiful.widget_font..'" weight="bold"> %H:%M </span>')
--cal.register(txtclock) -- from old 3.5 calendar popup

-- memory widget
W.membox = wibox.widget.textbox()
vicious.register(membox, vicious.widgets.mem, 
		 function (membox, args)
		    if args[1] < 10 then
		       return '<span font="'..beautiful.widget_font..'" color="LightGreen" weight="bold" >[MEM:0'..args[1]..'%]</span>'
		    else
		       return '<span font="'..beautiful.widget_font..'" color="LightGreen" weight="bold" >[MEM:'..args[1]..'%]</span>'
		    end
		 end, 13)

--cpu widget
W.cpubox = wibox.widget.textbox()
vicious.register(cpubox, vicious.widgets.cpu,
		 function (cpubox, args)
		    if args[1] < 10 then
		       return '<span color="LightBlue" font="'..beautiful.widget_font..'" weight="bold">[CPU:0'..args[1]..'%]</span>'
		    else
		       return '<span color="LightBlue" font="'..beautiful.widget_font..'" weight="bold">[CPU:'..args[1]..'%]</span>'
		    end
		 end)

-- batt widget
W.batbox = wibox.widget.textbox()
vicious.register(batbox, vicious.widgets.bat,
	function (batbox, args)
		if args[2] < 20 then
			return '<span color="red" font="'..beautiful.widget_font..'" weight="bold">[BAT:'..args[1]..''..args[2]..'%]</span>'
		elseif args[2] > 80 then
			return '<span color="orange" font="'..beautiful.widget_font..'" weight="bold">[BAT:'..args[1]..''..args[2]..'%]</span>'
		else
			return '<span color="yellow" font="'..beautiful.widget_font..'" weight="bold">[BAT:'..args[1]..''..args[2]..'%]</span>'
		end
	end, 61, 'BAT0')

-- Volume Widget
W.widget_vol = wibox.widget.textbox()
vicious.register( widget_vol, vicious.widgets.volume,
		  function(widget, args)
		     return '<span color="#90d0f0" font="'..beautiful.widget_font..'" weight="bold" >[' .. args[2] .. '</span>' .. "" .. '<span color="#90d0f0" font="'..beautiful.widget_font..'" weight="bold">:' .. args[1] .. "%]" .. '</span>'
		  end, 1, "Master")
widget_vol:buttons(gears.table.join(
		      --    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Speaker toggle", false) end),  -- disabled
		      awful.button({ }, 3, function () awful.spawn.with_shell("pavucontrol", 1) end),               -- Pulse Audio control panel (pavucontrol needed)
		      awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1dB+", false) end),       -- vol up (master)
		      awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1dB-", false) end))       -- vol down (master)
)

----------------------------------------------------------------------------------------------------
-- tooltips

-- mem/swap/home
local tooltip_cpu = awful.tooltip({
  objects = { cpubox },
  margin_leftright = 10,
  margin_topbottom = 10,
  shape = gears.shape.rectangle,
  timer_function = function()
  local title_1 = " CPU information"
  local title_2 = " CPU Core 1"
  local title_3 = " CPU Core 2"
  local cpu0_state = vicious.widgets.cpufreq(nil, "cpu0")
  local cpu1_state = vicious.widgets.cpufreq(nil, "cpu1")
  local temperature = coretemp_now
  local text
  text =
     ' <span weight="bold" color="'..beautiful.fg_normal..'">'..title_1..'</span> \n'..
     ' <span weight="bold">-------------------------------------</span> \n'..
     ' ▪ Core t:                          <span color="'..beautiful.fg_normal..'">'..temperature..'</span> °C \n\n'..
     ' <span weight="bold" color="'..beautiful.fg_normal..'">'..title_2..'</span> \n'..
     ' <span weight="bold">-------------------------------------</span> \n'..
     ' ▪ Usage:                         <span color="'..beautiful.fg_normal..'">'..vicious.call(vicious.widgets.cpu, "$2")..'</span> %\n'..
     ' ▪ Frequency:         <span color="'..beautiful.fg_normal..'">'..cpu0_state[1]..'</span> MHz\n\n'..
     ' <span weight="bold" color="'..beautiful.fg_normal..'">'..title_3..'</span> \n'..
     ' <span weight="bold">-------------------------------------</span> \n'..
     ' ▪ Usage:                         <span color="'..beautiful.fg_normal..'">'..vicious.call(vicious.widgets.cpu, "$3")..'</span> % \n'..
     ' ▪ Frequency:         <span color="'..beautiful.fg_normal..'">'..cpu1_state[1]..'</span> MHz\n'
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
     ' <span weight="bold" color="'..beautiful.fg_normal..'">'..title_1..'</span> \n'..
     ' <span weight="bold">-------------------------------------</span> \n'..
     ' ▪ Memory used:           <span color="'..beautiful.fg_normal..'">'..mem_used[2]..'</span> MB \n'..
     ' ▪ Memory total:           <span color="'..beautiful.fg_normal..'">'..mem_used[3]..'</span> MB \n'..
     ' ▪ Memory free:            <span color="'..beautiful.fg_normal..'">'..mem_used[4]..'</span> MB \n'..
     ' ▪ Memory buffered:      <span color="'..beautiful.fg_normal..'">'..mem_used[9]..'</span> MB \n'..
     ' ▪ Swap usage:                   <span color="'..beautiful.fg_normal..'">'..vicious.call(vicious.widgets.mem, "$5")..'</span> % \n'..
     ' ▪ Swap usage:                   <span color="'..beautiful.fg_normal..'">'..vicious.call(vicious.widgets.mem, "$6")..'</span> MB \n\n'..
     ' <span weight="bold" color="'..beautiful.fg_normal..'">'..title_2..'</span> \n'..
     ' <span weight="bold">-------------------------------------</span> \n'..
     ' ▪ Root FS <span color="'..beautiful.fg_normal..'">'..vicious.call(vicious.widgets.fs, "free: ${/ avail_p}")..'</span> % \n'..
     ' ▪ Root FS <span color="'..beautiful.fg_normal..'">'..vicious.call(vicious.widgets.fs, "available: ${/ avail_gb}")..'</span> GB \n'..
     ' ▪ /home   <span color="'..beautiful.fg_normal..'">'..vicious.call(vicious.widgets.fs, "free: ${/home avail_p}")..'</span> % \n'..
     ' ▪ /home   <span color="'..beautiful.fg_normal..'">'..vicious.call(vicious.widgets.fs, "available: ${/home avail_gb}")..'</span> GB \n'
   return text
   end
})


local tooltip_bat = awful.tooltip({
  objects = { batbox },
  margin_leftright = 10,
  margin_topbottom = 10,
  shape = gears.shape.rectangle,
  timer_function = function()
  local title_bat = " Battery information"
  local bat_prc = vicious.widgets.bat(nil, "BAT0")
  local bat_pow = bat_now.watt
  local text
  text = ' <span weight="bold" color="'..beautiful.fg_normal..'">'..title_bat..'</span> \n'..
     ' <span weight="bold">------------------------------------</span> \n'..     
     ' ▪ Charge:                        <span color="'..beautiful.fg_normal..'">'..bat_prc[2]..'</span> % \n'..
     ' ▪ Remaining time:           <span color="'..beautiful.fg_normal..'">'..bat_prc[3]..'</span> \n'..
     ' ▪ Power consumption:   <span color="'..beautiful.fg_normal..'">'..bat_pow..'</span> W'
   return text
   end
})

--------------------------------------------------------------------------------------------------------------
-- not shown widgets

-- тестовое
  local widget_cpu = lain.widget.temp({
	settings = function()
	end
  })

  local widget_bat = lain.widget.bat({
	notify = "off",
	settings = function()
	end
  })

return W
