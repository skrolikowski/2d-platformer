local mapping = {
	ESC = {'key_escape','btn_back'},
	L   = {'key_a','key_left','btn_dpleft'},
	R   = {'key_d','key_right','btn_dpright'},
	D   = {'key_s','key_down','btn_dpdown'},
	U   = {'key_w','key_up','btn_dpup'},
	R2  = {'btn_r2'},
	AL  = {'btn_al'},
	J   = {'key_space','btn_a'},
	A   = {'key_f','btn_b','btn_x'},
	B   = {'key_g','btn_l1','btn_r1'},

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