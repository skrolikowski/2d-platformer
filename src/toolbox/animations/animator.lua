-- Animator Util
-- Shane Krolikowski
--

local Modern   = require 'modern'
local Animator = Modern:extend()

-- New
--
function Animator:new(items)
	self.current = nil
	self.items   = {}

	--
	for name, item in pairs(items or {}) do
		self:add(name, item)
	end
end

-- Add animation
--
function Animator:add(name, item)
	self.items[name] = item
end

-- Remove animation
--
function Animator:remove(name)
	self.items[name] = nil
end

-- Set animation
--
function Animator:set(name)
	if self:has(name) and self.current ~= name then
		self.current = name
		--
		self.items[name]:play()
	end
end

-- Get animation
--
function Animator:get(name)
	return self.items[name] or nil
end

-- Has animation
--
function Animator:has(name)
	return name ~= nil and
	       self.items[name] ~= nil
end

-- Perform callback on each item
--
function Animator:each(cb)
	for name, item in pairs(self.items) do
		cb(item, name)
	end
end

-- Update
--
function Animator:update(dt)
	if self:has(self.current) then
		self:get(self.current):update(dt)
	end
end

-- Draw
--
function Animator:draw()
	if self:has(self.current) then
		self:get(self.current):draw()
	end
end

return Animator