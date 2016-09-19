System = require('vendor/secs/lib/system')
Color = require('lib/display/color')

class RenderSystem extends System

	@criteria: System.Criteria({ 'shape', 'position' }, { 'animation', 'animationList', 'sprite' })

	update: (dt) =>
		-- for entity in *@entities.animated
		for entity in *@entities
			{ :animation, :animationList, :direction } = entity\get()
			directionKey = if direction then direction.key else 'NONE'
			if animationList[directionKey] then animationList\set(directionKey)
			animation.value\update(dt)

	draw: () =>
		-- drawn = {}

		-- for entity in *@entities.animated
		for entity in *@entities
			-- if drawn[entity] then continue
			-- drawn[entity] = true
			@drawSprite(entity)

		-- for entity in *targets.sprites
		-- 	if drawn[entity] then continue
		-- 	drawn[entity] = true
		-- 	@drawSprite(entity)

		-- for entity in *targets.polygons
		-- 	if drawn[entity] then continue
		-- 	drawn[entity] = true
		-- 	{ :shape, :position, :color } = entity\get()
		-- 	if not color then color = Color(255, 0, 0)
		-- 	r, g, b, a = love.graphics.getColor()
		-- 	love.graphics.setColor(color)
		-- 	love.graphics.rectangle('fill', position.x, position.y, shape.width, shape.height)
		-- 	love.graphics.setColor(r, g, b, a)

	drawSprite: (entity) =>
		{ :sprite, :animation, :shape, :position } = entity\get()
		isAnimated = not sprite
		if isAnimated then sprite = animation

		spritePosition = position\clone()
		spritePosition.x += (shape.width - sprite.shape.width) / 2
		spritePosition.y += (shape.height - sprite.shape.height)

		if isAnimated
			animation.value\draw(sprite.image, spritePosition.x, spritePosition.y, sprite.options.rotation, sprite.options.scale.x, sprite.options.scale.y)
		else
			love.graphics.draw(sprite.image, sprite.quad, spritePosition.x, spritePosition.y, sprite.rotation, sprite.scale.x, sprite.scale.y)


	-- requires: () => {
	-- 	animated: { 'animation', 'animationList', 'shape', 'position' },
	-- 	sprites: { 'sprite', 'shape', 'position' },
	-- 	polygons: { 'shape', 'position' },
	-- }
