module("binding.clientbuttons", package.seeall)

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local _M = {}
local modkey = RC.vars.modkey

function _M.get()
    local clientbuttons = gears.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize))

    return clientbuttons
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })


