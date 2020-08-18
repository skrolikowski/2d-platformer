-- Hero Entity
--

local Base = require 'src.entities.entities.active.units.base'
local Hero = Base:extend()

function Hero:new(data)
	Base.new(self, _:merge({
		name = 'hero',
		systems = {
			'animation',
			'crouch',
			'dash',
			'guard',
			'gravity',
			'move',
			'proximity',
			'roll',
			--
			attack = { delay = 0 },
			range  = {  },
			jump   = { canDouble = true },
			--
			-- hit    = { },
			-- death  = { },
			-- revive = { },
			health  = { hp = 50 },
			stamina = { hp = 50 },
		}
	}, data))
end

-- Update (req'd to run systems)
--
function Hero:update(dt)
	Base.update(self, dt)
end

return Hero