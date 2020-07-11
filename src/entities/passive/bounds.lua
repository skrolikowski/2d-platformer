-- Bounds Environment
--

local Base   = require 'src.entities.entity'
local Bounds = Base:extend()

function Bounds:new(data)
	Base.new(self, _:merge(data, {
		name  = 'bounds',
		x     = (data.x + data.width / 2),
		y     = (data.y + data.height / 2),
		color = data.color or { _:color('red-300') },
	}))
	--
	-- properties
	self.order  = 2
	self.oneway = data.properties['oneway'] or false
	self.ledge  = data.properties['ledge']  or false
end

-- Are bounding boxes touching?
--
function Bounds:isTouching(other)
	return self:bounds():contains(other:bounds())
end

-- Resolve collision
--
function Bounds:resolve(con, target)
	--
	-- ledge
	if self.ledge and con.norm.x ~= 0 then
		if con.bb2.top < con.bb1.top then
			if (con.bb1.top - con.bb2.top) < 3 then
				con.item:onLedge(true)
			end
		end
	--
	-- one-way platform
	elseif self.oneway and not con.bb1:isAbove(con.bb2, -0.1) then
		return
	end

	--
	if con.norm.y == -1 then
		con.item:onGroundContact(con.other, con)
	elseif con.norm.x ~= 0 then
		con.item:onWallContact(con.other, con)
	end

	--
	con:adjust(target)
end

return Bounds