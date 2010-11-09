--[[ Amuck Colors, the example by Appsamuck.
          http://appsamuck.com/day24.html
	 A simple draggable image. Preferred to change the original image, because of copyrights from VisiBone.com
	 Had a couple of problems with the draggable object, and tried with a movieclip. I'm sure the in the future,
	 with the next versions of Corona, this will be more simple. 
  ]]

-- The import of movieclip.lua
local movieclip = require( "movieclip" )

-- Goodbye Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Don't know why, but without this newImage the cheat-sheet for the movieclip is scaled down. Don't like it at all
local chart = display.newImage( "git-cheat-sheet-medium.png", 0, 0, true )
chart.alpha = 0

-- The setDrag is only available for movieclips, so I created one
local myAnim =  movieclip.newAnim{ "git-cheat-sheet-medium.png" }
 
-- Drags events
local function pressFunction()
  myAnim.alpha = 0.8
end
        
local function releaseFunction()
  myAnim.alpha = 1.0
end
        
-- Now the drag
myAnim:setDrag{ 
  drag=true,
  onPress=pressFunction, 
  onRelease=releaseFunction,
  -- The bounds are tricky. Didn't understand, really
  -- Maybe the simulator thinks the dimensions of the image are different. Width and Height don't work
  bounds = { -540, -400, 1100, 850 }
}

-- Places the movieclip and that's all
myAnim.x = 1010 / 2
myAnim.y = 800 / 2
