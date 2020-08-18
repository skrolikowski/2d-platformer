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
		if self:canHeal() then
			self.host:increaseHp(data.amt or 1)
		end
	end)
end

function Regen:canHeal()
	return not self.host.isDead and
	       not self.host.isReviving
end

return Regen