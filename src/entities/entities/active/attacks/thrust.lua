-- Thrust Attack
--

local Base   = require 'src.entities.entities.active.attacks.base'
local Thrust = Base:extend()

function Thrust:new(data)
	Base.new(self, _:merge({
		name = 'thrust',
		--
		mixins = {
			transform = {
				x = data.source:px() + data.source:width() * 2 * data.source:facing(),
				y = data.source:py(),
				w = data.w or Config.world.tileSize * 2,
				h = data.h or Config.world.tileSize * 0.5,
			},
			source = { src = data.source },
			damage = { dmg = data.dmg or 10 }
		},
		--
		systems = {
			follow = { },
			expire = { delay = data.expire or 0.5 }
		}
	}, data))
end

return Thrust