-- Slash Attack
--

local Base  = require 'src.entities.entities.active.attacks.base'
local Slash = Base:extend()

function Slash:new(data)
	Base.new(self, {
		name = 'slash',
		--
		mixins = {
			transform = {
				x = data.source:px() + data.source:width() * 1.25 * data.source:facing(),
				y = data.source:py(),
				w = data.w or Config.world.tileSize,
				h = data.h or Config.world.tileSize,
			},
			source = { src = data.source },
			damage = { dmg = data.dmg or 10 }
		},
		--
		systems = {
			follow = { },
			expire = { delay = data.expire or 0.5 }
		}
	})
end

return Slash