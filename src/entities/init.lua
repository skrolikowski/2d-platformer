--
--

Components = {
	contact   = require 'src.entities.components.contact',
	jump      = require 'src.entities.components.jump',
	gravity   = require 'src.entities.components.gravity',
	movement  = require 'src.entities.components.movement',
	transform = require 'src.entities.components.transform',
}

Entities = {
	player = require 'src.entities.player',

	-- passive
	bounds = require 'src.entities.passive.bounds',
	slopes = require 'src.entities.passive.slopes'
}
