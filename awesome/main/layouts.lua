-- layouts definition
--------------------------------------------------------------------------------
-- Standard awesome library
local awful = require("awful")

local _M = {}

function _M.get ()
   -- Table of layouts to cover with awful.layout.inc, order matters.
   local layouts =

      {

	 awful.layout.suit.floating,           -- 1
	 awful.layout.suit.tile,               -- 2
	 -- awful.layout.suit.tile.left,
	 awful.layout.suit.tile.bottom,        -- 3
	 -- awful.layout.suit.tile.top,
	 awful.layout.suit.fair,               -- 4
	 -- awful.layout.suit.fair.horizontal,
	 -- awful.layout.suit.spiral,
	 awful.layout.suit.spiral.dwindle,     -- 5
	 awful.layout.suit.max,                -- 6
	 awful.layout.suit.max.fullscreen,     -- 7
	 awful.layout.suit.magnifier           -- 8
	 -- awful.layout.suit.corner.ne,
	 -- awful.layout.suit.corner.sw,
	 -- awful.layout.suit.corner.se, --!!","!!
      }
   return layouts
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
