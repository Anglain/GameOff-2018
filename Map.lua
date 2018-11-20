--[[

	Game Off 2018 game prototype
	Created by: Shudra Igor
	Date: 19.11.18
	
	This file is responsible for drawing ground and background tiles.
]]


--[[ ============ REQUIRES ============ ]]
require 'utility/util'

Map = {}
Map.__index = Map


--[[ ============ VARIABLES ============ ]]
-- Tile indecies in the spritesheet
TILE_EMPTY = 90

TILE_WALKING_GROUND_LEFT_CORNER = 33
TILE_WALKING_GROUND = 34
TILE_WALKING_GROUND_RIGHT_CORNER = 35
TILE_WALKING_GROUND_LEFT_SIDE = 57
TILE_SOLID_GROUND = 58
TILE_WALKING_GROUND_RIGHT_SIDE = 59

-- Camera scroll speed
local scrollSpeed = 169
local tileRenderOffset = 0

--[[ ============ FUNCTIONS ============ ]]
function Map:create()

	local this = {
		-- Texture and rendering parameters
		spritesheet = love.graphics.newImage('images/simple_tileset.png'),
		tileWidth = 32,
		tileHeight = 32,
		mapWidth = 16,
		mapHeight = 16,
		tiles = {},

		-- Camera position parameters
		cameraPosition = {
			x = 0,
			y = -3
		},

		-- Player walk borders
		borders = {
			left = 0,
			right = 0
		}
	}

	-- Generating quad list from the spritesheet to fill in the ground
	this.tileSprites = generateQuads(this.spritesheet, this.tileWidth, this.tileHeight)

	-- Counting and saving pixel size of the map
	this.mapWidthPixels = this.mapWidth * this.tileWidth
	this.mapHeightPixels = this.mapHeight * this.tileHeight

	-- METATABLE ACTION IN THE HOUSE
	setmetatable(this, self)


	this.player = Player:create(this)

	-- Making standard player borders
	this.borders.left = 0
	this.borders.right = this.mapWidthPixels - this.player.width

	this:generateTiles(this)

	-- Sprite batch for effective tile drawing
	this.spriteBatch = love.graphics.newSpriteBatch(this.spritesheet, this.mapWidth * this.mapHeight)

	-- Create sprite batch from tile quads
	for y = 1, this.mapHeight do
		for x = 1, this.mapWidth do
			this.spriteBatch:add(this.tileSprites[this:getTile(x,y)],
								 (x - 1) * this.tileWidth - tileRenderOffset,
								 (y - 1) * this.tileHeight)
		end
	end

	return this
end

function Map:update(dt)
	self.player:update(dt)

	-- Keeping camera on the player and preventing it to scroll through the borders of the screen
	self.cameraPosition.x = math.max(0,
							 math.min(self.player.position.x - virtualWidth / 2,
							 	      math.min(self.mapWidthPixels - virtualWidth,
							 	      	       self.player.position.x)))

	
end

-- Setting tile type on the map
function Map:setTile(x, y, tile)
	self.tiles[x + (y-1) * self.mapWidth] = tile
end

-- Getting tile type from the map
function Map:getTile(x, y)
	return self.tiles[x + (y-1) * self.mapWidth]
end

-- All map generation code goes here
function Map:generateTiles(this)
	-- Set all the map with empty tiles so the rendering won't crash if something is not rendered
	for y = 1, this.mapHeight do
		for x = 1, this.mapWidth do
			this:setTile(x, y, TILE_EMPTY)
		end
	end

	-- Set walking ground tiles
	for x = 2, this.mapWidth - 1 do
		this:setTile(x, this.mapHeight / 2, TILE_WALKING_GROUND)
	end

	-- Set upper corner tiles
	this:setTile(1, this.mapHeight / 2, TILE_WALKING_GROUND_LEFT_CORNER)
	this:setTile(this.mapWidth, this.mapHeight / 2, TILE_WALKING_GROUND_RIGHT_CORNER)

	-- Set left and right side tiles
	for y = this.mapHeight / 2 + 1, this.mapHeight do
		this:setTile(1, y, TILE_WALKING_GROUND_LEFT_SIDE)
		this:setTile(this.mapWidth, y, TILE_WALKING_GROUND_RIGHT_SIDE)
	end

	-- Set ground filling tiles
	for y = this.mapHeight / 2 + 1, this.mapHeight do
		for x = 2, this.mapWidth - 1 do
			this:setTile(x, y, TILE_SOLID_GROUND)
		end
	end
end

-- Rendering the Map - goes right into the love.draw
function Map:render()
	love.graphics.draw(self.spriteBatch)
	self.player:render()
end