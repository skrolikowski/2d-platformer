-- Target Component
--

local Base   = require 'modern'
local Target = Base:extend()

-- New
--
function Target:new(host, data)
	self.host = host
	
	--
	-- properties
	self._targets     = {}
	self._targetCount = 0
	self._detects     = data.detects or {}
end

-- Get/set `detects` value.
--
function Target:detects(value)
	if value == nil then
		return self._detects
	end

	if type(value) ~= 'table' then
		value = { value }
	end

	self._detects = Util:toBoolean(value)
end

function Target:addTarget(other)
	if not self:hasTarget(other.id) then
		self._targets[other.id] = other
		self._targetCount       = self._targetCount + 1
		--
		self.host:dispatch('targetAdded', other)
	end
end

function Target:removeTarget(other)
	if self:hasTarget(other.id) then
		self._targets[other.id] = nil
		self._targetCount       = self._targetCount - 1
		--
		self.host:dispatch('targetRemoved', other)
	end
end

-- Has target with `id`.
--
function Target:hasTarget(id)
	return self._targets[id]
end

-- Has 1 or many targets?
--
function Target:hasTargets()
	return self._targetCount > 0
end

return Target