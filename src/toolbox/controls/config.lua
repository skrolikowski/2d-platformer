local mapping = {
	ESC = {'key_escape','btn_back'},
	--
	L   = {'key_a','key_left','btn_dpleft'},
	R   = {'key_d','key_right','btn_dpright'},
	D   = {'key_s','key_down','btn_dpdown'},
	U   = {'key_w','key_up','btn_dpup'},
	--
	AL  = {'btn_al'},
	--
	R2  = {'btn_r2','key_l'},
	R1  = {'btn_r1','key_r'},
	L2  = {'btn_l2'},
	L1  = {'btn_l1'},
	--
	B   = {'key_space','btn_a'},  -- jump button
	A   = {'key_f','btn_b'},      -- A button
	

	--
	-- leftshoulder
	-- rightshoulder
}
local codes = {}

for name, map in pairs(mapping) do
	for __, code in pairs (map) do
		codes[code] = name
	end 
end

return codes