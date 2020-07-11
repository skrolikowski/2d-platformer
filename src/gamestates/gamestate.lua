-- Base Screen
--

local Modern    = require 'vendor.modern'
local Gamestate = Modern:extend()

function Gamestate:init(data)
	self.id    = data.id   or Util:uuid()
	self.name  = data.name or 'scene'
	self.timer = Timer.new()

	-- controls
	self.control  = nil
	self.controls = {}
end

-- Event: onEnter
--
function Gamestate:enter(from, ...)
	self.from     = from -- previous screen
	self.settings = ...
	--

end

-- Event: onResume
--
function Gamestate:resume()

end

-- Event: onLeave
--
function Gamestate:leave()
	--
end

---- ---- ---- ----

-- Event: onMousePress
--
function Gamestate:onPress()
	--
end

-- Event: onMouseMove
--
function Gamestate:onMove()
	--
end

-- Event: onMouseRelease
--
function Gamestate:onRelease()
	--
end

-- Event: onControl (callbacks)
--
function Gamestate:onControl(name, ...)
	self.controls[name](...)
end

-- Event: quit game
--
function Gamestate:onQuit()
	love.event.quit()
end

---- ---- ---- ----

-- Register control callbacks
--
function Gamestate:registerControls(...)
	for name, callback in pairs(...) do
		self.controls[name] = callback
	end
end

-- Set controls
--
function Gamestate:setControl(name)
	if self.control ~= name then
		-- unregister
		if self.control ~= nil then 
			for code, __ in pairs(Control[self.control]) do
				_:off(code)
			end
		end

		-- set
		self.control = name

		-- register
		for code, func in pairs(Control[self.control]) do
			_:on(code, func)
		end
	end
end

---- ---- ---- ----

-- Update
--
function Gamestate:update(dt)
	self.timer:update()
end

-- Draw
--
function Gamestate:draw()
	--
end

return Gamestate