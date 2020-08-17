-- Slash Attack
--

local Base  = require 'src.entities.entities.attacks.base'
local Slash = Base:extend()

function Slash:new(data)
	Base.new(self, _:merge({
		name = 'attack',
		w    = data.w or Config.world.tileSize,
		h    = data.h or Config.world.tileSize,
	}, data))
end

return Slash