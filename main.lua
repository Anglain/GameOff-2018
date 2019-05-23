--[[

	Game Off 2018 game prototype
	Created by: Shudra Igor
	Date: 19.11.18
	
	This is the main file which represents main functionality of the game.
]]


--[[ ============ REQUIRES ============ ]]
-- push = require 'utility/push'
require 'Player'
require 'Map'
require 'Interface'

--[[ ============ VARIABLES ============ ]]
virtualWidth = 480
virtualHeight = 320

windowWidth = 960
windowHeight = 640

map = Map:create()

--[[ ============ FUNCTIONS ============ ]]
--[[
 ___      _______  _______  ______  
|   |    |       ||   _   ||      | 
|   |    |   _   ||  |_|  ||  _    |
|   |    |  | |  ||       || | |   |
|   |___ |  |_|  ||       || |_|   |
|       ||       ||   _   ||       |
|_______||_______||__| |__||______| 

--]]
function love.load()

	loadInterface()
end

--[[
 __   __  _______  ______   _______  _______  _______ 
|  | |  ||       ||      | |   _   ||       ||       |
|  | |  ||    _  ||  _    ||  |_|  ||_     _||    ___|
|  |_|  ||   |_| || | |   ||       |  |   |  |   |___ 
|       ||    ___|| |_|   ||       |  |   |  |    ___|
|       ||   |    |       ||   _   |  |   |  |   |___ 
|_______||___|    |______| |__| |__|  |___|  |_______|

--]]
function love.update(dt)
	map:update(dt)
end

--[[
 ______   ______    _______  _     _ 
|      | |    _ |  |   _   || | _ | |
|  _    ||   | ||  |  |_|  || || || |
| | |   ||   |_||_ |       ||       |
| |_|   ||    __  ||       ||       |
|       ||   |  | ||   _   ||   _   |
|______| |___|  |_||__| |__||__| |__|

--]]
function love.draw()
	love.graphics.clear(247 / 255, 232 / 255, 64 / 255, 1)

	-- Map movement according to the camera position set in Map
	local translateX = math.floor(-map.cameraPosition.x + 0.5)
	local translateY = math.floor(-map.cameraPosition.y + 0.5)
	love.graphics.translate(translateX, translateY)

	map:render()
	drawInterface()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'd' then
    	map.mapWidth = map.mapWidth + 1
    	map:reload()
    end

    if key == 'a' then
    	map.mapWidth = map.mapWidth - 1
    	map:reload()
    end
end