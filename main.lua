--[[

	Game Off 2018 game prototype
	Created by: Shudra Igor
	Date: 19.11.18
	
	This is the main file which represents main functionality of the game.
]]


--[[ ============ REQUIRES ============ ]]
push = require 'utility/push'
require 'Map'

--[[ ============ VARIABLES ============ ]]
virtualWidth = 480
virtualHeight = 320

windowWidth = 1920
windowHeight = 1080

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
	love.graphics.setDefaultFilter('nearest', 'nearest')

	push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {
		fullscreen = true,
		resizeable = true
	})
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
	push:apply('start')

	love.graphics.clear(247 / 255, 232 / 255, 64 / 255, 1)

	-- Map movement according to the camera offset
	love.graphics.translate(math.floor(-map.camX + 0.5), math.floor(-map.camY + 0.5))
	map:render()

	push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.resize(w, h)
	push:resize(w, h)
end