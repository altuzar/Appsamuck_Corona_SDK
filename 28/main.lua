--[[ Digi Clock, the example by Appsamuck.
          http://appsamuck.com/day28.html
	 This one was a kinda special example, because there were a lot of little details here and there.
     The AM/PM dots, the numbers 1 and 7 that moved 'cause of the typography, the array of digits. 
   	 Besides, there is a Warning about the object.alpha outside valid range, that I don't understand. Must be
     the Corona animation.transition somewhere. But hey, it works!
  ]]

-- Kill Status Bar 
display.setStatusBar( display.HiddenStatusBar )

-- A couple of vars and tables
local hour, min
local offset = { 0.275, 0.385, 0.555, 0.67 }
local digit = {}
local hours = {}

-- Width, Height. Like this shortcuts
local w,h = display.contentWidth, display.contentHeight

-- White background
local bkg = display.newRect( 0, 0, w, h )
bkg:setFillColor(255, 255, 255)

-- Nice watch by Appsamuck
local clock = display.newImage( "clockBackground.png" )
clock.x = w / 2
clock.y = h / 2

-- The digits, but a little smooth to a nice view
local timeBackTextfield = display.newText( "88 88", 
	w * 0.22, h * 0.38, "DBLCDTempBlack", 56 )
timeBackTextfield:setTextColor(0,255,0)
timeBackTextfield.alpha = .2

-- Create the 4 digits, so they can be placed individually
for i=1,4 do
	digit[i] = display.newText( "0", 
		0, h * 0.38, "DBLCDTempBlack", 56 )
	digit[i]:setTextColor(0,255,0)
end

-- AM and PM dots
local am = display.newCircle( w * 0.19, h * 0.43, 3 )
am:setFillColor(0,255,0)

local pm = display.newCircle( w * 0.186, h * 0.467, 3 )
pm:setFillColor(0,255,0)

-- And the little dots between the hours and the minutes
local dot1 = display.newRoundedRect(  w * 0.463, h * 0.425, 6, 6, 3 ) 
dot1:setFillColor(0,255,0)
dot1.alpha = 0

local dot2 = display.newRoundedRect( w * 0.454, h * 0.465, 6, 6, 3 ) 
dot2:setFillColor(0,255,0)
dot2.alpha = 0

-- Here is the main function to place the digits
function checkClock()
	hour = string.format("%02d", os.date( '*t' ).hour )
	if os.date( '*t' ).hour > 12 then
		hour = string.format("%02d", os.date( '*t' ).hour - 12 )
	end
	min = string.format("%02d", os.date( '*t' ).min )
	hours = { hour:sub(0,1), hour:sub(-1), min:sub(0,1), min:sub(-1) }
	for i=1,4 do
		digit[i].text = hours[i]
		digit[i].x = w * offset[i]
		-- A little offset when there is a 1 and a 7, because they have different widths
		if hours[i] == "1" then
			digit[i].x = ( w * offset[i] ) + 12
		elseif hours[i] == "7" then
			digit[i].x = ( w * offset[i] ) + 4		
		end
	end
end

-- Place the little AM/PM dots with nice alphas
function checkAmPm()
	if os.date( '*t' ).hour > 11 then
		am.alpha = .2
		pm.alpha = .9
	else
		am.alpha = .9
		pm.alpha = .2
	end
end

-- And the tictac function, to animate the dots and to call the functions when the minutes change
function tictac()
	transition.to( dot1, { time=200, alpha=0.9 } )
	transition.to( dot1, { time=750, delay=200, alpha=0 } )
	transition.to( dot2, { time=200, alpha=0.9 } )
	transition.to( dot2, { time=750, delay=200, alpha=0 } )
	if last ~= os.date( '*t' ).min then
		last = os.date( '*t' ).min
		checkClock()
		checkAmPm()
	end
	timer.performWithDelay(1000, tictac, 1)	
end

-- Launch!
tictac()
