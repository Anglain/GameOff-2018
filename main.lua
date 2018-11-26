--[[

	Game Off 2018 game prototype
	Created by: Shudra Igor
	Date: 19.11.18
	
	This is the main file which represents main functionality of the game.
]]


--[[ ============ REQUIRES ============ ]]
push = require 'utility/push'
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
	love.graphics.setDefaultFilter('nearest', 'nearest')

	push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {
		fullscreen = false,
		resizeable = true
	})

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
	gui:update(dt)
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

	-- Map movement according to the camera position set in Map
	local translateX = math.floor(-map.cameraPosition.x + 0.5)
	local translateY = math.floor(-map.cameraPosition.y + 0.5)
	love.graphics.translate(translateX, translateY)

	map:render()
	drawInterface()

	push:apply('end')
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

    gui:keypress(key)
end

function love.textinput(key)
	gui:textinput(key)
end

function love.mousepressed(x, y, button)
	gui:mousepress(x, y, button)
end

function love.mousereleased(x, y, button)
	gui:mouserelease(x, y, button)
end

function wheelMoved(x, y)
	gui:mouseWheel(x, y)
end

function love.resize(w, h)
	push:resize(w, h)
end