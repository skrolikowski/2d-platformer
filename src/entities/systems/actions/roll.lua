-- Roll System
--

local Base = require 'src.entities.systems.base'
local Roll = Base:extend()

-- New
--
function Roll:new(host, data)
	Base.new(self, host, { 'axis', 'roll' })
end

-- Update
--
function Roll:update(dt)
	--
	-- roll request..
	if self:rollRequested() then
		if self:canRoll() then
			self.host:onRoll()
		end
	end

	--
	-- movement..
	if self.host.isRolling then
		self.host:ax(self.host:facing())
	end
end

function Roll:onAnimationComplete(name)
	if name == 'roll' then
		self.host:ax(0)
		self.host:offRoll()
	end
end

---- ---- ---- ----

-- Can perform roll.
--
function Roll:canRoll()
	return self.host.isOnGround  and
	       self.host.isCrouching and
	       not self.host.isRolling
end

-- Has roll been requested?
--
function Roll:rollRequested()
	return self.host.tRollReq > 0
end

return Roll