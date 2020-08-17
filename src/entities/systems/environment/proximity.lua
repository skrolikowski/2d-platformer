-- Proximity System
--

local Base      = require 'src.entities.systems.base'
local Proximity = Base:extend()

-- New
--
function Proximity:new(host, data)
	Base.new(self, host, { 'proximity' })
end

-- Update
--
function Proximity:update(dt)
	--
	-- check if still on ground
	for id, con in pairs(self.host._gnd) do
		if not self:isTouching(con.other, self.host) then
			self.host:dispatch('offGround', con, id)
		end
	end

	--
	-- check if still on wall
	for id, con in pairs(self.host._wall) do
		if not self:isTouching(con.other, self.host) then
			self.host:dispatch('offWall', con, id)
		end
	end
end


-- ---- ---- ---- ----

-- Event: onContact
--
function Proximity:onContact(con, other)
	if self:isGround(con, other) then
		if self.host._gnd[other.id] == nil then
			self.host:dispatch('onGround', con, other.id)
		end
	elseif con.norm.y == 1 then
		--
	elseif self:isWall(con, other) then
		if self.host._wall[other.id] == nil then
			self.host:dispatch('onWall', con, other.id)
		end
	end
end

-- ---- ---- ---- ----

-- Is touching?
--
function Proximity:isTouching(itemA, itemB)
	return itemA:aabb():contains(itemB:aabb())
end

-- Is `other` a Ground entity?
--
function Proximity:isGround(con, other)
	return con.norm.y == -1 and
	       other.name == 'bounds' and
	       self.host._gnd[other.id] == nil
end

-- Is `other` a Wall entity?
--
function Proximity:isWall(con, other)
	return con.norm.x ~= 0 and
	       other.name == 'bounds' and
	       self.host._wall[other.id] == nil
end

return Proximity