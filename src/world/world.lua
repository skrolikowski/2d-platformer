local Modern = require 'vendor.modern'
local World  = Modern:extend()

-- new world
--
function World:new(game)
	self.game   = game
	self.width  = game.map.width  * game.map.tilewidth
	self.height = game.map.height * game.map.tileheight
	self.grid   = Grid(self, game.map.tilewidth)
	--
	self.items = {}
	-- self.cons  = {}
end

-- teardown
--
function World:destroy()
	--
end

---- ---- ---- ----

function World:addLayer(layer)
	for __, obj in pairs(layer.objects) do
		local name = _.__lower(obj.name ~= '' and obj.name or layer.name)

		self:add(
			Entities[name](obj)
		)
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
function World:bounds()
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
			if item:bounds():contains(x, y) then
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
	-- local cells   = self.grid:queryCellsOnSegment(x1, y1, x2, y2)
	-- local visited = {}

	-- for __, cell in pairs(cells) do
	-- 	for __, item in pairs(cell.items) do
	-- 		if not visited[item.id] then
	-- 			--TODO: 

	-- 			visited[item.id] = true
	-- 		end
	-- 	end
	-- end
end

-- query - get items within bounding box
--
function World:queryBounds(bounds, cb)
	local cells   = self.grid:queryCellsInBounds(bounds)
	local visited = {}

	for __, cell in pairs(cells) do
		for __, item in pairs(cell.items) do
			if not visited[item.id] then
				if bounds:contains(item:bounds()) then
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
	-- TODO:
    return self:queryWorld(cb)
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
	local boxStart = item:bounds()
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

	-- sort by order
	table.sort(contacts, function(a, b)
		return a.order < b.order
	end)

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

	-- if not self.cons[item.id] then
	-- 	self.cons[item.id] = {}
	-- end

	--
	-- add item to cells
	local bounds = item:bounds()
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
		local bounds = item:bounds()
		local cells  = self.grid:queryCellsInBounds(bounds)

		-- remove item from cells
		for __, cell in pairs(cells) do
			cell:remove(item)
		end

		-- unregister
		self.items[item.id] = nil
	end
end

-- update item pos/dimensions in world
--
function World:update(item, cx, cy, w, h)
	if item.pos.x ~= cx or item.pos.y ~= cy then
		--
		-- remove
		self:remove(item)

		local _w, _h = item:dimensions()
		--
		-- update position/dimensions
		item.pos.x  = cx
		item.pos.y  = cy
		item.width  = w or _w
		item.height = h or _h

		-- re-add
		self:add(item)
	end
end

-- move item in world to target position
--
function World:move(item, nextPos)
	local cx, cy   = item:center()
	local dx, dy   = nextPos.x - cx, nextPos.y - cy
	local continue = true

	if cx ~= tx or cy ~= ty then
		self:queryContacts(item, dx, dy, function(con)
			if continue ~= false then
				continue = con.other:resolve(con, nextPos)
				
				-- notify item
				item:onContact(con)
			end
		end)

		-- update position
		self:update(item, nextPos:unpack())
	end
end

return World