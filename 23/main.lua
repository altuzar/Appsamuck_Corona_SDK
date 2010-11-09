--[[ Hypno, the example by Appsamuck.
          http://appsamuck.com/day23.html
	 An animation made for psychiatrists. Just some hypnotic balls and a transition of rotation & fade out.
  ]]

-- Hide the Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Width, Height and a couple of frequency parameters
local w,h = display.contentWidth, display.contentHeight
local minrand = 400
local maxrand = 1100

-- Main function, to create one ball and then a timer to create the next one.
-- I was a little worried about the performance, but the increase of RAM is minimal. Anyhow, there is a small leak.
function createHypnoball()
	local hypno = display.newImage( "hypno.png" )
	hypno.x = math.random (30, w-30)
	hypno.y = math.random (30, h-30)
	-- Here is the animation, with the transition.to and the time, alpha and rotation
	transition.to( hypno, { time=5000, alpha=0, rotation=90 } )
	timer.performWithDelay( math.random (minrand, maxrand), createHypnoball, 1 )
end

-- Some music with a loop
media.playSound( 'letsgo.m4v', true )

-- And launch it
createHypnoball()



