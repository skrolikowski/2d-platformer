-- Base Item Entity
--

local Modern = require 'modern'
local Item   = Modern:extend()

-- New
--
function Item:new(data)
	--
	-- properties
	self.name   = data.name   or 'Item'
	self.qty    = data.qty    or 0
	self.qtyMax = data.qtyMax or 99

	-- flags
	self.isPassive = data.isPassive or false
end

-- Use
--
function Item:use(entity)
	self:decrease()
end

-- Passive effect
--
function Item:passive(entity)
	--
end

-- Does item exist?
--
function Item:exists()
	return self.qty > 0
end

-- Increase qty
--
function Item:increase(qty)
	self.qty = _.__min(self.qty + (qty or 1), self.qtyMax)
	return self.qty
end

-- Decrease qty
--
function Item:decrease(qty)
	self.qty = _.__max(self.qty - (qty or 1), 0)
end

return Item