-- Base Entity
--

local Modern = require 'modern'
local Entity = Modern:extend()

function Entity:new(data)
	--
	-- properties
	self.id     = Util:uuid()
	self.name   = data.name or 'Entity'
	self.mixins = {}  -- aka, components

	-- components
	if data.mixins then
		self:addComponents(data.mixins)
	end

	-- add to world
	Gamestate:current().world:add(self)
end

-- Teardown
--
function Entity:destroy()
	self.world:remove(self)
end

-- Dispatch event
--
function Entity:dispatch(event, ...)
	if self[event] then
		self[event](self, ...)
	end
end

-- Update
--
function Entity:update(dt)
	--
end

-- Draw
--
function Entity:draw()
	--
end

---- ---- ---- ----

-- Add Components
--
function Entity:addComponents(components)
	local name, args

	for k, v in pairs(components) do

		if _:isNumber(k) then
			name, args = v, {}
		else
			name, args = k, v
		end

		assert(Components[name] ~= nil, "Component `"..name.."` does not exist.")
		
		-- require once..
		if self.mixins[name] == nil then
			self.mixins[name] = true
			--
			Entity.addMixin(self, Components[name](self, args))
		end
	end
end

return Entity