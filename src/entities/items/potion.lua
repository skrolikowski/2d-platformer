-- Potion Item
--

local Base   = require 'src.entities.items.item'
local Potion = Base:extend()

function Potion:new(data)
	Base.new(self, _:merge({ name = 'potion' }, data))

	--
	-- properties
	self.stat  = data.stat  or 'health'
	self.value = data.value or 25
end

-- Use
--
function Potion:use(entity)
	Base.use(self, entity)
	--
	if self.value > 0 then
		entity:dispatch('onBuff', self)
	else
		entity:dispatch('onDebuff', self)
	end
end

return Potion