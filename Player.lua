--[[

	Game Off 2018 game prototype
	Created by: Shudra Igor
	Date: 20.11.18
	
	This file is responsible for player rendering, movement and interactions.
]]

Player = {}
Player.__index = Player

function Player:create(map)
	local this = {
		texture = love.graphics.newImage('images/captain.png'),
		width = 32,
		height = 72,

		position = {
			x = 0,
			y = 0
		},

		offset = {
			x = 16,
			y = 36
		},

		map = map,

		behaviours = {},

		frames = {},
		currentFrame = nil,

		state = 'idle',

		direction = 'right',
		velocity = {
			x = 0,
			y = 0
		},

		gravityScale = 10
	}

	this.position.x = map.tileWidth * 10
	this.position.y = map.tileHeight * ((map.mapHeight - 2) / 2) - this.height

	this.frames = {
		love.graphics.newQuad(0, 0, this.width, this.height, this.texture:getDimensions())
	}

	this.currentFrame = this.frames[1]

	this.behaviours = {
		['idle'] = function (dt)
			if love.keyboard.isDown('left') then
				direction = 'left'
				this.velocity.x = -80
			elseif love.keyboard.isDown('right') then
				direction = 'right'
				this.velocity.x = 80
			else
				this.velocity.x = 0
			end
		end
	}

	setmetatable(this, self)

	return this
end

function Player:update(dt)
	self.behaviours[self.state](dt)

	self.position.x = self.position.x + self.velocity.x * dt
end

function Player:render()

	local scaleX

	if direction == 'right' then 
		scaleX = 1
	else
		scaleX = -1
	end

	love.graphics.draw(self.texture,
					   self.currentFrame,
					   math.floor(self.position.x + self.offset.x),
					   math.floor(self.position.y + self.offset.y),
					   0,
					   scaleX,
					   1,
					   self.offset.x,
					   self.offset.y)
end