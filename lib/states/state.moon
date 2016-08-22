states = require('vendor/hump/gamestate')
Engine = require('lib/engine')
EventManager = require('lib/event-manager')
DebugSystem = require('lib/systems/debug')

class State
	new: () =>
		@engine = Engine()
		@events = EventManager()
		@states = states

		debugSystem = DebugSystem(@)
		@engine\addSystem(debugSystem, 'update')
		@engine\addSystem(debugSystem, 'draw')
		@engine\stopSystem(DebugSystem.name)

	enter: (@previous) =>

	update: (dt) =>
		@engine\update(dt)

	draw: () =>
		@engine\draw()

	keypressed: (key) =>
		if key == 'q' then love.event.quit()
		if key == '`'
			@engine\toggleSystem(DebugSystem.name)
			@DEBUG = not @DEBUG

	switch: (state, ...) =>
		@states.switch(state, ...)

	push: (state, ...) =>
		@states.push(state, ...)

	pop: (...) =>
		@states.pop(...)
