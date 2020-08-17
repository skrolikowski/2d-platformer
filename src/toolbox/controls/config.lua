local mapping = {
	esc = {'escape'},
	L   = {'a','left'},
	R   = {'d','right'},
	D   = {'s','down'},
	U   = {'w','up'},
	J   = {'space'},
	A   = {'f'},
	B   = {'g'},
}
local codes = {}

for name, map in pairs(mapping) do
	for __, code in pairs (map) do
		codes[code] = name
	end 
end

return codes