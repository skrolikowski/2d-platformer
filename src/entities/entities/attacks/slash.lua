-- Slash Attack
--

local Base  = require 'src.entities.entities.attacks.base'
local Slash = Base:extend()

function Slash:new(data)
	Base.new(self, _:merge({
		name = 'slash',
		x    = data.host:px() + data.host:width() * 1.25 * data.host:facing(),
		y    = data.host:py(),
		w    = data.w or Config.world.tileSize,
		h    = data.h or Config.world.tileSize,
	}, data))
end

return Slash