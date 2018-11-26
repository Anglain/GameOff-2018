--[[

	Game Off 2018 game prototype
	Created by: Shudra Igor
	Date: 26.11.18
	
	This file is responsible for placing space station rooms.
]]

Room = {}
Room.__index = Room

roomTypes = {
	restroom = {},
	aviary = {},
	dna_lab = {}
}

function Room:create(type)

	local this = {
		mapPosition = {
			x = nil,
			y = nil
		},
		type = nil,
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