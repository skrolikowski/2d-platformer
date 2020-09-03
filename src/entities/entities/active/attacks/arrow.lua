-- Arrow Attack
--

local Base  = require 'src.entities.entities.active.attacks.base'
local Arrow = Base:extend()

function Arrow:new(data)
	--
	-- properties
	self.color  = { _:color('white') }
	self.angle  = data.source:heading()
	self.sprite = lg.newImage('res/sheets/projectiles/arrow.png')

	--
	local cx, cy    = data.source:center()
	local ax, ay    = data.source:axis():unpack()
	local w, h      = data.source:dimensions()
	local magnitude = w * 2 * data.source:facing()
	
	cx = cx + _.__cos(self.angle) * magnitude
	cy = cy-(h * 0.2) + _.__sin(self.angle) * magnitude

	--
	Base.new(self, _:merge({
		name = 'arrow',
		--
		mixins = {
			transform = {
				x = cx,
				y = cy,
				w = Config.world.tileSize,
				h = Config.world.tileSize,
			},
			ghost = {},
			axis     = { axis = Vec2(ax, ay) },
			velocity = { spd = 300 },
			damage   = { dmg = data.dmg or 10 }
		},
		--
		systems = {
			-- 'gravity',
			'move',
			'proximity',
			expire = { delay = data.expire or 1 }
		}
	}, data))
end

--
--
function Arrow:destroy()
	Base.destroy(self)
end

-- --
-- --
-- function Arrow:onContact(con, other)
-- 	if other.name == 'bounds' then
-- 		self:destory()
-- 	end
-- end

-- Update (req'd to run systems)
--
function Arrow:update(dt)
	Base.update(self, dt)
end

-- Draw
--
function Arrow:draw()
	local cx, cy  = self:center()
	local w, h    = self:dimensions()
	local sx, sy  = self._sx, self._sy

	lg.push()
	lg.translate(cx, cy)
	lg.rotate(self.angle)
	lg.scale(0.9,0.9)

	lg.setColor(self.color)
	lg.draw(self.sprite, -w/2, -h/2)

	lg.pop()
	--
	Base.draw(self)
end

return Arrow