-- Skeleton Entity
--

local Base     = require 'src.entities.entities.units.base'
local Skeleton = Base:extend()

function Skeleton:new(data)
	Base.new(self, _:merge({
		name = 'skeleton',
		systems = {
			'animation',
			'gravity',
			'proximity',
			--
			health = { hp = 50 },
			move   = { spd = 50 },
			hit    = { affects = { 'attack' } }
		},
		behaviors = {
			{ 'death', { revive = { delay = 2 }}},
			{ 'attack' },
			{ 'patrol' }
		}
	}, data))
end

-- Update
--
function Skeleton:update(dt)
	Base.update(self, dt)
end

return Skeleton