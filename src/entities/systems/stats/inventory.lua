-- Inventory System
--

local Base      = require 'src.entities.systems.base'
local Inventory = Base:extend()

-- New
--
function Inventory:new(host, data)
	Base.new(self, host, { })
	
	--
	-- properties
	self.items = {}
end

-- Add item
--
function Invetory:add(name, data)
	if self:has(name) then
		self.items[name]:increase(data.qty or 1);
	else
		self.items[name] = Item[name](data)
	end
end

-- Remove item
--
function Inventory:remove(name)
	self.items[name] = nil
end

-- Event: onRqUseItem
--
function Inventory:onRqUseItem(name)
	if self.items[name]:canUse() then
		self.items[name]:use(self.host)
	end
end

-- Has item?
--
function Inventory:has(name)
	return self.items[name] ~= nil
end

-- Update
--
function Inventory:update(dt)
	for __, item in pairs(self.items) do
		if not item:exists() then
			self:remove(item.name)
		elseif item.passive then
			item:passive(self.host)
		end
	end
end

return Inventory