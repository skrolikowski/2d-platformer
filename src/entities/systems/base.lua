-- Base System
--

local Modern = require 'modern'
local System = Modern:extend()

-- New
--
function System:new(host, components)
	self.id    = Util:uuid()
	self.host  = host
	
	--
	host:addComponents(components)
end

-- Teardown
--
function System:destory()
	--
end

-- Update
--
function System:update(dt)
	--
end

-- Draw
--
function System:draw()
	--
end

return System