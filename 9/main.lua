--[[ Snow Fall, the example by Appsamuck.
          http://appsamuck.com/day9.html
	Snow flakes falling from the sky. Finally a Physics example and accelerometer included. 
  ]]
-- Performance issues: 2000 flakes:  55MB RAM, 64% CPU. Looks like those flakes fall forever

-- Here is the Physics, with a slow gravity to only 3.5 (almost a third of default 9.8)
local physics = require("physics")
physics.start()
physics.setGravity( 0, 3.5 )

-- Hide Status Bar. Just hate it
display.setStatusBar( display.HiddenStatusBar )

-- Randomize
math.randomseed( os.time() )  

-- Now the accelerometer setup to mess with the gravity of the flakes
system.setAccelerometerInterval( 100 ) 

function onTilt( event )
	physics.setGravity( ( 3.5 * event.xGravity ), ( -3.5 * event.yGravity ) )
end

Runtime:addEventListener( "accelerometer", onTilt )

-- Pale blue sky
local background = display.newRect(0, 0, display.contentWidth, display.contentHeight )
background:setFillColor(128,128,255)

-- Main function here. Couldn't find a destroy. Maybe with a timer after 5 secs
function newFlake()	
	f = display.newImage("flake.png");
	f.x = 60 + math.random( 160 )
	f.y = -100
	local scale = math.random( 30, 80 ) / 100 
	f:scale( scale, scale )
	f.alpha = 0.25
	physics.addBody( f, { density=math.random(), friction=math.random()/2, bounce=0.3} )
--	local removeFlake = timer.performWithDelay( 5000, f:removeSelf(), 1 ) -- Trying to make a flake destroyer
end

-- Flakes Launcher!
local dropFlakes = timer.performWithDelay( 35, newFlake, 500 ) -- 36
