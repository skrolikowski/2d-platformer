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
			'inventory',
			'move',
			'proximity',
			'roll',
			--
			aim = {
				sprite = Animation(Sheet['hero']['aim_arm'])
					:frames({1,1,1,1})
					:offset(-16,4)
					:once()
					:after(function()
						self:dispatch('onRqReload')
					end)
			},
			-- reload = {
			-- 	sprite = Animation(Sheet['hero']['aim_arm'])
			-- 		:frames({1,1,3,2})
			-- 		:offset(-16,4)
			-- 		:once()
			-- },
			--
			attack  = { delay = 0 },
			jump    = { canDouble = true },
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