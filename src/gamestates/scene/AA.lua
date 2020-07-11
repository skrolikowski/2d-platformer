-- AA Gameplay Scene
--

local Base = require 'src.gamestates.scene.scene'
local AA   = Base:extend()

function AA:init()
	Base.init(self, {
        id   = 'AA',
        name = 'AA',
        map  = 'res/maps/AA.lua'
    })
    --
    
end

function AA:enter(from, ...)
	Base.enter(self, from, ...)
    --

end

return AA