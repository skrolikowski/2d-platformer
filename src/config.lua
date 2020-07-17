-- Configurations
--

Config = {
	width  = lg.getWidth(),
	height = lg.getHeight(),
	debug  = true,
	camera = { scale = 3  },
	world  = {
		tileSize = 16,
		cellSize = 32,
        entity   = {
        	player = {
        		-- sheet = lg.newImage('res/images/entities/sheet_hero_archer_1.png'),
        		-- sheet = lg.newImage('res/images/entities/sheet_hero_mage_1.png'),
        		sheet = lg.newImage('res/images/entities/sheet_hero_sword_1.png'),
				animation = {
					idle   = { width = 50,  height = 48, frames = { { 1, 3, 1, 5 } }, fps = 3 },
					jump   = { width = 50,  height = 48, frames = { { 5, 1, 5, 4 } }, total = 1 },
					fall   = { width = 50,  height = 48, frames = { { 5, 4, 5, 4 } }, total = 1 },
					crouch = { width = 50,  height = 48, frames = { { 5, 5, 5, 5 } }, oy = 8, total = 1 },
					walk   = { width = 50,  height = 48, frames = { { 3, 1, 3, 7 } } },
					run    = { width = 50,  height = 48, frames = { { 4, 1, 4, 7 } } },
					roll   = { width = 50,  height = 48, frames = { { 7, 1, 7, 7 } }, oy = 8, total = 1 },
					attack = { width = 100, height = 56, frames = { { 9, 1, 9, 7 } }, fps = 24, ox = -8, oy = 32, total = 1 },
				}
        	}
        }
	},
	color  = {
	    debug     = { _:color('red-800') },
		white     = { _:color('white') },
		black     = { _:color('black') },
		slopes    = { _:color('blue-400') },
		bounds    = { _:color('red-400') },
	    overlay   = { 0, 0, 0, 0.65 },
		highlight = { _:color('green-500') },
		radar     = { _:color('yellow-300') },
		stats = {
			hp = { _:color('red-300') },
			sp = { _:color('green-300') },
			xp = { _:color('blue-300') },
		}
	},
	ui = {
        font = {
            xs = love.graphics.newFont('res/ui/fonts/Fool.ttf', 10),
            sm = love.graphics.newFont('res/ui/fonts/Fool.ttf', 12),
            md = love.graphics.newFont('res/ui/fonts/Fool.ttf', 24),
            lg = love.graphics.newFont('res/ui/fonts/Fool.ttf', 32),
            xl = love.graphics.newFont('res/ui/fonts/Fool.ttf', 48)
        }
	},

}