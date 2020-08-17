-- Animation System
--

local Base      = require 'src.entities.systems.base'
local Animation = Base:extend()

-- New..
--
function Animation:new(host, data)
	Base.new(self, host, { 'axis', 'animation' })
	--
	
	-- properties
	self.color = data.color or { Config.color.white }

	-- flags
	self.isMirrored = false
	self.isFlipped  = false
end

-- Update
--
function Animation:update(dt)
	self.host.sprite:update(dt)
	--
	
	if self.host:ax() ~= 0 then
		self.isMirrored = self.host:ax() < 0
	end

	--
	local prevName = self.host.sprite.current.name
	local newName  = self.host:state()

	if prevName ~= newName then
		self.host.sprite:switchTo(newName)
	end
end

-- Draw
--
function Animation:draw()
	local w, h    = self.host.sprite:dimensions()
	local ox, oy  = self.host.sprite:offsets()
    local sx, sy  = 1, 1
    local r, g, b = unpack(self.color)

    if self.isMirrored then sx = -sx end
    if self.isFlipped  then sy = -sy end

    -- offset
    ox = ox + w / 2
    oy = oy + h / 2

    -- draw
    lg.setColor(r, g, b, 1)

    self.host.sprite:draw(0, 0, 0, sx, sy, ox, oy)
end

return Animation