local Base   = require 'src.entities.entities.entity'
local Attack = Base:extend()

-- New
--
function Attack:new(data)
	Base.new(self, data)

	--
	-- properties
	self.sm = SM(self, data.systems or {})
end

-- Tear down
--
function Attack:destroy()
	self.sm:destroy()
	--
	Base.destroy(self)
end


-- Update
--
function Attack:update(dt)
	self.sm:update(dt)
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