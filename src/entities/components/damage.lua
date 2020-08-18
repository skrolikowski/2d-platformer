-- Damage Component
--

local Base   = require 'modern'
local Damage = Base:extend()

-- New
--
function Damage:new(host, data)
	self.host = host

	--
	-- properties
	self._dmg = data.dmg or 0
end

-- Get/set `damage` value
--
function Damage:dmg(value)
	if value == nil then
		return self._dmg
	end

	self._dmg = value
end

return Damage