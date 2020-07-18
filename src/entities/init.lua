--
--

Components = {
	-- passive
	contact = require 'src.entities.components.passive.contact',
	gravity = require 'src.entities.components.passive.gravity',
	-- graphics
	animation = require 'src.entities.components.graphics.animation',
	-- actions
	attack  = require 'src.entities.components.actions.attack',
	move    = require 'src.entities.components.actions.move',
	crouch  = require 'src.entities.components.actions.crouch',
	jump    = require 'src.entities.components.actions.jump',
	roll    = require 'src.entities.components.actions.roll',
	-- behaviors
	state     = require 'src.entities.components.behaviors.state',
	detection = require 'src.entities.components.behaviors.detection',
}

--
-- Behaviors
BM = require 'src.entities.behaviors.manager'
Behaviors = {
	attack  = require 'src.entities.behaviors.attack',
	patrol = require 'src.entities.behaviors.patrol',
}

Entities = {
	-- kinematic
	kinematic = require 'src.entities.kinematic.kinematic',

	-- static
	bounds = require 'src.entities.static.bounds',
	slopes = require 'src.entities.static.slopes'
}
