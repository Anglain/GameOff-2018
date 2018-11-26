--[[

	Game Off 2018 game prototype
	Created by: Shudra Igor
	Date: 26.11.18
	
	This file is responsible for all the UI.
]]

gui = require('utility/Gspot'):setComponentMax('native')

local button = gui:button("Hello", {100, 100, 100, 100})

local oldTranslateX = 0
local oldTranslateY = 0

function loadInterface()
	button.click =  function (this)

				   	end
end

function drawInterface()

	-- gui:draw()
end