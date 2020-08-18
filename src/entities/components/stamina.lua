-- Stamina Component
--

local Base    = require 'modern'
local Stamina = Base:extend()

-- New
--
function Stamina:new(host, data)
	self.host = host

	--
	-- properties
	self._sp    = data.sp or 100
	self._spMax = self._sp
end

-- Get/set `sp` value.
--
function Stamina:sp(value)
	if value == nil then
		return self._sp
	end

	self._sp = value
end

-- Get/set `spMax` value.
--
function Stamina:spMax(value)
	if value == nil then
		return self._spMax
	end

	self._spMax = value
end

-- HP Pct
--
function Stamina:spPct()
	return self._sp / self._spMax
end

-- Increase
--
function Stamina:increaseSp(value)
	self:sp(_.__min(self._sp + value, self._spMax))
end

-- Decrease
--
function Stamina:decreaseSp(value)
	self:sp(_.__max(0, self._sp - value))
end

return Stamina