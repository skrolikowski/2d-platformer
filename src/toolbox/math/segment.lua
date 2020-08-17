-- Physics - Line segment
-- Shane Krolikowski
--

local Modern  = require 'modern'
local Segment = Modern:extend()

-- New line segment
--
function Segment:new(...)
    local args = {...}

    if #args == 2 then
		self.p1 = args[1]
		self.p2 = args[2]
    else
		self.p1 = Vec2(args[1] or 0, args[2] or 0)
		self.p2 = Vec2(args[3] or 0, args[4] or 0)
    end
end

---- ---- ---- ----

function Segment:unpack()
	return self.p1.x, self.p1.y, self.p2.x, self.p2.y
end

-- segment midpoint
--
function Segment:midpoint()
    local x = (self.p1.x + self.p2.x) / 2
    local y = (self.p1.y + self.p2.y) / 2

    return Vec2(x, y)
end

-- segment distance
--
function Segment:distance()
    return self.p1:distance(self.p2)
end

-- normalized segment
--
function Segment:normalize()
    return (self.p2 - self.p1):normalize()
end

-- segment midpoint
--
function Segment:center()
    return self:midpoint()
end

-- Find bounds of both points of segment.
--
function Segment:aabb()
    return AABB(
        _.__min(self.p1.x, self.p2.x),  -- left
        _.__min(self.p1.y, self.p2.y),  -- top
        _.__max(self.p1.x, self.p2.x),  -- right
        _.__max(self.p1.y, self.p2.y)   -- bottom
    )
end

-- segment slope.
--
function Segment:slope()
	return (self.p2.y - self.p1.y) / (self.p2.x - self.p1.x)
end

-- Find values of standard form equation.
-- Ax + By + C = 0
--
function Segment:standardForm()
    local A = self.p2.y - self.p1.y
    local B = self.p1.x - self.p2.x
    local C = A * self.p1.x + B * self.p1.y

    return A, B, C
end


-- Find point interception of two lines segments.
--
function Segment:vsSegment(other)
	local A1, B1, C1 = self:standardForm()
	local A2, B2, C2 = other:standardForm()
	local D          = A1 * B2 - A2 * B1

    -- ignore parallel/colinear lines
    if D == 0 then
    	return false
    end

    -- intersection point
    local ix  = (B2 * C1 - B1 * C2) / D
    local iy  = (A1 * C2 - A2 * C1) / D

    -- test intersection is within segments
    local rx1 = (ix - self.p1.x) / (self.p2.x - self.p1.x)
    local ry1 = (iy - self.p1.y) / (self.p2.y - self.p1.y)
    local rx2 = (ix - other.p1.x) / (other.p2.x - other.p1.x)
    local ry2 = (iy - other.p1.y) / (other.p2.y - other.p1.y)

    if ((rx1 >= 0 and rx1 <= 1) or (ry1 >= 0 and ry1 <= 1)) and
       ((rx2 >= 0 and rx2 <= 1) or (ry2 >= 0 and ry2 <= 1))
    then
        return Vec2(ix, iy)
    end

    return false
end

-- Segment x AABB intersection check
-- https://2dengine.com/?p=intersections#Segment_vs_rectangle
--
function Segment:vsAABB(box)
    local x1, y1, x2, y2 = self:unpack()
    local norm   = Vec2(x2-x1, y2-y1):normalize()
    local tMin   = 0
    local tMax   = self:distance()
    local t1, t2

    -- x-axis check
    if norm.x == 0 then
        if self.p1.x < box.left or self.p1.x > box.right then
            return false
        end
    else
        t1 = (box.left  - self.p1.x) / norm.x
        t2 = (box.right - self.p1.x) / norm.x
        
        -- swap, if necessary
        if t2 < t1 then
            t2, t1 = t1, t2
        end

        tMin = _.__max(tMin, t1)
        tMax = _.__min(tMax, t2)

        if tMin > tMax then
            return false
        end
    end

    -- y-axis check
    if norm.y == 0 then
        if self.p1.y < box.top or self.p1.y > box.bottom then
            return false
        end
    else
        t1 = (box.top    - self.p1.y) / norm.y
        t2 = (box.bottom - self.p1.y) / norm.y
        
        -- swap, if necessary
        if t2 < t1 then t2, t1 = t1, t2 end

        tMin = _.__max(tMin, t1)
        tMax = _.__min(tMax, t2)

        if tMin > tMax then
            return false
        end
    end

    return Segment(
        x1 + norm.x * tMin,
        y1 + norm.y * tMin,
        x1 + norm.x * tMax,
        y1 + norm.y * tMax
    )
end

return Segment