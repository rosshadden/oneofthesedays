class Class
	@name: 'Class'
	@type: 'class'
	@parents: { @ }
	@isClass: true

	@__inherited: (child) =>
		child.name = child.__name
		child.type = _.lowerFirst(child.name)
		child.parents = _.union(@@parents, { @@ })

	new: () =>
		@class = @@
		@type = _.lowerFirst(@@name)
		@isInstance = true

	is: (type) =>
		if type == @ then return true
		if type == @@ then return true
		if type == @type then return true
		if type == @@name then return true

		if _.isString(type)
			return _.some(@@parents, (Parent) -> type == Parent.type or type == Parent.name)
		if _.isInstance(type)
			return _.some(@@parents, (Parent) -> type.class == Parent)
		if _.isClass(type)
			return _.some(@@parents, (Parent) -> type == Parent)

		return false
