-- tags for work
-- Standard awesome library
local awful = require("awful")

local _M = {}

function _M.get(layouts)
-- work version
   local tagpair = { 
      settings = {
	 { names = { " I "," II "," III "," IV "," V "," VI " }, -- work
	   layout = { RC.layouts[1], RC.layouts[2], RC.layouts[6], RC.layouts[8], RC.layouts[6], RC.layouts[7] }
	 },
	 { names = { " 1 "," 2 "," 3 "," 4 "," 5 "," 6 ", " 7 "," 8 "}, --for work, mixed 
	   layout = { RC.layouts[2], RC.layouts[6], RC.layouts[8], RC.layouts[3], RC.layouts[4], RC.layouts[6], RC.layouts[6], RC.layouts[7]}
	 }}
   }
   
   local tags = {}
   for s = 1, screen.count() do
      -- Each screen has its own tag table.
      tags[s] = awful.tag(tagpair.settings[s].names, s, tagpair.settings[s].layout)
   end

   return tags
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
