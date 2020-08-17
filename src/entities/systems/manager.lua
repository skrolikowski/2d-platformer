-- Systems Manager
--

local Modern  = require 'modern'
local Manager = Modern:extend()

-- New
--
function Manager:new(host, items)
	self.host  = host
	self.items = {}

	--
	self:add(items or {})
end

-- Teardown
--
function Manager:destroy()
	self:clear()
end

-- Dispatch event
--
function Manager:dispatch(event, ...)
	for name, system in pairs(self.items) do
		if system[event] then
			system[event](system, ...)
		end
	end
end

-- Update
--
function Manager:update(dt)
	for name, item in pairs(self.items) do
		item:update(dt)
	end
end

-- Draw
--
function Manager:draw()
	for name, item in pairs(self.items) do
		item:draw()
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
	return self.items[name] ~= nil
end

-- Clear existing items
--
function Manager:clear()
	for name, item in pairs(self.items) do
		if item.destroy then
			item:destroy()
		end
		--
		self.items[name] = nil
	end

	return self
end

-- Add to existing items
--
function Manager:add(items)
	local name, args

	for k, v in pairs(items) do
		if _:isNumber(k) then
			name, args = v, {}
		else
			name, args = k, v
		end

		if not self:has(name) then
			assert(Systems[name] ~= nil, "System `"..name.."` does not exist.")
			
			self.items[name] = Systems[name](self.host, args)
		end
	end
end

return Manager