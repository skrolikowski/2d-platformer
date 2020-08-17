local __buildSequence = function(value)
	local out = {}
	
	for m in string.gmatch(value, '[^,]+') do
		table.insert(out, 1, m)
	end
	
	return out
end
--


local Modern = require 'modern'
local Map    = Modern:extend()

-- New
--
function Map:new(maps)
	self.maps   = {}
	self.active = {}

	--
	for input, cb in pairs(maps) do
		table.insert(self.maps, {
			raw = input,
			seq = __buildSequence(input),
			cb  = cb
		})
	end
	-- print(self)
end

-- Event: onPressed
--
function Map:onPressed(input, cb)
	for __, map in pairs(self.maps) do
		if input:has(map.seq) then
			self.active[map.raw] = map
			--
			cb(map)
		end
	end
end

-- Event: onReleased
--
function Map:onReleased(input, cb)
	for key, map in pairs(self.active) do
		if not input:isActive(map.seq[1]) then
			self.active[key] = nil
			--
			cb(map)
		end
	end
end

---- ---- ---- ----

function Map:__tostring()
	local out = {}

	for __, map in pairs(self.maps) do
		table.insert(out,
			string.format(
				'[%s]: on[%s], off[%s]',
				table.concat(map.seq, ','),
				map.cb.on  and 'x' or ' ',
				map.cb.off and 'x' or ' '
			)
		)
	end

	return table.concat(out, "\n")
end

return Map