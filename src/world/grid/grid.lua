-- Grid
--

local Modern = require 'vendor.modern'
local Grid   = Modern:extend()

-- New Grid
--
function Grid:new(world, cellSize)
	self.world    = world
	self.cellSize = cellSize or 16
	self.rows     = _.__ceil(world.height / self.cellSize)
	self.cols     = _.__ceil(world.width  / self.cellSize)
	self.cells    = {}

	--
	-- create cells
	for r = 1, self.rows do
		for c = 1, self.cols do
			table.insert(self.cells, Cell(self, r, c))
		end
	end
end

-- Tear down
--
function Grid:destroy()
	--
end

---- ---- ---- ----

function Grid:dimensions()
	return self.world.width, self.world.height
end

function Grid:bounds()
	if not self.aabb then
		self.aabb = AABB:fromContainer(0, 0, self:dimensions())
	end

	return self.aabb
end

---- ---- ---- ----

-- Query - get cell index at row/col-coords
--
function Grid:queryIndex(row, col)
	return ((col-1) + (row-1) * self.cols) + 1
end

-- Query - get cell at row/col-coords
--
function Grid:queryCell(row, col)
	if self:isValid(row, col) then
		return self.cells[self:queryIndex(row, col)]
	end
end

-- Query - get cell at x/y-coords
--
function Grid:queryRowColAtPoint(x, y)
	return _.__floor(y / self.cellSize) + 1,
	       _.__floor(x / self.cellSize) + 1
end

-- Query - get row/col at x/y-coords
--
function Grid:queryCellAtPoint(x, y)
	return self:queryCell(
		self:queryRowColAtPoint(x, y)
	)
end

-- Query - get cells in bounds
--
function Grid:queryCellsInBounds(bounds)
	local l, t, r, b = self:bounds():clamp(bounds):unpack()
	local r1, c1     = self:queryRowColAtPoint(l, t)
	local r2, c2     = self:queryRowColAtPoint(r-0.01, b-0.01)
	local cells      = {}

	for r = r1, r2 do
		for c = c1, c2 do
			table.insert(cells, self:queryCell(r, c))
		end
	end

	return cells
end

-- Query - get cells on line segment
--
function Grid:queryCellsOnSegment(x1, y1, x2, y2)
	local cell   = self:queryCellAtPoint(x1, y1)
	local x0, y0 = cell:position()
	local ray    = Vec2(x2 - x1, y2 - y1)
	local dtx    = ray.x == 0 and 1 or _.__abs(1 / ray.x)
	local dty    = ray.y == 0 and 1 or _.__abs(1 / ray.y)
	local stepX, stepY = 0, 0
	local dix, diy

	if ray.x < 0 then
		stepX = -1;
	    dix   = (x1 - x0) * dtx;
	else
	    stepX = 1;
	    dix   = (x0 + 1.0 - x1) * dtx;
	end

	if ray.y < 0 then
    	stepY = -1;
        diy   = (y1 - y0) * dty;
    else
        stepY = 1;
        diy   = (y0 + 1.0 - y1) * dty;
    end
end

---- ---- ---- ----

-- Is valid coordinates?
--
function Grid:isValid(row, col)
	return row > 0 and
	       row <= self.rows and
	       col > 0 and
	       col <= self.cols
end

-- Is valid index?
--
function Grid:isValidIndex(index)
	return index > 0 and index <= #self.cells
end

---- ---- ---- ----

-- Draw
--
function Grid:draw()
	for __, cell in pairs(self.cells) do
		cell:draw()
	end
end

return Grid