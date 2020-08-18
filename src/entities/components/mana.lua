-- Mana Component
--

local Base    = require 'modern'
local Mana = Base:extend()

-- New
--
function Mana:new(host, data)
	self.host = host

	--
	-- properties
	self._mp    = data.mp or 100
	self._mpMax = self._mp
end

-- Get/set `mp` value.
--
function Mana:mp(value)
	if value == nil then
		return self._mp
	end

	self._mp = value
end

-- Get/set `mpMax` value.
--
function Mana:mpMax(value)
	if value == nil then
		return self._mpMax
	end

	self._mpMax = value
end

-- HP Pct
--
function Mana:mpPct()
	return self._mp / self._mpMax
end

-- Increase
--
function Mana:increaseMp(value)
	self:mp(_.__min(self._mp + value, self._mpMax))
end

-- Decrease
--
function Mana:decreaseMp(value)
	self:mp(_.__max(0, self._mp - value))
end

return Mana