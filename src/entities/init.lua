--
--
SM = require 'src.entities.systems.manager'
BM = require 'src.entities.behaviors.manager'

Components = Util:buildDir('src/entities/components')
Behaviors  = Util:buildDir('src/entities/behaviors')
Systems    = Util:buildDir('src/entities/systems')

--
Entities   = {
	--
	-- Active
	--- attacks
	slash    = 'src.entities.entities.active.attacks.slash',
	thrust   = 'src.entities.entities.active.attacks.thrust',
	--- units
	hero     = 'src.entities.entities.active.units.hero',
	skeleton = 'src.entities.entities.active.units.skeleton',

	-- Passive
	--- environment
	bounds = 'src.entities.entities.passive.bounds',
}