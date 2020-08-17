-- Hero Entity
--

local Base = require 'src.entities.entities.units.base'
local Hero = Base:extend()

function Hero:new(data)
	Base.new(self, _:merge({
		name = 'hero',
		systems = {
			'animation',
			'attack',
			'crouch',
			'dash',
			'gravity',
			'move',
			'proximity',
			'roll',
			--
			jump = { canDouble = true },
			--
			hit    = { },
			death  = { },
			revive = { },
			-- stats
			health = { hp = 100 },
		}
	}, data))
end

-- Update
--
function Hero:update(dt)
	Base.update(self, dt)
end

return Hero