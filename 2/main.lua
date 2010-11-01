--[[ Second example by Appsamuck, translated to Corona SDK Game Edition and LUA
          http://appsamuck.com/day2.html
  ]]

-- Hide the Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Load the movieclip.lua
local movieclip = require( "movieclip" )

-- New background
local background = display.newGroup();

-- Create a table with the 17 filenames of the images
imageFireTable = {}
for i = 1,17 do
	table.insert( imageFireTable, "campFire" .. string.format("%02d", i) .. ".gif" )
end

-- Here's the movieclip create and insert into the background
myAnim = movieclip.newAnim( imageFireTable )
background:insert( myAnim )

-- Center the clip
myAnim.x = display.contentWidth / 2
myAnim.y = display.contentHeight / 2

-- Play!
myAnim:play()
