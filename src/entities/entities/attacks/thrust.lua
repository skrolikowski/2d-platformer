-- Thrust Attack
--

local Base   = require 'src.entities.entities.attacks.base'
local Thrust = Base:extend()

function Thrust:new(data)
	Base.new(self, _:merge({
		name = 'thrust',
		x    = data.host:px() + data.host:width() * 2 * data.host:facing(),
		y    = data.host:py(),
		w    = data.w or Config.world.tileSize * 2,
		h    = data.h or Config.world.tileSize * 0.5,
	}, data))
end

return Thrust