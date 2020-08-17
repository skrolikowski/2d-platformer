local Base   = require 'src.entities.entities.entity'
local Attack = Base:extend()

-- New
--
function Attack:new(data)
	Base.new(self, _:merge({
		mixins = {
			transform = {
				x = data.x,
				y = data.y,
				w = data.w or Config.world.tileSize,
				h = data.h or Config.world.tileSize,
			}
		}
	}, data))

	--
	-- properties
	self.attacker = data.host -- attacker
end

-- Update
--
function Attack:update(dt)
	Base.update(self, dt)
end

-- Draw
--
function Attack:draw()
	lg.setColor(1,1,1,1)
	lg.rectangle('line', self:container())
end

return Attack