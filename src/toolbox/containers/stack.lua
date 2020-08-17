local Modern = require 'modern'
local Stack  = Modern:extend()

-- New
--
function Stack:new()
    self.items = {}
end

-- Put
--
function Stack:put(items)
    table.insert(self.items, 1, items)
end

-- Peek
--
function Stack:peek()
    return self.items[1]
end

-- Get
--
function Stack:get()
    if self:isEmpty() then
        return false
    end

    return table.remove(self.items, 1)
end

-- Find first item and return it
--
function Stack:find(key, value)
	for __, item in pairs(self.items) do
		if item[key] and item[key] == value then
			return item
		end
	end

	return false
end

-- Size
--
function Stack:size()
    return #self.items
end

-- isEmpty
--
function Stack:isEmpty()
    return #self.items == 0
end

return Stack