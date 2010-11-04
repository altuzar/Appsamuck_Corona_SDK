--[[ Sleep Sound, the example by Appsamuck.
          http://appsamuck.com/day14.html
	 This example is simply very very very short. Just one line to display a webpage. Sadly, I just can't 
	 prove it yet, because a web popup is for device only. So please tell me if this doesn't work.
  ]]

-- Hide the Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- A "is playing" boolean
local playing = 0

-- Nice background
local bkg = display.newImage( "oceanwaves.png" )
bkg.x = display.contentWidth / 2
bkg.y = display.contentHeight / 2

-- The button to play the pretty music
local button = display.newImage( "playmusic.png" )
button.x = display.contentWidth / 2
button.y = display.contentHeight / 2

-- The tap event for the button
function button:tap( event )
	if playing == 1 then -- Looks like if (playing) doesn't work in Lua
		playing = 0 -- And looks as well like playing = !playing doesn't work neither
		media.stopSound() -- Maybe a fade out and in would be nice
	else
		playing = 1
		media.playSound( 'oceanwaves.mp3', loop ) -- Here is the magic. Preferred MP3
	end
end

-- And finally the button listener
button:addEventListener( "tap", button )


