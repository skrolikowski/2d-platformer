--
--
_Control = {
	scene = {
		--
		-- Escape
		ESC = function() Gamestate.current():onQuit() end,
		
		-- Direction - Analog
		AL = function(...) Gamestate.current():on('axis', ...) end,

		-- Direction - Up
		U   = {
			on  = function() Gamestate.current():on('axis', { y = -1 }) end,
			off = function() Gamestate.current():on('axis', { y =  0 }) end,
		},

		-- Direction - Down
		D   = {
			on  = {
				function() Gamestate.current():on('axis', { y =  1 }) end,
				function() Gamestate.current():on('crouch') end,
			},
			off = {
				function() Gamestate.current():on('axis', { y =  0 }) end,
				function() Gamestate.current():off('crouch') end,
			}
		},

		-- Direction - Left
		L   = {
			on  = function() Gamestate.current():on('axis', { x = -1 }) end,
			off = {
				function() Gamestate.current():on('axis', { x =  0 }) end,
				function() Gamestate.current():off('dash') end,
			},
		},
		
		-- Direction - Right
		R   = {
			on  = function() Gamestate.current():on('axis', { x =  1 }) end,
			off = {
				function() Gamestate.current():on('axis', { x =  0 }) end,
				function() Gamestate.current():off('dash') end,
			},
		},

		-- (A) Attack Button
		A = function() Gamestate.current():on('attack', 'slash') end,

		-- (B) Jump Button
		B = {
			on  = function() Gamestate.current():on('jump') end,
			off = function() Gamestate.current():off('jump') end,
		},

		-- Reload Button
		R1 = function() Gamestate.current():on('reload') end,
		
		-- Aim Button
		R2 = {
			on  = function() Gamestate.current():on('aim')  end,
			off = function() Gamestate.current():off('aim') end,
		},
		-- Combo - Aim/Fire
		['R2+A'] = function() Gamestate.current():on('attack', 'arrow') end,

		-- Guard Button
		['L1'] = {
			on  = function() Gamestate.current():on('guard') end,
			off = function() Gamestate.current():off('guard') end,
		},
	
		-- Combo - Roll
		['D+J'] = function() Gamestate.current():on('roll') end,
		
		-- Combo - Dash
		['R,R'] = function() Gamestate.current():on('dash') end,
		['L,L'] = function() Gamestate.current():on('dash') end,
	}
}
