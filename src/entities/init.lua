--
--

--
-- Components
Components = {
	-- general
	animation = require 'src.entities.components.animation',
	axis      = require 'src.entities.components.axis',
	proximity = require 'src.entities.components.proximity',
	target    = require 'src.entities.components.target',
	transform = require 'src.entities.components.transform',
	velocity  = require 'src.entities.components.velocity',
	-- actions
	attack = require 'src.entities.components.actions.attack',
	crouch = require 'src.entities.components.actions.crouch',
	damage = require 'src.entities.components.actions.damage',
	dash   = require 'src.entities.components.actions.dash',
	death  = require 'src.entities.components.actions.death',
	hit    = require 'src.entities.components.actions.hit',
	jump   = require 'src.entities.components.actions.jump',
	revive = require 'src.entities.components.actions.revive',
	roll   = require 'src.entities.components.actions.roll',
	-- stats
	health = require 'src.entities.components.stats.health',
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
	dash   = require 'src.entities.systems.actions.dash',
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
	hero     = 'src.entities.entities.units.hero',
	skeleton = 'src.entities.entities.units.skeleton',
	-- environment
	bounds = 'src.entities.entities.bounds',
	-- attacks
	slash  = 'src.entities.entities.attacks.slash',
	thrust = 'src.entities.entities.attacks.thrust'
}