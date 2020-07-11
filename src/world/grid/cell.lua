-- Grid Cell
--

local Modern = require 'vendor.modern'
local Cell   = Modern:extend()

-- New Cell
--
function Cell:new(grid, row, col)
	self.grid = grid
	self.row  = row
	self.col  = col

	-- items in cell
	self.items = {}
end

-- Tear down
--
function Cell:destroy()
	--
end

---- ---- ---- ----

-- add item to cell
--
function Cell:add(item)
	self.items[item.id] = item
end

-- remove item from cell
--
function Cell:remove(item)
	if self.items[item.id] then
		self.items[item.id] = nil
	end
end

---- ---- ---- ----

function Cell:unpack()
	return self.row, self.col
end

-- Center position
--
function Cell:center()
	local x, y = self:position()
	local w, h = self:dimensions()

	return x + w/2, y + h/2
end

-- Top left corner position
--
function Cell:position()
	return (self.col - 1) * self.grid.cellSize,
	       (self.row - 1) * self.grid.cellSize
end

-- cell dimensions
--
function Cell:dimensions()
	return self.grid.cellSize,
	       self.grid.cellSize
end

-- cell bounding box
--
function Cell:bounds()
	if not self.aabb then
		local x, y = self:position()
		local w, h = self:dimensions()

		self.aabb = AABB(x, y, x+w, y+h)
	end

	return self.aabb
end

-- Cell dimensions
--
function Cell:container()
	return self:bounds():container()
end

---- ---- ---- ----

-- Query - get neighboring cells
--
function Cell:queryNeighbors()
	return {
        top    = self.grid:getCell(self.row - 1, self.col + 0),
		left   = self.grid:getCell(self.row + 0, self.col - 1),
		right  = self.grid:getCell(self.row + 0, self.col + 1),
		bottom = self.grid:getCell(self.row + 1, self.col + 0),
    }
end

---- ---- ---- ----

-- Draw
--
function Cell:draw()
    lg.setColor(1, 1, 1, 0.15)
    lg.rectangle('line', self:container())

    if _:size(self.items) > 0 then
	    lg.setColor(1, 0, 0, 0.25)
	    lg.rectangle('fill', self:container())
	end
end

---- ---- ---- ----

-- __tostring operator
--
function Cell:__tostring()
    return 'Cell(' .. self.row .. ', ' .. self.col .. ')'
end

return Cell