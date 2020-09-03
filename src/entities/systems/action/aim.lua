-- Aim (Ranged) System
--

local Base = require 'src.entities.systems.base'
local Aim  = Base:extend()

-- New
--
function Aim:new(host, data)
	Base.new(self, host, { 'aim', 'axis', 'lock' })

	--
	self.sprite = data.sprite
end

-- Update
--
function Aim:update(dt)
	self.sprite:update(dt)

	--
	if self.host.isAiming then
		if not self.host.isLocked then
			self.host:onLock()
			--
			self.sprite:play()
		end
	else
		self.host:offLock()
	end
end

-- Draw - 360 deg aiming
--
function Aim:draw()
	if self.host.isAiming then
		local w, h   = self.host:dimensions()
		local angle  = self.host:axis():heading()
		local tx, ty = 0, -(h * 0.2)
		local sx, sy = self.host:facing(), 1

		-- adjust
		if self.host:facing() == -1 then
			angle = angle + _.__pi
		end

		lg.push()
		lg.translate(tx, ty)
		lg.rotate(angle)
		lg.scale(sx, sy)

		self.sprite:draw()

		lg.pop()
	end
end

return Aim