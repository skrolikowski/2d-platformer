--
--

--
-- Components
Components = {
	animation = require 'src.entities.components.animation',
	attack    = require 'src.entities.components.attack',
	axis      = require 'src.entities.components.axis',
	crouch    = require 'src.entities.components.crouch',
	death     = require 'src.entities.components.death',
	damage    = require 'src.entities.components.damage',
	health    = require 'src.entities.components.health',
	jump      = require 'src.entities.components.jump',
	proximity = require 'src.entities.components.proximity',
	target    = require 'src.entities.components.target',
	transform = require 'src.entities.components.transform',
	revive    = require 'src.entities.components.revive',
	roll      = require 'src.entities.components.roll',
	velocity  = require 'src.entities.components.velocity',
}

--
-- Behaviors
BM = require 'src.entities.behaviors.manager'
Behaviors = {
	patrol  = require 'src.entities.behaviors.patrol',
	-- actions
	attack = require 'src.entities.behaviors.actions.attack',
	death  = require 'src.entities.behaviors.actions.death',
}

SM = require 'src.entities.systems.manager'
Systems = {
	animation = require 'src.entities.systems.animation',
	debug     = require 'src.entities.systems.debug',
	-- decay     = require 'src.entities.systems.decay',
	detection = require 'src.entities.systems.detection',
	-- environment
	gravity   = require 'src.entities.systems.environment.gravity',
	proximity = require 'src.entities.systems.environment.proximity',
	-- actions
	attack = require 'src.entities.systems.actions.attack',
	crouch = require 'src.entities.systems.actions.crouch',
	death  = require 'src.entities.systems.actions.death',
	hit    = require 'src.entities.systems.actions.hit',
	jump   = require 'src.entities.systems.actions.jump',
	revive = require 'src.entities.systems.actions.revive',
	roll   = require 'src.entities.systems.actions.roll',
	-- movements
	move     = require 'src.entities.systems.movements.move',
	teleport = require 'src.entities.systems.movements.teleport',
	-- stats
	health = require 'src.entities.systems.stats.health',
}


Entity = {
	-- units
	player   = 'src.entities.entities.units.player',
	skeleton = 'src.entities.entities.units.skeleton',
	-- environment
	bounds = 'src.entities.entities.bounds',
	-- attacks
	slash = 'src.entities.entities.attacks.slash'
}