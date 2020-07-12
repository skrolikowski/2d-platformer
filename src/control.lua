--
--
Control = {
	scene = {
		-- keyboard
		--
		keyOn_escape = function()
			Gamestate.current():onQuit()
		end,
		keyDown_w = function()
			Gamestate.current():onControl('axis', { y = -1 })
		end,
		keyDown_s = function()
			Gamestate.current():onControl('axis', { y =  1 })
			Gamestate.current():onControl('onCrouch')
		end,
		keyDown_a    = function()
			Gamestate.current():onControl('axis', { x = -1 })
		end,
		keyDown_d    = function()
			Gamestate.current():onControl('axis', { x =  1 })
		end,
		keyOff_w = function()
			Gamestate.current():onControl('axis', { y =  0 })
		end,
		keyOff_s = function()
			Gamestate.current():onControl('axis', { y =  0 })
			Gamestate.current():onControl('offCrouch')
		end,
		keyOff_a = function()
			Gamestate.current():onControl('axis', { x =  0 })
		end,
		keyOff_d = function()
			Gamestate.current():onControl('axis', { x =  0 })
		end,
		keyOn_space  = function() Gamestate.current():onControl('onJump')  end,
		keyOff_space = function() Gamestate.current():onControl('offJump') end,

		-- gamepad
		--

	}
}
