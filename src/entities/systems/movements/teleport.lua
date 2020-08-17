-- Teleport System
--

local Base     = require 'src.entities.systems.base'
local Teleport = Base:extend()

-- New
--
function Teleport:new(host)
	Base.new(self, host, { })
end

-- Event: onTeleport
--
function Teleport:onTeleport(nextPos)
	self.host.world:move(
		self.host,
		self.host:pos() + self.host:vel() * dt
	)
end

return Teleport