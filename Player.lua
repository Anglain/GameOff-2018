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
		-- Texture parameters
		texture = love.graphics.newImage('images/captain.png'),
		width = 32,
		height = 72,

		-- Player position and offset (to calculate player's origin right)
		position = {
			x = 0,
			y = 0
		},
		offset = {
			x = 16,
			y = 36
		},

		-- A nice reference to the Map object so we can check the tiles we collide with
		map = map,

		-- Player behaviour machine - states go through this table
		behaviours = {},
		currentState = 'idle',

		-- Player animation frames
		frames = {},
		currentFrame = nil,

		-- Direction which Player is currently facing
		direction = 'right',
		-- Player velocity, used for movement purpouses
		velocity = {
			x = 0,
			y = 0
		}
	}

	-- Setting standard Player position
	-- (NOT SURE HOW TF DOES IT WORK BUT IT WORKS APPARENTLY)
	this.position.x = map.tileWidth * 10
	this.position.y = map.tileHeight * ((map.mapHeight - 2) / 2) - this.height

	-- While no animations are present, we just take our only sprite to be
	-- the only frame in our animation
	this.frames = {
		love.graphics.newQuad(0, 0, this.width, this.height, this.texture:getDimensions())
	}
	this.currentFrame = this.frames[1]

	-- The only state currently is 'idle' - we also walk in this state, wow
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

	-- Some METATABLE functionality (ALSO IDK HOW IT WORKS BUT FINE)
	setmetatable(this, self)

	return this
end

-- Update function - goes right into the love.update
function Player:update(dt)
	self.behaviours[self.currentState](dt)

	self.position.x = self.position.x + self.velocity.x * dt
end

-- Rendering the Player - goes right into the love.draw
function Player:render()
	
	-- Player scale, to see him rotatin'
	local scaleX

	if direction == 'right' then 
		scaleX = 1
	else
		scaleX = -1
	end

	-- Drawing player sprite with all of its properties
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