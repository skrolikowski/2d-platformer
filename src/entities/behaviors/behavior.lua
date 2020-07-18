-- Base Behavior
--

local Modern   = require 'vendor/modern'
local Behavior = Modern:extend()

-- New
--
function Behavior:new(name, manager)
	self.id    = Util:uuid()
	self.name  = name
	self.host  = manager.host
	self.timer = manager.timer

	-- flags
	self.isActive = true
end

-- Update
--
function Behavior:update(dt)
	if self:pass() then
		return self:execute(dt)
	end

	return true
end

return Behavior