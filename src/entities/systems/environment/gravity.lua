-- Gravity System
--

local Base    = require 'src.entities.systems.base'
local Gravity = Base:extend()

-- New
--
function Gravity:new(manager)
	Base.new(self, manager, { 'velocity' })
end

-- Update
--
function Gravity:update(dt)
	self.host:fy(self.host:fy() + 1200)
end

return Gravity