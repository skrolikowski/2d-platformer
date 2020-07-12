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

-- Reset
--
function Grid:reset()
	for __, cell in pairs(self.cells) do
		cell.items = {}
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
-- Credit:
--   https://theshoemaker.de/2016/02/ray-casting-in-2d-grids/
--
function Grid:queryCellsOnSegment(x1, y1, x2, y2)
	function init(origin, dir)
        local size = self.cellSize
        local tile = _.__floor(origin / size) + 1
        local step, tMax, tDelta

        if dir < 0 then
            step = -1
            tMax = (origin - size * (tile - 1)) / -dir
        else
            step = 1
            tMax = dir ~= 0 and (size * tile - origin) / dir or _.__huge
        end

        tDelta = size / dir * step

        return tile, step, tMax, tDelta
    end

    --
    local cells = {}
    local cell1 = self:queryCellAtPoint(x1, y1)
    local cellN = self:queryCellAtPoint(x2, y2)

    -- add initial cell..
    table.insert(cells, cell1)

    if cell1.col ~= cellN.col or cell1.row ~= cellN.row then
		local ray           = Vec2(x2 - x1, y2 - y1)
		local x, sx, tx, dx = init(x1, ray.x)
		local y, sy, ty, dy = init(y1, ray.y)

		while _.__abs(x - cellN.col) + _.__abs(y - cellN.row) > 0 do
	        local t    = _.__min(tx, ty)
	        local mark = Vec2(x1 + ray.x * t, y1 + ray.y * t)

	        -- add cell
	        table.insert(cells, cell)

	        if tx < ty then
				tx = tx + dx
				x  = x  + sx
				--
				local leftCell  = self:queryCellAtPoint(mark.x-1, mark.y)
				local rightCell = self:queryCellAtPoint(mark.x+1, mark.y)

				table.insert(cells, leftCell)
				table.insert(cells, rightCell)
			else
				ty = ty + dy
				y  = y  + sy
				--
				local topCell    = self:queryCellAtPoint(mark.x, mark.y-1)
				local bottomCell = self:queryCellAtPoint(mark.x, mark.y+1)

				table.insert(cells, topCell)
				table.insert(cells, bottomCell)
	        end
	    end
	end

	return cells
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