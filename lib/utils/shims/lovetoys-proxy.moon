Middleclass = require('lib/utils/shims/middleclass')

(ProxyClass) ->
	ToysProxy = class extends Middleclass
		new: (...) =>
			super()
			@proxy = ProxyClass(...)

	for key, value in pairs ProxyClass.__instanceDict
		if type(value) == 'function'
			ToysProxy.__base[key] = (...) =>
				@proxy[key](@proxy, ...)

	return ToysProxy