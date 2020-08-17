local Modern = require 'modern'
local AABB   = Modern:extend()

---- ---- ---- ----
-- helpers

-- AABB contains point?
--
local function containsPoint(aabb, point)
    return aabb.left   <= point.x and
           aabb.right  >= point.x and
           aabb.top    <= point.y and
           aabb.bottom >= point.y
end

-- AABB contains another AABB?
--
local function containsAABB(aabb, other)
    local l1, t1, r1, b1 = aabb:unpack()
    local l2, t2, r2, b2 = other:unpack()

    if l1 > r2 or l2 > r1 then return false end
    if t1 > b2 or t2 > b1 then return false end
    
    return true
end

-- Nearest point
--
local function nearest(aabb, point)
    local t = {
        -- x-checks
        { d = _.__abs(point.x - aabb.left),  p = Vec2(aabb.left,  point.y) },
        { d = _.__abs(aabb.right - point.x), p = Vec2(aabb.right, point.y) },
        -- y-checks
        { d = _.__abs(point.y - aabb.top),    p = Vec2(point.x, aabb.top) },
        { d = _.__abs(aabb.bottom - point.y), p = Vec2(point.x, aabb.bottom) }
    }

    -- sort by distance
    table.sort(t, function(i1, i2) return i1.d < i2.d end)

    return t[1].p:unpack()
end

---- ---- ---- ----

-- new bounding box
--
function AABB:new(...)
    local args = {...}

    self.left   = args[1]
    self.top    = args[2]
    self.right  = args[3]
    self.bottom = args[4]
end

---- ---- ---- ----

-- returns components
--
function AABB:unpack()
    return self.left,
           self.top,
           self.right,
           self.bottom
end

-- bounding box center
--
function AABB:center()
    return self.left + _.__floor(self:width() / 2),
           self.top  + _.__floor(self:height() / 2)
    
end

-- bounding box width
--
function AABB:width()
    return self.right - self.left
end

-- bounding box height
--
function AABB:height()
    return self.bottom - self.top
end

-- bounding box dimensions
--
function AABB:dimensions()
    return self:width(), self:height()
end

-- bounding box container
--
function AABB:container()
    return self.left, self.top, self:dimensions()
end

-- query - bounds contains another
--
function AABB:contains(...)
    local args = {...}

    if #args == 2 then
        return containsPoint(self, Vec2(args[1], args[2]))
    elseif args[1].__name == 'Vec2' then
        return containsPoint(self, args[1])
    elseif args[1].__name == 'AABB' then
        return containsAABB(self, args[1])
    end

    return false
end

-- query - is this AABB above other?
--
function AABB:isAbove(other, oy)
    return self.bottom + (oy or 0) < other.top
end

-- query - is this AABB below other?
--
function AABB:isBelow(other, oy)
    return self.top + (oy or 0) > other.bottom
end

-- query - is other AABB to the left?
--
function AABB:isLeft(other, ox)
    return self.right + (ox or 0) < other.left
end

-- query - is other AABB to the right?
--
function AABB:isRight(other, ox)
    return self.left + (ox or 0) > other.right
end

-- clamp to other AABB
--
function AABB:clamp(other)
    aabb = other:copy()

    if aabb.left < self.left then
        aabb.right = aabb.right + (self.left - aabb.left)
        aabb.left  = self.left
    end

    if aabb.right > self.right then
        aabb.left  = aabb.left - (aabb.right - self.right)
        aabb.right = self.right
    end

    if aabb.top < self.top then
        aabb.bottom = aabb.bottom + (self.top - aabb.top)
        aabb.top    = self.top
    end

    if aabb.bottom > self.bottom then
        aabb.top    = aabb.top - (aabb.bottom - self.bottom)
        aabb.bottom = self.bottom
    end

    return aabb
end

-- expand to include other AABB
--
function AABB:expand(other)
    return AABB(
        _.__min(self.left,   other.left),
        _.__min(self.top,    other.top),
        _.__max(self.right,  other.right),
        _.__max(self.bottom, other.bottom)
    )
end

-- generate new AABB translated
-- 
function AABB:translate(tx, ty)
    if not _:isNumber(tx) and tx.__name == 'Vec2' then
        tx, ty = tx:unpack()
    end

    return AABB:fromContainer(
        self.left + tx,
        self.top  + ty,
        self:width(),
        self:height()
    )
end

-- generate new scaled AABB
--
function AABB:scale(sx, sy)
    return AABB:fromContainer(
        self.left,
        self.top,
        self:width()  * sx,
        self:height() * (sy or sx)
    )
end

-- calculate minkowski difference
--
function AABB:minkowski(other)
    local x = other.left - self.left - self:width()
    local y = other.top  - self.top  - self:height()
    local w = self:width()  + other:width()
    local h = self:height() + other:height()
    
    return AABB:fromContainer(x, y, w, h)
end

-- project into another AABB
--
function AABB:project(other, dx, dy)
    local minBox = self:minkowski(other)
    local origin = Vec2()

    if minBox:contains(origin) then
        return nearest(minBox, origin)
    else
        -- -- tunnel
        -- local tunnel   = Segment(origin.x, origin.y, delta.x, delta.y)
        -- local interect = tunnel:vsAABB(minBox)
    end

    return 0, 0
end

-- draw
--
function AABB:draw()
    local r, g, b = lg.getColor()

    lg.setColor(r, g, b, 0.15)
    lg.rectangle('fill', self:container())
end

---- ---- ---- ----

function AABB:__eq(other)
    return self.left   == other.left  and
           self.top    == other.top   and
           self.right  == other.right and
           self.bottom == other.bottom
end

function AABB:__tostring()
    return 'AABB(' .. self.left .. ', ' .. self.top .. ', ' .. self.right .. ', ' .. self.bottom .. ')'
end

---- ---- ---- ----

function AABB:copy()
    return AABB(self:unpack())
end

function AABB:compute(cx, cy, width, height, rotation)
    -- calculate rotated vertices of each corner
    local x1, y1 = Vec2(-width / 2, -height / 2):rotate(rotation):unpack()
    local x2, y2 = Vec2( width / 2, -height / 2):rotate(rotation):unpack()
    local x3, y3 = Vec2( width / 2,  height / 2):rotate(rotation):unpack()
    local x4, y4 = Vec2(-width / 2,  height / 2):rotate(rotation):unpack()

    -- extents of rotated AABB
    local ex = _.__max(x1, x2, x3, x4)
    local ey = _.__max(y1, y2, y3, y4)

    -- new top,left/right/bottom coordinates
    x1 = cx - ex
    x2 = cx + ex
    y1 = cy - ey
    y2 = cy + ey

    return AABB(x1, y1, x2, y2)
end

--
--
function AABB:fromCenter(cx, cy, w, h)
    local hw, hh = w/2, h/2

    return AABB(cx - hw, cy - hh, cx + hw, cy + hh)
end

--
--
function AABB:fromContainer(x, y, w, h)
    return AABB(x, y, x + w, y + h)
end

return AABB
