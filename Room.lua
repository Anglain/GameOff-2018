--[[

	Game Off 2018 game prototype
	Created by: Shudra Igor
	Date: 26.11.18
	
	This file is responsible for placing space station rooms.
]]

Room = {}
Room.__index = Room

roomTypes = {
	restroom = {
		image = 'images/restroom.png'
	},
	aviary = {
		image = 'images/aviary.png'
	},
	dna_lab = {
		image = 'images/genLab.png'
	}
}

function Room:create(type)

	local this = {
		mapPosition = {
			x = 0,
			y = 0
		},
		roomType = type,
		image = nil
	}

	setmetatable(this, self)

	return this
end

function Room:update(dt)
	
end

function Room:render()
	love.graphics.draw()
end