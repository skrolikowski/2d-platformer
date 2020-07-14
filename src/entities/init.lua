--
--

Components = {
	transform = require 'src.entities.components.transform',
	contact   = require 'src.entities.components.contact',
	-- graphics
	animation = require 'src.entities.components.graphics.animation',
	-- movement
	move    = require 'src.entities.components.movements.move',
	crouch  = require 'src.entities.components.movements.crouch',
	jump    = require 'src.entities.components.movements.jump',
	gravity = require 'src.entities.components.movements.gravity',
	roll    = require 'src.entities.components.movements.roll',
	-- behaviors
	state = require 'src.entities.components.behaviors.state',
}

Entities = {
	player = require 'src.entities.active.player',

	-- passive
	bounds = require 'src.entities.passive.bounds',
	slopes = require 'src.entities.passive.slopes'
}
