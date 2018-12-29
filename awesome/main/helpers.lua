-- helper functoins

-- Standard awesome library
-- local gears = require("gears")
local awful = require("awful")
local math       = { abs    = math.abs,
                     floor  = math.floor,
                     log10  = math.log10,
                     min    = math.min }
----------------------------------------------------------------------------------------------------

local M = {}

-- run_once func
-- example run_once("gnome-terminal", "-e mc", nil, 1) launch mc in gnome-terminal
function M.run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
    end

    if not pname then
       pname = prg
    end

    if not arg_string then 
        awful.spawn.with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.spawn.with_shell("pgrep -f -u $USER -x '" .. pname .. " ".. arg_string .."' || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end

-- default function from helepers section rc.lua
function M.client_menu_toggle_fn()
    local instance = nil
    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

-- Align text to the right
function M.align_right(value, max_length)
  local max_length = max_length or 40
  value = tostring(value)
  if max_length > #value then
    value = string.rep(' ', max_length - #value) .. value
  end
  return value
end

-- Align text to the center
function M.align_center(value, max_length)
  local max_length = max_length or 40
  value = tostring(value)
  if max_length > #value then
    value = string.rep(' ', (max_length - #value)/2) .. value
  end
  return value
end


return M
