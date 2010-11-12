--[[ Photo Frame, the example by Appsamuck.
          http://appsamuck.com/day27.html
		A quite simple app of an image and a frame. I can imagine that the app should have
		display the user's photos, but I don't think Corona can access the iPhone or Android
		images stored by the owner of the device. 
  ]]

-- Goodbye Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Width, Height. Like this shortcuts
local w,h = display.contentWidth, display.contentHeight

-- Kittens! Never saw photos like this one in the internet
local kitten = display.newImage( "kitten8va.jpg" )
kitten.x = w / 2
kitten.y = h / 2

-- Now the frame and that's it
local frame = display.newImage( "gframe.png" )
frame.x = w / 2
frame.y = h / 2
