--[[ LavaFlow, the example by Appsamuck.
          http://appsamuck.com/day26.html
	I still don't have a code signature for iPhone, so couldn't try out this little code properly. 
	Sorry about that! But as soon as I have one, I'll check this code. Promise!
  ]]

-- Goodbye Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- When the video is over, this is triggered.
local onComplete = function(event)
   print( "video session ended" )
end

-- Here comes the little video. 
media.playVideo( "lavaFlow.m4v", false, onComplete )