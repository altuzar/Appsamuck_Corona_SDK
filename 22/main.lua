--[[ Pumpkin Face, by Appsamuck.
          http://appsamuck.com/day22.html
	 A pretty Halloween animation, with a candle and pumpkin face. The code is so compact with this one, compared
	 to the Objective-C original... Really nice.
  ]]

-- Adiós Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Load the movieclip.lua
local movieclip = require( "movieclip" )

-- The group where the animation of the flame is
local background = display.newGroup();

-- Create a table with 10 filenames. I don't want to write all that. Just hate mechanical work hehe.
imageFireTable = {}
for i = 1,10 do
	table.insert( imageFireTable, "iFlame " .. string.format("%03d", i) .. ".jpg" )
end

-- Here's the movieclip create and insert into the background
myAnim = movieclip.newAnim( imageFireTable )
background:insert( myAnim )

-- Center the clip
myAnim.x = display.contentWidth / 2
myAnim.y = display.contentHeight / 2

-- Create the foreground group, where is the pumpkin
local foreground = display.newGroup();

-- Place the pumpkin. Used an alpha, but then discovered (oh!) that the PNG had transparencies
local pumpkin = display.newImage( "pumpkinFace.png" )
pumpkin.x = display.contentWidth/2; pumpkin.y = display.contentHeight/2
--pumpkin.alpha = 0.99
foreground:insert ( pumpkin )

-- Play the flame!
myAnim:play()
