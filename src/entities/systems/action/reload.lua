-- Reload (Ranged) System
--

local Base   = require 'src.entities.systems.base'
local Reload = Base:extend()

-- New
--
function Reload:new(host, data)
	Base.new(self, host, { 'reload' })

	--
	self.sprite = data.sprite
end

-- Update
--
function Reload:update(dt)
	self.sprite:update(dt)

	-- onRequest..
	if self:reloadRequested() then
		if self:canReload() then
			self.host:onReload()
			--
			self.sprite:play()
		end
	end
end

-- Draw - 360 deg aiming
--
function Reload:draw()
	if self.host.isReloading then
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

---- ---- ---- ----

-- Can perform reload
--
function Reload:canReload()
	return not self.host.isReloading and
           not self.host.isCrouching and
	       not self.host.isRolling and
	       not self.host.isAttacking and
	       not self.host.isGuarding
end

-- Has reload been requested?
--
function Reload:reloadRequested()
	return self.host.isReqReload
end

return Reload