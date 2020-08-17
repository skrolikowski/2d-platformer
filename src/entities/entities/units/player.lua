-- Player Entity
--

local Base   = require 'src.entities.entities.units.base'
local Player = Base:extend()

function Player:new(data)
	Base.new(self, _:merge({
		name = 'player',
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
			hit    = { affects = { 'attack' } },
			death  = { },
			revive = { },
			-- stats
			health = { hp = 100 },
		}
	}, data))
end

-- Update
--
function Player:update(dt)
	Base.update(self, dt)
end

return Player