-- Contact Component
--

local Base    = require 'src.entities.components.component'
local Contact = Base:extend()

-- New..
--
function Contact:new(height, dt)
	--
	-- flags
	self._onGround = {}
	self._onWall   = {}
	self._onLedge  = false
end

-- Event: onRequestUpdate
--
function Contact:onRequestUpdate(dt)
	--
	-- check if still on ground
	for id, con in pairs(self._onGround) do
		if not con.other:isTouching(self.host) then
			self._onGround[id] = nil
		end
	end

	--
	-- check if still on wall
	for id, con in pairs(self._onWall) do
		if not con.other:isTouching(self.host) then
			self._onWall[id] = nil
		end
	end
end

---- ---- ---- ----

-- Event: onRequestAxis
-- Detach from ledge
--
function Contact:onRequestAxis(value)
	-- if value.y == 1 and self._onLedge then
	-- 	self._onLedge = false
	-- end
end

-- Event: onContact
--
function Contact:onContact(con)
	-- print('onContact', con.other.name, con.norm)
	--
	self.host:behavior():onContact(con)
end

-- Event: onGroundContact
--
function Contact:onGroundContact(other, con)
	self._onGround[other.id] = con

	--
	-- match `vel` of ground
	if other._vel then
		self.host:vy(other:vy())
	else
		self.host:vy(0)
	end
end

-- Event: onCeilingContact
--
function Contact:onCeilingContact(other, con)
	--
	-- match `vel` of ceiling
	if other._vel then
		self.host:vy(other:vy())
	else
		self.host:vy(0)
	end
end

-- Event: onWallContact
--
function Contact:onWallContact(other, con)
	self._onWall[other.id] = con

	--
	-- match `vel` of wall
	if other._vel then
		self.host:vx(other:vx())
	else
		self.host:vx(0)
	end
end

---- ---- ---- ----

-- Get `onGround` value
--
function Contact:onGround()
	return _:size(self._onGround) > 0
end

-- Get `onWall` value
--
function Contact:onWall()
	return _:size(self._onWall) > 0
end

-- Get/set `onLedge` value
--
function Contact:onLedge(value)
	if value == nil then
		return self._onLedge
	end
	
	self._onLedge = value
end

return Contact