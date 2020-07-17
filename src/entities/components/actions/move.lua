-- Move Component
--

local Base = require 'src.entities.components.component'
local Move = Base:extend()

-- Update
--
function Move:onRequestUpdate(dt)
	local axis = self.host:axis()

	if axis.x == 0 then
		self.host:vx(0)
	else
		local dir   = Util:sign(axis.x)
		local speed = self.host._speed

		if self.host:onGround() then
			self.host:vx(dir * speed)
		else
			self.host:vx(dir * speed * 0.85)
		end
	end
end

return Move