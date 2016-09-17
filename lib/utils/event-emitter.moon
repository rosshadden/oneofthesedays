Class = require('lib/class')

class EventEmitter extends Class

	new: () =>
		@listeners = {}

	on: (event, listener, this) =>
		if not @listeners[event] then @listeners[event] = {}
		table.insert(@listeners[event], { listener, this })

	once: (event, listener, this) => @many(event, 1, listener, this)
	many: (event, ttl, listener, this) =>
		wrapper = (...) =>
			ttl -= 1
			if ttl == 0 then @off(event, wrapper)
			listener(...)
		@on(event, wrapper, this)

	emit: (event, ...) =>
		for { listener, this } in *@listeners[event]
			if this then listener(this, ...) else listener(...)

	off: (event, listener) =>
	removeListener: (...) => @off(...)
	removeAllListeners: (event) =>

	eventNames: () =>
		names = {}
		for name, listener in pairs(@listeners)
			table.insert(names, name)
		return names