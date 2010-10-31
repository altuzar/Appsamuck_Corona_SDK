
local last, now, hour, min, sec

display.setStatusBar( display.HiddenStatusBar )

local timeTextfield = display.newText( "00:00:00", 
	display.contentWidth * 0.03, display.contentHeight * 0.38, "DBLCDTempBlack", 70 )
timeTextfield:setTextColor(255,0,0)

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

Runtime:addEventListener( "enterFrame", displayTime )
