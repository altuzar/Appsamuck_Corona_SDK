--[[ Reaction Time, by Appsamuck, translated to Corona SDK Game Edition and LUA
		http://appsamuck.com/day6.html
	This app was better than the other 5 days. A little game, finally, with a timer and a button and
	a movieclip switching the lights. I'm sure the code could be shorter with a language like Lua, but
	as a C++ developer I'm screwed =P
  ]]

-- Hide the Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Load the movieclip.lua
local movieclip = require( "movieclip" )

-- 5 little variables
local currentColor, t1, tapped
local minrand = 800
local maxrand = 2500

-- Randomize
math.randomseed( os.time() )

-- Create the background group
local bkg = display.newGroup()

-- Background images
local road = display.newImage( "road.png" )
road.x = 160; road.y = 240
bkg:insert( road )

local stopLightCable = display.newImage( "stopLightCable.png" )
stopLightCable.x = 160; stopLightCable.y = 16
bkg:insert( stopLightCable )

-- Now a movieclip for the stop lights. By default, the second image (yellow) is displayed after "nextFrame"
local light = display.newGroup()

lights = movieclip.newAnim( { "greenLightSmall.png", "yellowLightSmall.png", 
	"redLightSmall.png" } )
light:insert( lights )
lights.x = 160; lights.y = 134
lights:nextFrame()

-- The gas pedal. It'll be touchable later, when the game starts
local pedal = display.newGroup()

local gasPedal = display.newImage( "gasPedalSmall.png" )
gasPedal.x = 270; gasPedal.y = 400
pedal:insert( gasPedal )

-- I went for 3 different functions: green, red, yellow. Tried to make only 1 function, but it got a little messy
function green()
	if tapped == 0 then
		lights:nextFrame()
		t1 = system.getTimer()
		currentColor = "green"
	end
end

function red()
	if tapped == 0 then
		lights:nextFrame()
		timer.performWithDelay( math.random (minrand, maxrand), green, 1 )
		currentColor = "red"
	end
end

function yellow()
	if tapped == 0 then
		lights:stopAtFrame( 2 )
		timer.performWithDelay( math.random (minrand, maxrand), red, 1 )
		currentColor = "yellow"
	end
end

-- Discovered that the showAlert() don't stop the execution of the script, so I had to create a "Pressed OK"
-- function to relaunch the game
local function onTapped( event )
        if "clicked" == event.action then
			tapped = 0
			yellow()
		end
end

-- A couple of showAlerts to say "Good Job!" or "Slow down!". It could be improved with Views, different messages
-- ad hoc with the timing of the player, a best score history, some sound, etc.
function pedalTap()
	tapped = 1
	if currentColor == "green" then
		local diff = system.getTimer() - t1
		local gone = native.showAlert( "Reaction Time", 
			"Good Job! You're reaction time is " .. diff .. " miliseconds. Let's see if you can do better...", 
			{ "Replay" }, onTapped )
	else
		local badgo = native.showAlert( "Reaction Time", 
			"Slow down! You have to wait for the green light. Let's see if you can do better...", 
			{ "Replay" }, onTapped )
	end	
end

-- The function after the welcome alert setup the tapped boolean and the pedal listener
local function onWelcome( event )
        if "clicked" == event.action then
			tapped = 0
			pedal:addEventListener("tap", pedalTap)
			yellow()
		end
end

-- Finally, the start of the game with some instructions
local welcome = native.showAlert( "Reaction Time", 
	"Hit the gas pedal as fast as you can after the light turns green.", 
	{ "Play" }, onWelcome )
