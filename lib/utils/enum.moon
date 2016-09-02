Class = require('lib/class')

class Enum extends Class

	@add: (values) =>
		assert _.isTable(values)

		for key, value in pairs(values)
			if _.isNumber(key) then key = value
			enum = @(value, key)
			@[key] = enum
			@[value] = enum
			_.push(@keys, key)
			_.push(@values, value)

	keys: {}
	values: {}

	new: (@value, @key) =>
