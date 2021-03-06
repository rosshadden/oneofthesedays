Command = require('lib/commands/command')
{ :Direction } = require('vendor/hug/lib/geo')

class UseCommand extends Command

	new: (@entity, @map) =>

	exec: () =>
		{ :heading } = @entity\get()
		direction = Direction[heading]
		point = @entity\getPoint(direction)\add(direction)
		items = @map\queryPoint(point)
		for item in *items
			if _.isFunction(item.onUse)
				item\onUse(@entity)
