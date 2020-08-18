-- Guard System
--

local Base  = require 'src.entities.systems.base'
local Guard = Base:extend()

-- New
--
function Guard:new(host, data)
	Base.new(self, host, { 'guard', 'defense' })
	
	--
	-- properties
	self.origDef  = host._def
	self.guardDef = host._def * (data.scale or 1.25)
end

-- Update
--
function Guard:update(dt)
	if self.host.isGuarding then
		self.host:def(self.guardDef)

		--
		if self.host.isAttacking then
			self.host:dispatch('offAttack')
		end
	else
		self.host:def(self.origDef)
	end
end

return Guard