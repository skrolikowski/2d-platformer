-- Health Component
--

local Base   = require 'modern'
local Health = Base:extend()

-- New
--
function Health:new(host, data)
	self.host = host

	--
	-- properties
	self._hp    = data.hp or 100
	self._hpMax = self._hp
end

-- Get/set `hp` value.
--
function Health:hp(value)
	if value == nil then
		return self._hp
	end

	self._hp = value
end

-- Get/set `hpMax` value.
--
function Health:hpMax(value)
	if value == nil then
		return self._hpMax
	end

	self._hpMax = value
end

-- HP Pct
--
function Health:hpPct()
	return self._hp / self._hpMax
end

-- Increase
--
function Health:increaseHp(value)
	self:hp(_.__min(self._hp + value, self._hpMax))
end

-- Decrease
--
function Health:decreaseHp(value)
	self:hp(_.__max(0, self._hp - value))
end

return Health