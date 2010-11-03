--[[ Plumb-bob, the example by Appsamuck.
          http://appsamuck.com/day11.html
	This was obviously based on the Corona Game Edition example called Chains. Not sure if the accelerometer
	works as it should, but as soon as I can install it on a device, I'll test it.
  ]]

-- Here comes the Physics
local physics = require("physics")
physics.start()

-- Some Physics scale for beter "physics resolution", like in the Pool example
physics.setScale( 60 )

-- Hide the bar
display.setStatusBar( display.HiddenStatusBar )

-- A bar just for appearance
local beam3 = display.newImage( "beam_long.png" )
beam3.x = 280; beam3.y = 50
physics.addBody( beam3, "static", { friction=0.5 } )

-- Here is the long chain, where the Plumb is linked
local myJoints = {}
local link = {}
for j = 1,17 do
	link[j] = display.newImage( "link.png" )
	link[j].x = display.contentWidth/2
	link[j].y = 55 + (j*17)
	physics.addBody( link[j], { density=2.0, friction=0, bounce=0 } )
		
	if (j > 1) then
		prevLink = link[j-1] 
	else
		prevLink = beam3
	end
	myJoints[#myJoints + 1] = physics.newJoint( "pivot", prevLink, link[j], display.contentWidth/2, 46 + (j*17) )
end

-- And the Plumb is added. With the Y of the image I just got lucky
link[18] = display.newImage( "plumb.png" )
link[18].x = display.contentWidth/2 
link[18].y = 55 + (18*17) + 29
physics.addBody( link[18], { density=2.0, friction=0, bounce=0 } )
prevLink = link[17]
myJoints[#myJoints + 1] = physics.newJoint( "pivot", prevLink, link[18], display.contentWidth/2, 46 + (18*17) + 29 )

-- And finally, the accelerometer setup. Hopefully it works!
system.setAccelerometerInterval( 100 ) 

function onTilt( event )
    physics.setGravity( 10 * event.xGravity, -10 * event.yGravity )
end

Runtime:addEventListener( "accelerometer", onTilt )

