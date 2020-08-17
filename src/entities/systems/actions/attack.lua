-- Slash Attack System
--

local Base   = require 'src.entities.systems.base'
local Attack = Base:extend()

-- New
--
function Attack:new(host, data)
	Base.new(self, host, { 'attack', 'axis' })

	--
	-- set component values
	host:atkDelay(data.atkDelay or host._atkDelay)
end

-- Update
--
function Attack:update(dt)
	--
	-- attack requested
	if self:attackRequested() then
		if self:canAttack() then
			self.host:dispatch('onAttack', self.host._atkType)
		end
	end
end

---- ---- ---- ----

-- Event: onAttack
--
function Attack:onAttack(attack)
	if self.hitbox then
		self.hitbox:destroy()
	end

	self.hitbox = new(Entity[attack], {
		host = self.host,
		x    = self.host:px() + self.host:width() * 1.25 * self.host:facing(),
		y    = self.host:py(),
	})
end

-- Event: offAttack
--
function Attack:offAttack()
	if self.hitbox then
		self.hitbox:destroy()
	end
end

-- Event: onAnimationComplete
--
function Attack:onAnimationComplete(name)
	if name == 'attack' then
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
		   not self.host.isCrouching and
	       self.host.tAtkCooldown == 0
end

return Attack