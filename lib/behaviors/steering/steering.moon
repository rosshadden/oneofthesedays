Caste = require('vendor/caste/lib/caste')
Vector = require('lib/geo/vector')

class Steering extends Caste

	new: (@entity) =>

	update: (dt) =>
		velocity = @run(dt)
		@entity\set('velocity', velocity)

	run: () => Vector.ZERO
