-- Game World
--

local Modern = require 'modern'
local World  = Modern:extend()

-- New
--
function World:new(game)
	self.game   = game
	self.width  = game.map.width  * game.map.tilewidth
	self.height = game.map.height * game.map.tileheight
	self.grid   = Grid(self, game.map.tilewidth)
	self.items  = {}
end

-- teardown
--
function World:destroy()
	--
end

---- ---- ---- ----

function World:addLayer(layer)
	for __, object in pairs(layer.objects) do
		local name    = _.__lower(object.name ~= '' and object.name or layer.name)
		local path    = Entities[name]
		local options = {
			name  = name,
			x     = object.x + object.width  / 2,
			y     = object.y + object.height / 2,
			w     = object.width,
			h     = object.height,
			props = object.properties,
		}

		new(path, options)
	end
end

---- ---- ---- ----

-- world dimensions
--
function World:dimension()
	return self.width, self.height
end

-- world bounding box
--
function World:aabb()
	if not self.aabb then
		self.aabb = AABB(0, 0, self:dimension())
	end

	return self.aabb
end

---- ---- ---- ----

-- Query - get items in bounds
--
function World:queryPoint(x, y, cb)
	local cell    = self.grid:queryCellAtPoint(x, y)
	local visited = {}

	for __, item in pairs(cell.items) do
		if not visited[item.id] then
			if item:aabb():contains(x, y) then
				cb(item)
			end
			--
			visited[item.id] = true
		end
	end
end

-- Query - get items containing line segment
--
function World:querySegment(x1, y1, x2, y2, cb)
	local cells   = self.grid:queryCellsOnSegment(x1, y1, x2, y2)
	local visited = {}

	for __, cell in pairs(cells) do
		for __, item in pairs(cell.items) do
			if not visited[item.id] then
				if Segment(x1, y1, x2, y2):vsAABB(item:aabb()) then
					cb(item)
				end

				visited[item.id] = true
			end
		end
	end
end

-- query - get items within bounding box
--
function World:queryBounds(bounds, cb)
	local cells   = self.grid:queryCellsInBounds(bounds)
	local visited = {}

	for __, cell in pairs(cells) do
		for __, item in pairs(cell.items) do
			if not visited[item.id] then
				if bounds:contains(item:aabb()) then
					cb(item)
				end
				--
				visited[item.id] = true
			end
		end
	end
end

-- query - get items within view
--
function World:queryScreen(cb)
	local bounds = AABB:fromContainer(0, 0, Config.width, Config.height)
    return self:queryBounds(bounds, cb)
end

-- query - get all items in World
--
function World:queryWorld(cb)
	local bounds = AABB:fromContainer(0, 0, self.width, self.height)
    return self:queryBounds(bounds, cb)
end

-- query - get all contacts of item moving to dx, dy
--
function World:queryContacts(item, dx, dy, cb)
	local boxStart = item:aabb()
	local boxEnd   = boxStart:translate(dx, dy)
	local boxFull  = boxStart:expand(boxEnd)
	local contacts = {}

	--
	-- query collisions within bounding path
	self:queryBounds(boxFull, function(other)
		if item.id ~= other.id then
			local contact = Contact(item, other)

			if contact:project(dx, dy) then
				table.insert(contacts, contact)
			end
		end
	end)

	-- -- sort by order
	-- table.sort(contacts, function(a, b)
	-- 	return a.order < b.order
	-- end)

	-- make callbacks (in order)
	if cb then
		for __, contact in pairs(contacts) do
			cb(contact)
		end
	end

	return contacts
end

---- ---- ---- ----

-- add item to world
--
function World:add(item)
	item.id    = item.id or Util:uuid()
	item.world = self

	-- register
	self.items[item.id] = item

	--
	-- add item to cells
	local bounds = item:aabb()
	local cells  = self.grid:queryCellsInBounds(bounds)

	for __, cell in pairs(cells) do
		cell:add(item)
	end

	return item
end

-- remove item from world
--
function World:remove(item)
	if self.items[item.id] then
		local bounds = item:aabb()
		local cells  = self.grid:queryCellsInBounds(bounds)

		-- remove item from cells
		for __, cell in pairs(cells) do
			cell:remove(item)
		end

		-- unregister
		self.items[item.id] = nil
	end
end

-- resize item; keeps base position
--
function World:resizeItem(item, data)
	local ow = item._width
	local oh = item._height
	local nw = data.w or ow
	local nh = data.h or oh

	if ow ~= nw or oh ~= nh then
		self:update(item, {
			x = item._pos.x + (ow - nw) * 0.5,
			y = item._pos.y + (oh - nh) * 0.5,
			w = nw,
			h = nh
		})
	end
end

-- update item pos/dimensions in world
--
function World:update(item, data)
	-- old values
	local _x, _y = item._pos.x, item._pos.y
	local _w, _h = item._width, item._height
	-- new values
	local nx = data.x or _x
	local ny = data.y or _y
	local nw = data.w or _w
	local nh = data.h or _h

	if _x ~= nx or _y ~= ny or
	   _w ~= nw or _h ~= nh
	then
		-- remove
		self:remove(item)

		-- update
		item:pos({ x = nx, y = ny })
		item:width(nw)
		item:height(nh)
		item:aabb(AABB:fromCenter(nx, ny, nw, nh))

		-- re-add
		self:add(item)
	end
end

-- move item in world to target position
--
function World:move(item, nextPos)
	local cx, cy = item:center()
	local dx, dy = nextPos.x - cx, nextPos.y - cy

	if dx ~= 0 or dy ~= 0 then
		self:queryContacts(item, dx, dy, function(con)
			con.other:dispatch('onResolve', con, nextPos)
			con.other:dispatch('onContact', con, item)
			--
			item:dispatch('onContact', con, con.other)
		end)

		-- update position
		self:update(item, {
			x = nextPos.x,
			y = nextPos.y
		})
	end
end

return World