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
				sheet = {
        			main   = lg.newImage('res/images/entities/hero_sword.png'),
        			attack = lg.newImage('res/images/entities/hero_sword_attack.png'),
        		},
				animation = {
					dash   = { sheet = 'main', width = 50,  height = 48, frames = {{1,1,1,3}}},
					walk   = { sheet = 'main', width = 50,  height = 48, frames = {{5,8,5,10},{6,1,6,3}}},
					die    = { sheet = 'main', width = 50,  height = 48, frames = {{1,4,5,7}}, total = 1 },
					fall   = { sheet = 'main', width = 50,  height = 48, frames = {{3,7,3,7} }, total = 1 },
					hit    = { sheet = 'main', width = 50,  height = 48, frames = {{2,3,2,6}}, total = 1 },
					idle   = { sheet = 'main', width = 50,  height = 48, frames = {{2,6,2,7}}, fps = 3 },
					jump   = { sheet = 'main', width = 50,  height = 48, frames = {{3,4,3,9}}, total = 1 },
					crouch = { sheet = 'main', width = 50,  height = 48, frames = {{3,9,3,9}}, oy = 8, total = 1 },
					roll   = { sheet = 'main', width = 50,  height = 48, frames = {{4,2,4,7}}, oy = 8, total = 1 },
					-- attacks
					attack = { sheet = 'attack', width = 100, height = 65, frames = {{1,1,1,5},{2,1,2,2}}, ox=-12, oy=10, total=1 },
					thrust = { sheet = 'attack', width = 100, height = 65, frames = {{2,2,2,5},{3,1,3,3}}, ox=-12, oy=10, total=1 },
				}
        	},
        	skeleton = {
        		sheet = {
        			main   = lg.newImage('res/images/entities/skeleton.png'),
        			attack = lg.newImage('res/images/entities/skeleton_attacks.png'),
        		},
        		animation = {
					idle   = { sheet = 'main', width = 50,  height = 48, frames = { { 3, 3, 3, 6 } }, fps = 3 },
					jump   = { sheet = 'main', width = 50,  height = 48, frames = { { 2, 8, 5, 11 }, { 3, 1, 3, 3 } }, total = 1 },
					crouch = { sheet = 'main', width = 50,  height = 48, frames = { { 3, 2, 3, 2 } }, oy = 8, total = 1 },
					walk   = { sheet = 'main', width = 50,  height = 48, frames = { { 4, 5, 4, 11 } } },
					run    = { sheet = 'main', width = 50,  height = 48, frames = { { 3, 9, 3, 11 }, { 4, 1, 4, 5 } } },
					-- attacks
					attack = { sheet = 'attack', width = 100, height = 65, frames = { { 6, 1, 6, 6 } }, fps = 12, ox = -8, oy = 48, total = 1 },
					thrust = { sheet = 'attack', width = 100, height = 65, frames = { { 6, 1, 6, 6 } }, fps = 12, ox = -8, oy = 48, total = 1 },
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