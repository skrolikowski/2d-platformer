-- Proximity Component
--

local Base      = require 'modern'
local Proximity = Base:extend()

-- New
--
function Proximity:new(host, data)
	self.host = host

	--
	-- properties
	self._gnd  = {}
	self._wall = {}

	self._gndCount  = 0
	self._wallCount = 0

	--
	-- flags
	self.isOnGround = false
	self.isOnWall   = false
end

---- ---- ---- ----

function Proximity:onGround(con, id)
	self._gnd[id]   = con
	self._gndCount  = self._gndCount + 1
	self.isOnGround = true
end

function Proximity:offGround(con, id)
	self._gnd[id]   = nil
	self._gndCount  = self._gndCount - 1
	self.isOnGround = self._gndCount > 0
end

function Proximity:onWall(con, id)
	self._wall[id]  = con
	self._wallCount = self._wallCount + 1
	self.isOnWall   = true
end

function Proximity:offWall(con, id)
	self._wall[id]  = nil
	self._wallCount = self._wallCount - 1
	self.isOnWall   = self._wallCount > 0
end

return Proximity