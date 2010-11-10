--[[ Sierpinski, the example by Appsamuck.
          http://appsamuck.com/day25.html
	A fractal, built from the ground up! It's like infinite... Well, not really.
  ]]

-- Goodbye Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Width, Height with shortcuts
local w,h = display.contentWidth, display.contentHeight

-- Some vars, taken directly from Appsamuck. Hope it works.
local x = 140;
local y = 140;
local c = 0;
local n = 0;

-- Create the line var outside of the loop. Maybe is a little faster
local line 

-- Here comes the fractal
while c < 100000 do
	line = display.newLine( x+10, 10+240-y, x+10+1, 10+240-y+1 )
	-- This set color was problematic for me, because in the original
	-- it's a float 0-1.0, and here an int 0-255
	line:setColor( y/140 * 255, (140-x)/140 * 255, x/140 * 255, 255 )
	line.width = 1

	n = math.random(0,999)

	if n < 333 then
		x = .5 * (x+300)
		y = .5 * y
	elseif n > 666 then
		x = .5 * (x + 140)
		y = .5 * (y + 240)
	else
		x = x * .5
		y = y * .5
	end
	
	c = c + 1
end

-- A nice grafitti at the bottom
local label = display.newImage( "sierpinski.png" )
label.x = w / 2
label.y = h * .75

-- Some music with a loop
media.playSound( 'letsgo.m4v', true )


