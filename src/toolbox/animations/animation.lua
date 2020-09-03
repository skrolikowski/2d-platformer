-- Animation API
-- Shane Krolikowski
--

-- Returns next frame index
--
local __nextFrame= function(obj)
	if obj.isReverse then
		return _.__max((obj.index - 1), 1)
	else
		return _.__min((obj.index + 1), #obj.quads)
	end
end

-- Is start of animation?
--
local __isStartOfAnim = function(obj)
	return obj.index == (obj.isReverse and #obj.quads or 1)
end

-- Is end of animation?
--
local __isEndOfAnim = function(obj)
	return obj.index == (obj.isReverse and 1 or #obj.quads)
end

-- Is end of sequence?
--
local __isEndOfSequence = function(obj)
	return obj.total and obj.total >= obj.count
end

-- Post animation loop
--
local __postAnim = function(obj)
	--
	-- animation count
	obj.count = obj.count + 1

	--
	if __isEndOfSequence(obj) then
		obj:onEndSequence()
	else
		obj:play()
	end
end

-- Advance to next frame in animation
--
local __advance = function(obj)
	obj.index = __nextFrame(obj)

	if __isEndOfAnim(obj) then
		__postAnim(obj)
		--
		obj:onEndAnimation()
	end
end

---- ---- ---- ----

local Modern    = require 'modern'
local Animation = Modern:extend()

-- New
--
function Animation:new(sheet)
	self.sheet = sheet
	self.delta = 1 / 10
	self.quads = {}

	-- flags
	self.isReverse = false
	self.isPlaying = false
end

-- Container
--
function Animation:container()
	return self.quads[self.index]:getViewport()
end

-- Get width/height
--
function Animation:dimensions()
	local x, y, w, h = self:container()

	return w, h
end

-- Update
--
function Animation:update(dt)
	if self.isPlaying then
		self.elapsed = (self.elapsed or 0) + dt

		if self.elapsed >= self.delta then
			self.elapsed = 0
			--
			__advance(self)
		end
	end
end

-- Draw
--
function Animation:draw()
	local x, y, w, h = self:container()

	lg.setColor(Config.color.white)
	lg.draw(
		self.sheet.image,        -- spritesheet
		self.quads[self.index],  -- quad
		0, 0, 0, 1, 1,
		(self.ox or 0) + w * 0.5,
		(self.oy or 0) + h * 0.5
	)
end

---- ---- ---- ----

-- Event: onEndAnimation
--
function Animation:onEndAnimation()
	--
end

-- Event: onEndSequence
--
function Animation:onEndSequence()
	--
	-- callback?
	if self.cbAfter then
		self.cbAfter(self)
	end

	--
	self:stop()
end

---- ---- ---- ----

-- Add frames
--
function Animation:frames(...)
	for __, data in pairs({...}) do
		local row, col = data[1], data[2]
		local rows     = data[3] or row
		local cols     = data[4] or col

		for r = row, rows do
			for c = col, cols do
				table.insert(self.quads, self.sheet:query(r, c))
			end
		end
	end

	return self
end

-- Play animation at fps
-- [Chain]
--
function Animation:at(fps)
	self.delta = 1 / fps
	return self
end

-- Animation offset
-- [Chain]
--
function Animation:offset(ox, oy)
	self.ox = ox or 0
	self.oy = oy or 0
	return self
end

-- Toggle animation direction
-- [Chain]
--
function Animation:reverse()
	self.isReverse = not self.isReverse
	return self
end

-- After animation callback
-- [Chain]
--
function Animation:after(cb)
	self.cbAfter = cb
	return self
end

-- Play animation once
-- [Chain]
--
function Animation:once()
	self.total = 1
	return self
end

-- Play animation twice
-- [Chain]
--
function Animation:twice()
	self.total = 2
	return self
end

-- Run animation number of times
-- [Chain]
--
function Animation:times(total)
	self.total = total
	return self
end

-- Play number of times
-- [Chain][Default]
--
function Animation:loop()
	self.total = nil
	return self
end

---- ---- ---- ----
-- Controls

-- Run animation
--
function Animation:play()
	self.isPlaying = true
	self.count     = 0
	self.index     = self.isReverse and #self.quads or 1
end

-- Run animation
-- [Alias]
--
function Animation:start()
	self:play()
end

-- Run animation
-- [Alias]
--
function Animation:run()
	self:play()
end

-- Stop animation
--
function Animation:stop()
	self.isPlaying = false
end

return Animation