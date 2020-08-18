-- Attack System
--

local Base   = require 'src.entities.systems.base'
local Attack = Base:extend()

-- New
--
function Attack:new(host, data)
	Base.new(self, host, { 'attack', 'axis' })

	--
	-- set component values
	host:atkDelay(data.delay or host._atkDelay)
end

-- Update
--
function Attack:update(dt)
	--
	-- attack requested
	if self:attackRequested() then
		if self:canAttack() then
			self.host:dispatch('onAttack')
			--
			local path = Entities[self.host:atkType()]
			local data = { source = self.host }

			Timer.after(0.25, function()
				self.hitbox = new(path, data)
			end)
		end
	end
end

---- ---- ---- ----

function Attack:offAttack()
	if self.hitbox then
		self.hitbox:destroy()
	end
end

-- Event: onAnimationComplete
--
function Attack:onAnimationComplete(name)
	if name == self.host:atkType() then
		self.host:dispatch('offAttack')
	end
end

---- ---- ---- ----

-- Has attack been requested?
--
function Attack:attackRequested()
	return self.host.tAtkReq > 0
end

-- Has jump been requested?
--
function Attack:canAttack()
	return not self.host.isAttacking and
	       not self.host.isGuarding  and
		   not self.host.isCrouching and
	       self.host.tAtkCooldown == 0
end

return Attack