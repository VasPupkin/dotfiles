-- tags definition
--------------------------------------------------------------------------------

-- Standard awesome library
local awful = require("awful")

local _M = {}

function _M.get(layouts)

   local tagpair = {
      names = { " I "," II "," III "," IV "," V "," VI "," VII "," VIII "," IX " }, --romano
      -- names = { " A "," Β "," Γ "," Δ "," E "," Ζ "," Η "," Θ ", " I "}, -- greek
      layout = { RC.layouts[1], RC.layouts[2], RC.layouts[6], RC.layouts[8], RC.layouts[3], RC.layouts[4], RC.layouts[1], RC.layouts[6], RC.layouts[1] }
   }
   
   local tags = {}
   for s = 1, screen.count() do
      -- Each screen has its own tag table.
      tags[s] = awful.tag(tagpair.names, s, tagpair.layout)
   end

   return tags
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
