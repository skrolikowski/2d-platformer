-- Decay System
--

local Base  = require 'src.entities.systems.base'
local Decay = Base:extend()

-- New
--
function Decay:new(host, data)
	Base.new(self, host, { 'health' })
	
	--
	Timer.every(data.rate or 0.35, function()
		self.host:decreaseHp(_.__ceil(self.host:hp() * (data.pct or 1)))
	end)
end

return Decay