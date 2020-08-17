--
--
Control = {
	scene = {
		--
		-- Escape
		esc = function() self:onRqQuit() end,
		
		-- Direction - Up
		U   = {
			on  = function() self._p:dispatch('onRqAxis', { y = -1 }) end,
			off = function() self._p:dispatch('onRqAxis', { y =  0 }) end,
		},

		-- Direction - Down
		D   = {
			on  = {
				function() self._p:dispatch('onRqAxis', { y =  1 }) end,
				function() self._p:dispatch('onRqCrouch') end,
			},
			off = {
				function() self._p:dispatch('oRqAxis', { y =  0 }) end,
				function() self._p:dispatch('offRqCrouch') end,
			}
		},

		-- Direction - Left
		L   = {
			on  = function() self._p:dispatch('onRqAxis', { x = -1 }) end,
			off = function() self._p:dispatch('onRqAxis', { x =  0 }) end,
		},
		
		-- Direction - Right
		R   = {
			on  = function() self._p:dispatch('onRqAxis', { x =  1 }) end,
			off = function() self._p:dispatch('onRqAxis', { x =  0 }) end,
		},

		-- Jump Button
		J = {
			on  = function() self._p:dispatch('onRqJump') end,
			off = function() self._p:dispatch('offRqJump') end,
		},

		-- Attack Button
		A = function() self._p:dispatch('onRqAttack') end,
		
		-- Combo - Roll
		['D+J'] = function() self._p:dispatch('onRoll') end,
	}
}
