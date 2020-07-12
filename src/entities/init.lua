--
--

Components = {
	transform = require 'src.entities.components.transform',
	contact   = require 'src.entities.components.contact',
	-- movement
	axis    = require 'src.entities.components.movements.axis',
	crouch  = require 'src.entities.components.movements.crouch',
	jump    = require 'src.entities.components.movements.jump',
	gravity = require 'src.entities.components.movements.gravity',
	-- behaviors
	state = require 'src.entities.components.behaviors.state',
}

Entities = {
	enemy  = require 'src.entities.enemy',
	player = require 'src.entities.player',

	-- passive
	bounds = require 'src.entities.passive.bounds',
	slopes = require 'src.entities.passive.slopes'
}
