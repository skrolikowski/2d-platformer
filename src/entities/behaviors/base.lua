-- Base Behavior
--

local Modern   = require 'vendor/modern'
local Behavior = Modern:extend()

-- New
--
function Behavior:new(name, manager, systems)
	self.id    = Util:uuid()
	self.name  = name or 'behavior'
	self.host  = manager.host
	self.timer = manager.timer

	--
	manager.host:addSystems(systems)
end

-- Teardown
--
function Behavior:destory()
	--
end

-- Pass
--
function Behavior:pass()
	return true
end

-- Clear
--
function Behavior:clear()
	--
end

-- Update
--
function Behavior:update(dt)
	if self:pass() then
		return self:execute(dt)
	end

	return true
end

-- -- Does behavior have requirements?
-- --
-- function Behavior:validate(names)
-- 	if type(names) ~= 'table' then
-- 		names = { names }
-- 	end

-- 	for __, name in pairs(names) do
-- 		if not self.host:hasSystem(name) then
-- 			error("Behavior invalid - missing System: `" .. name .. "`.")
-- 		end
-- 	end
-- end

return Behavior