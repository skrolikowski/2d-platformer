-- Configurations
--

Config = {
	width  = lg.getWidth(),
	height = lg.getHeight(),
	debug  = true,
	camera = { scale = 2.5  },
	world  = {
		tileSize = 16,
		cellSize = 32,
        entity   = {
        	hero = {
				sheet = {
					-- general
        			sword  = lg.newImage('res/images/entities/hero/sword.png'),
        			archer = lg.newImage('res/images/entities/hero/archer.png'),
        			mage   = lg.newImage('res/images/entities/hero/mage.png'),
        			-- attacks
        			atk_sword  = lg.newImage('res/images/entities/hero/sword_attacks.png'),
        			atk_archer = lg.newImage('res/images/entities/hero/archer_attacks.png'),
        			atk_mage   = lg.newImage('res/images/entities/hero/mage_attacks.png'),
        		},
				animation = {
					dash   = { sheet = 'sword', width = 50,  height = 48, frames = {{4,8,4,10},{5,1,5,3}}},
					walk   = { sheet = 'sword', width = 50,  height = 48, frames = {{5,8,5,10},{6,1,6,3}}},
					die    = { sheet = 'sword', width = 50,  height = 48, frames = {{1,4,1,7}}, fps = 5, total = 1 },
					guard  = { sheet = 'sword', width = 50,  height = 48, frames = {{4,8,4,8}}, total = 1 },
					revive = { sheet = 'sword', width = 50,  height = 48, frames = {{1,4,1,7}}, reverse=true, fps = 5, total = 1 },
					fall   = { sheet = 'sword', width = 50,  height = 48, frames = {{3,7,3,7}}, total = 1 },
					hit    = { sheet = 'sword', width = 50,  height = 48, frames = {{2,3,2,6}}, fps = 5, total = 1 },
					idle   = { sheet = 'sword', width = 50,  height = 48, frames = {{2,6,2,7}}, fps = 5 },
					jump   = { sheet = 'sword', width = 50,  height = 48, frames = {{3,4,3,9}}, total = 1 },
					djump  = { sheet = 'sword', width = 50,  height = 48, frames = {{4,4,4,7}}, total = 1 },
					crouch = { sheet = 'sword', width = 50,  height = 48, frames = {{4,7,4,7}}, oy = 8, total = 1 },
					roll   = { sheet = 'sword', width = 50,  height = 48, frames = {{4,2,4,7}}, oy = 8, total = 1 },
					-- attacks
					aim    = { sheet = 'atk_archer', width = 100, height = 65, frames = {{1,1,1,1}}, ox=-12, oy=10, total=1 },
					slash  = { sheet = 'atk_sword',  width = 100, height = 65, frames = {{1,1,1,5},{2,1,2,2}}, fps=12, ox=-12, oy=10, total=1 },
					thrust = { sheet = 'atk_sword',  width = 100, height = 65, frames = {{2,2,2,5},{3,1,3,3}}, fps=12, ox=-12, oy=10, total=1 },
				}
        	},
        	skeleton = {
        		sheet = {
        			main   = lg.newImage('res/images/entities/skeleton.png'),
        			attack = lg.newImage('res/images/entities/skeleton_attacks.png'),
        		},
        		animation = {
					idle   = { sheet = 'main', width = 50,  height = 48, frames = {{3,3,3,6}}, fps = 3 },
					die    = { sheet = 'main', width = 50,  height = 48, frames = {{1,3,1,8}}, total = 1 },
					revive = { sheet = 'main', width = 50,  height = 48, frames = {{1,3,1,8}}, reverse = true, total = 1 },
					corpse = { sheet = 'main', width = 50,  height = 48, frames = {{1,1,1,1}}, total = 1 },
					jump   = { sheet = 'main', width = 50,  height = 48, frames = {{2,8,2,10}}, total = 1 },
					fall   = { sheet = 'main', width = 50,  height = 48, frames = {{2,10,2,10}}, total = 1 },
					hit    = { sheet = 'main', width = 50,  height = 48, frames = {{2,5,2,7}}, total = 1 },
					stun   = { sheet = 'main', width = 50,  height = 48, frames = {{2,5,2,7}} },
					walk   = { sheet = 'main', width = 50,  height = 48, frames = {{4,5,4,11}} },
					-- attacks
					attack = { sheet = 'attack', width = 100, height = 65, frames = {{2,2,2,5},{3,1,3,2}}, fps=12, ox=-12, oy=10, total=1 },
					thrust = { sheet = 'attack', width = 100, height = 65, frames = {{1,1,1,5},{2,1,2,2}}, fps=12, ox=-12, oy=10, total=1 },
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