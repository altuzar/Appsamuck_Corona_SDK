--[[ MyGoogle, the example by Appsamuck.
          http://appsamuck.com/day13.html
	 This example is simply very very very short. Just one line to display a webpage. Sadly, I just can't 
	 prove it yet, because a web popup is for device only. So please tell me if this doesn't work.
  ]]

-- Hide the Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Just something to avoid the black screen on the Simulator
local t = display.newText( "If you can read this, really need an iPhone XD", 0, 0, "Helvetica", 14 )
t:setTextColor( 255, 255, 255 )
t.x = display.contentWidth / 2
t.y = display.contentHeight / 2

-- Mmm,  I know it looks like a joke. But that was everything this day! 
native.showWebPopup( 0, 0, display.contentWidth, display.contentHeight, 
                  "http://www.google.com" )