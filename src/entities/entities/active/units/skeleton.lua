-- Skeleton Entity
--

local Base     = require 'src.entities.entities.active.units.base'
local Skeleton = Base:extend()

function Skeleton:new(data)
	Base.new(self, _:merge({
		name = 'skeleton',
		systems = {
			'animation',
			'gravity',
			'proximity',
			--
			health = { hp = 25 },
			move   = { spd = 50 },
			hit    = { delay = 0.25 },
			regen  = { rate = 1, amt = 1 },
			revive = { delay = 5 }
		},
		behaviors = {
			{ 'damage' },  -- reacts to damage
			-- { 'attack' },  -- can attack
			{ 'patrol' }   -- default: patrol
		}
	}, data))
end

-- Update (req'd to run systems)
--
function Skeleton:update(dt)
	Base.update(self, dt)
end

return Skeleton