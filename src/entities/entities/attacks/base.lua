local Base   = require 'src.entities.entities.entity'
local Attack = Base:extend()

-- New
--
function Attack:new(data)
	Base.new(self, _:merge({
		mixins = {
			damage = {
				src = data.host,
				dmg = data.dmg or 10
			},
			transform = {
				x = data.x,
				y = data.y,
				w = data.w or Config.world.tileSize,
				h = data.h or Config.world.tileSize,
			}
		}
	}, data))

	--
	self:dmgOff()

	-- timer
	self.timer = Timer.new()
	self.timer:after(0.25, function() self:dmgOn() end)
	self.timer:after(0.50, function() self:destroy() end)
end

-- Tear down
--
function Attack:destroy()
	self.timer:clear()
	--
	Base.destroy(self)
end


-- Update
--
function Attack:update(dt)
	self.timer:update(dt)
	--
	Base.update(self, dt)
end

-- Draw
--
function Attack:draw()
	lg.setColor(1,1,1,1)
	lg.rectangle('line', self:container())
end

return Attack