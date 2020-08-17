-- Behavior Manager
--

local Modern  = require 'modern'
local Manager = Modern:extend()

-- New
--
function Manager:new(host, items)
	self.host  = host
	self.items = {}
	self.timer = Timer.new()

	--
	self:add(items or {})
end

-- Teardown
--
function Manager:destroy()
	self.timer:clear()
	--
	self:clear()
end

-- Dispatch events
--
function Manager:dispatch(event, ...)
	for __, item in pairs(self.items) do
		if item[event] then
			item[event](item, ...)
		end
	end
end

-- Update
--
function Manager:update(dt)
	self.timer:update(dt)

	--
	local aborted = false

	for __, item in pairs(self.items) do
		if not aborted then
		--
		-- execute, on pass..
			if item:pass() then
				aborted = (item:execute() == true)
			end
		else
		--
		-- clear aborted items..
			item:clear()
		end
	end
end

---- ---- ---- ----

-- Set (clearing existing items)
--
function Manager:set(...)
	self:clear():add(...)

	return self
end

-- Has item with `name`?
--
function Manager:has(name)
	return _:find(self.items, function(v, k)
		return v.name == name
	end) ~= nil
end

-- Clear existing items
--
function Manager:clear()
	for i = #self.items, 1, -1 do
		if self.items[i].destroy then
			self.items[i]:destroy()
		end
		
		table.remove(self.items, i)
	end

	return self
end

-- Add to existing items
--
function Manager:add(items)
	local name, args

	for __, item in pairs(items) do
		name = item[1]
		args = item[2] or {}

		if not self:has(name) then
			assert(Behaviors[name] ~= nil, "Behavior `"..name.."` does not exist.")
		
			table.insert(self.items, Behaviors[name](self, args))
		end
	end

	return self
end

return Manager