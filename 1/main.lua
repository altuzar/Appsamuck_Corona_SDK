--[[ This is the first example you can watch in: 
          http://www.appsamuck.com/day1.html
  ]] 

-- Some vars. I didn't want to be cryptic
local last, now, hour, min, sec

-- Hide the Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Big textfield with Jack Bauer's 24 font. Don't know if works for Android
local timeTextfield = display.newText( "00:00:00", 
	display.contentWidth * 0.03, display.contentHeight * 0.38, "DBLCDTempBlack", 70 )
timeTextfield:setTextColor(255,0,0)

-- Main function. Only updated when time really changes
displayTime = function ()
	if last ~= os.date( "%c" ) then
		last = os.date( "%c" )
		now = os.date( '*t' )
		hour = string.format("%02d", 23 - now.hour )
		min = string.format("%02d", 59 - now.min )
		sec = string.format("%02d", 59 - now.sec )
		timeTextfield.text = hour .. ":" .. min .. ":" .. sec
	end
end

-- And this is the game loop
Runtime:addEventListener( "enterFrame", displayTime )
