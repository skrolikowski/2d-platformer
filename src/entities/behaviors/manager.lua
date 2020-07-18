-- Behavior Manager
--

local Modern  = require 'modern'
local Manager = Modern:extend()

-- New
--
function Manager:new(host)
	self.host  = host
	self.items = {}
	self.timer = Timer.new()
end

-- Teardown
--
function Manager:destroy()
	self.timer:clear()
	self:clear()
end

-- Update
-- passthru
--
function Manager:update(dt)
	self.timer:update(dt)
	--
	for __, behavior in pairs(self.items) do
		if behavior:update(dt) ~= true then
			return
		end
	end
end

---- ---- ---- ----

-- Event: onContact
-- passthru
--
function Manager:onContact(con)
	for __, behavior in pairs(self.items) do
		if behavior.onContact then
			behavior:onContact(con)
		end
	end
end

-- Event: onRangeContact
-- passthru
--
function Manager:onRangeContact(other)
	for __, behavior in pairs(self.items) do
		if behavior.onRangeContact then
			behavior:onRangeContact(other)
		end
	end
end

-- Event: offRangeContact
-- passthru
--
function Manager:offRangeContact(other)
	for __, behavior in pairs(self.items) do
		if behavior.offRangeContact then
			behavior:offRangeContact(other)
		end
	end
end

-- Event: onSightContact
-- passthru
--
function Manager:onSightContact(other)
	for __, behavior in pairs(self.items) do
		if behavior.onSightContact then
			behavior:onSightContact(other)
		end
	end
end

-- Event: offSightContact
-- passthru
--
function Manager:offSightContact(other)
	for __, behavior in pairs(self.items) do
		if behavior.offSightContact then
			behavior:offSightContact(other)
		end
	end
end

---- ---- ---- ----

-- Set (clearing existing behaviors)
--
function Manager:set(...)
	self:clear():add(...)

	return self
end


-- Clear existing behaviors
--
function Manager:clear()
	for i = #self.items, 1, -1 do
		self.items[i]:destroy()

		table.remove(self.items, i)
	end

	return self
end

-- Add to existing behaviors
--
function Manager:add(...)
	for __, name in pairs({...}) do
		if Behaviors[name] then
			table.insert(self.items, Behaviors[name](self))
		end
	end

	return self
end

return Manager