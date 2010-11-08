--[[ iDrum, the example by Appsamuck.
          http://appsamuck.com/day21.html
	 This is a very very very simple example of a little drum and a button listener for a playable WAV. 
	 You know the drill.
	 Btw, the drum wav sound is here: http://www.freesound.org/samplesViewSingle.php?id=108091
  ]]

-- Ciao Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Big backround of the drum
local drum = display.newImage( "drum.png" )
drum.x = display.contentWidth/2; drum.y = display.contentHeight/2

-- An event sound. I imagine it's necessary so is played without delays each time
local drumID = media.newEventSound( "108091__alienbomb__kck.6.wav" )

-- The tap event for the drum. It frakin plays!
function drum:tap( event )
    media.playEventSound( drumID )
end

-- The drum background listener
drum:addEventListener( "tap", drum )

-- An finally, a little sound when the application loads
media.playSound( "Start.caf" )