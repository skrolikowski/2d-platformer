-- Regen System
--

local Base  = require 'src.entities.systems.base'
local Regen = Base:extend()

-- New
--
function Regen:new(host, data)
	Base.new(self, host, { 'health' })
	
	--
	Timer.every(data.rate or 1, function()
		self.host:increaseHp(data.amt or 1)
	end)
end
return Regen