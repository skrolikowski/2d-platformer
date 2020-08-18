local __dispatch = function(cb, ...)
	if _:isTable(cb) then
		for __, cb in pairs(cb) do
			cb(...)
		end
	elseif _:isFunction(cb) then
		cb(...)
	end
end
--


local Codes = require 'src.toolbox.controls.config'
local Input = require 'src.toolbox.controls.input'
local Map   = require 'src.toolbox.controls.map'
--
local Modern  = require 'modern'
local Control = Modern:extend()

-- New
--
function Control:new(maps)
	self.input = Input(Codes)
	self.map   = Map(maps)

	-- HOLD
	-- Timer.every(0.25, function()
	-- 	self.input:holding(function(input)
	-- 		print('hold' .. _:upperFirst(input))
	-- 		_:dispatch('hold' .. _:upperFirst(act))
	-- 	end)
	-- end)
end

-- Update
--
function Control:update(dt)
	--
end

-- Input pressed..
--
function Control:onPressed(code, ...)
	local name = Codes[code]
	local args = ...

	if name then
		self.input:onPressed(name)
		--
		self.map:onPressed(self.input, function(map)
			if _:isFunction(map.cb) then
			--
			-- shortcut - single callback
				__dispatch(map.cb, args)
			else
			--
			-- standard - on callback
				__dispatch(map.cb.on, args)
			end
		end)
	end
end

-- Input released..
--
function Control:onReleased(code, ...)
	local name = Codes[code]
	local args = ...

	if name then
		self.input:onReleased(name)
		--
		self.map:onReleased(self.input, function(map, args)
			if not _:isFunction(map.cb) then
				__dispatch(map.cb.off, args)
			end
		end)
	end
end

return Control