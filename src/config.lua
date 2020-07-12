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
        entities = {
        	player = {

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