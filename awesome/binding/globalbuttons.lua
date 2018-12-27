-- Standard awesome library
local awful = require("awful")
local gears = require("gears")

local _M = {}

function _M.get()
    local globalbuttons = gears.table.join(
       awful.button({ }, 1, function () RC.mymainmenu:hide() end),
       awful.button({ }, 3, function () RC.mymainmenu:toggle() end),
       awful.button({ }, 4, awful.tag.viewnext),
       awful.button({ }, 5, awful.tag.viewprev)
    )

    return globalbuttons
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })