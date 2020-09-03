Sheet = {
	hero = {
		aim_arm = AnimSheet('res/sheets/units/hero/aim_arms.png'):split(100, 65),
		aim     = AnimSheet('res/sheets/units/hero/aim_body.png'):split(100, 65),
		base    = AnimSheet('res/sheets/units/hero/base.png'):split(50, 48),
		attack  = AnimSheet('res/sheets/units/hero/attack.png'):split(100, 65),
	},
	-- skeleton = {
	-- 	base   = AnimSheet('res/sheets/units/skeleton/base.png'):split(50, 48),
	-- 	attack = AnimSheet('res/sheets/units/skeleton/attack.png'):split(100, 65),
	-- }
}

Sprite = {
	hero = Animator({
		crouch = Animation(Sheet['hero']['base']):frames({4,7,4,7}):once():offset(0,8),
		dash   = Animation(Sheet['hero']['base']):frames({4,8,4,10},{5,1,5,3}),
		die    = Animation(Sheet['hero']['base']):frames({1,4,1,7}):at(5):once(),
		fall   = Animation(Sheet['hero']['base']):frames({3,7,3,7}):once(),
		guard  = Animation(Sheet['hero']['base']):frames({4,8,4,8}):once(),
		hit    = Animation(Sheet['hero']['base']):frames({2,3,2,6}):at(5):once(),
		idle   = Animation(Sheet['hero']['base']):frames({2,6,2,8}):at(3),
		jump   = Animation(Sheet['hero']['base']):frames({3,4,3,9}):once(),
		djump  = Animation(Sheet['hero']['base']):frames({4,4,4,7}):once(),
		roll   = Animation(Sheet['hero']['base']):frames({4,2,4,7}):once():offset(0,8),
		revive = Animation(Sheet['hero']['base']):frames({1,4,1,7}):at(5):reverse():once(),
		walk   = Animation(Sheet['hero']['base']):frames({5,8,5,10},{6,1,6,3}),
		-- attacks
		aim    = Animation(Sheet['hero']['aim']):frames({1,1,1,1}):offset(-12,10),
		reload = Animation(Sheet['hero']['aim']):frames({1,1,3,2}):offset(-12,10),
		slash  = Animation(Sheet['hero']['attack']):frames({1,1,1,5},{2,1,2,2}):at(12):offset(-12,10):once(),
		thrust = Animation(Sheet['hero']['attack']):frames({2,2,2,5},{3,1,3,3}):at(12):offset(-12,10):once(),
	}),

	-- skeleton = Animator({
	-- 	idle   = Animation(Sheet['skeleton']['base']):frames({3,3,3,6}):at(3),
	-- 	die    = Animation(Sheet['skeleton']['base']):frames({1,3,1,8}):once(),
	-- 	revive = Animation(Sheet['skeleton']['base']):frames({1,3,1,8}):reverse():once(),
	-- 	corpse = Animation(Sheet['skeleton']['base']):frames({1,1,1,1}):once(),
	-- 	jump   = Animation(Sheet['skeleton']['base']):frames({2,8,2,10}):once(),
	-- 	fall   = Animation(Sheet['skeleton']['base']):frames({2,10,2,10}):once(),
	-- 	hit    = Animation(Sheet['skeleton']['base']):frames({2,5,2,7}):once(),
	-- 	stun   = Animation(Sheet['skeleton']['base']):frames({2,5,2,7}),
	-- 	walk   = Animation(Sheet['skeleton']['base']):frames({4,5,4,11}),
	-- 	-- attacks
	-- 	attack = Animation(Sheet['skeleton']['attack']):frames({2,2,2,5},{3,1,3,2}):at(12):offset(-12,10):once(),
	-- 	thrust = Animation(Sheet['skeleton']['attack']):frames({1,1,1,5},{2,1,2,2}):at(12):offset(-12,10):once(),
	-- })
}