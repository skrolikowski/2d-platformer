-- Charm Item
--

local Base  = require 'src.entities.items.item'
local Charm = Base:extend()

function Charm:new(data)
	Base.new(self, _:merge({ name = 'charm' }, data))

	--
	-- properties
	self.stat  = data.stat  or 'defense'
	self.value = data.value or '5%'
end

-- Passive effect
--
function Charm:passive(entity)
	if self.value > 0 then
		entity:dispatch('onBuff', self)
	else
		entity:dispatch('onDebuff', self)
	end
end

return Charm