local _COMBODELAY = 0.15
local _FRAMECOUNT = 8

local __time = function()
	return lt.getTime()
end

local __isGroup = function(value)
	return value:match('+') ~= nil
end

local __hasInput = function(frame, value)
	if __isGroup(value) then
		for v in string.gmatch(value, '[^+]+') do
			if frame[v] == false then
				return false
			end
		end
	end

	return frame[value] ~= false
end

local __expired = function(time, expires)
	return not time or (expires - time > _COMBODELAY)
end

local __isExpired = function(frame, value, expires)
	if __isGroup(value) then
		for v in string.gmatch(value, '[^+]+') do
			if not __expired(frame[v], expires) then
				return false
			end
		end
	end

	return __expired(frame[value], expires)
end
---- ---- ---- ----


local Modern = require 'modern'
local Input  = Modern:extend()

function Input:new(codes)
	self.inputs = {}
	self.holds  = {}
	self.frames = {}

	--
	for code, name in pairs(codes) do
		self.inputs[name] = false
	end
end

-- Record
--
function Input:record()
	table.insert(self.frames, 1, _:copy(self.inputs))

	-- clean up
	if #self.frames > _FRAMECOUNT then
		table.remove(self.frames, #self.frames)
	end
-- print(self)
end

-- Has
--
function Input:has(map)
	local now = __time()

	for idx, input in pairs(map) do
		--
		-- check for existence..
		local frame    = self.frames[idx]
		local hasInput = frame and __hasInput(frame, input)

		if not hasInput then
			return false
		end

		-- check for expiration..
		local expires   = now - (idx - 1) * _COMBODELAY
		local isExpired = __isExpired(frame, input, expires)

		if isExpired then
			return false
		end
	end

	return true
end

--
--
function Input:holding(cb)
	local now = __time()

	for name, time in pairs(self.inputs) do
		if time and _.__abs(now - time) > 0.5 then
			cb(name)
		end
	end
end

-- Input pressed
--
function Input:onPressed(name)
	self.inputs[name] = __time()
	--
	self:record()
end

-- Input released
--
function Input:onReleased(name)
	self.inputs[name] = false
end

--
--
function Input:isActive(input)
	return __hasInput(self.inputs, input)
end

-- __tostring
--
function Input:__tostring()
	local outer = {}
	local inner, value

	for name, __ in pairs(self.inputs) do
		inner = { name }

		for i = 1, #self.frames, 1 do
			if self.frames[i][name] then
				table.insert(inner, "| 0")
			else
				table.insert(inner, "| X")
			end
		end

		table.insert(outer, table.concat(inner, "\t"))
	end

	return "----\n" .. table.concat(outer, "\n")
end

return Input