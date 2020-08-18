-- Defense Component
--

local Base    = require 'modern'
local Defense = Base:extend()

-- New
--
function Defense:new(host, data)
	self.host = host

	--
	-- properties
	self._def = data.def or 10
end

-- Get/set `def` value.
--
function Defense:def(value)
	if value == nil then
		return self._def
	end

	self._def = value
end

return Defense