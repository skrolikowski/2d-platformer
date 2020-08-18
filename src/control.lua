--
--
_Control = {
	scene = {
		--
		-- Escape
		esc = function() Gamestate.current():onQuit() end,
		
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

		-- Jump Button
		J = {
			on  = function() Gamestate.current():on('jump') end,
			off = function() Gamestate.current():off('jump') end,
		},

		-- Attack Button
		['A'] = function() Gamestate.current():on('attack', 'slash')  end,
		['B'] = {
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
