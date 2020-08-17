-- Animator util
-- Shane Krolikowski
--

local Modern   = require 'modern'
local Animator = Modern:extend()

-- Create new Animator instance
--
function Animator:new()
	self.current    = nil
	self.animations = {}
end

-- Add new animation
--
function Animator:addAnimation(name, options)
	local image  = options.image
	local width  = options.width  or image:getWidth()
	local height = options.height or image:getHeight()
	local frames = nil

	if options.frames then
		frames = self:parseFrames(options.frames, image, width, height)
	end

	self.animations[name] = {
		name    = name,
		image   = image,
		width   = width,
		height  = height,
		frames  = frames,
		reverse = options.reverse or false,
		ox      = options.ox or 0,
		oy      = options.oy or 0,
		fps     = options.fps   or 10,
		total   = options.total or nil,
		after   = options.after or function() end
	}

	if not self.current then
		self:switchTo(name)
	end
end

-- Remove an existing animation
--
function Animator:removeAnimation(name)
	if self.animations[name] then
		self.animations[name] = nil
	end
end

-- Parse frames requested for image
--
function Animator:parseFrames(segments, image, width, height)
	local frames = {}
	local row, col

	for __, segment in pairs(segments) do
		row     = segment[1]
		col     = segment[2]
		lastRow = segment[3] or row
		lastCol = segment[4] or col

		for r = row, lastRow do
			for c = col, lastCol do
				table.insert(
					frames,
					lg.newQuad(
						(c - 1) * width,
						(r - 1) * height,
						width,
						height,
						image:getDimensions()
					)
				)
			end
		end
	end

	return frames
end

-- Get current animation frame's dimensions
--
function Animator:dimensions()
	if self.current then
		return self.current.width, self.current.height
	end

	return 0, 0
end

-- Get current animation frame's offsets
--
function Animator:offsets()
	if self.current then
		return self.current.ox, self.current.oy
	end

	return 0, 0
end

-- Switch to different animation
--
function Animator:switchTo(name, frame)
	if self.animations[name] then
		if not self.current or (self.current and self.current.name ~= name) then
			self.current = self.animations[name]

			-- setup
			if self.current.frames then
				if self.current.reverse then
					self.current.frame = frame or #self.current.frames
				else
					self.current.frame = frame or 1
				end

				self.current.timer   = 1 / self.current.fps
				self.current.count   = 0
				self.current.playing = true
			else
				self.current.playing = false
			end
		end
	end
end

-- Play
--
function Animator:play(current)
	current.playing = true
end

-- Play
--
function Animator:replay(current)
	current.playing = true
	current.frame   = current.reverse and #current.frames or 1
end

-- Move to next frame
--
function Animator:roll(current)
	if current.reverse then
		self:prev(current)
	else
		self:next(current)
	end
end

function Animator:pause(current)
	current.playing = false
end

-- Move to prev frame in sequence
--
function Animator:prev(current)
	current.frame = current.frame - 1
	current.frame = _.__max(current.frame, 1)
end

-- Move to next frame in sequence
--
function Animator:next(current)
	current.frame = current.frame + 1
	current.frame = _.__min(current.frame, #current.frames)
end

-- Reached end of animation?
--
function Animator:isEndOfAnimation(current)
	return current.frame == (current.reverse and 1 or #current.frames)
end

-- Reached end of animation sequence?
--
function Animator:isEndOfSequence(current)
	return current.total == nil or
	       current.count < current.total
end

-- Toggle next frame (if applicable)
--
function Animator:sequence()
	self:roll(self.current)
	
	-- end of animation?
	if self:isEndOfAnimation(self.current) then
		self.current.count = self.current.count + 1

		-- end of sequence?
		if self:isEndOfSequence(self.current) then
			self:replay(self.current)
		else
			self:pause(self.current)
		end

		-- after callback
		self.current:after()
	end
end

-- Update animation
--
function Animator:update(dt)
	if self.current and self.current.playing then
		self.current.timer = self.current.timer - dt

		if self.current.timer <= 0 then
			self.current.timer = 1 / self.current.fps
			self:sequence()
		end
	end
end

-- Draw animation
--
function Animator:draw(...)
	if self.current then
		if self.current.frames then
			lg.draw(self.current.image, self.current.frames[self.current.frame], ...)
		else
			lg.draw(image, ...)
		end
	end
end

return Animator