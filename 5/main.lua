--[[ Count Me In, by Appsamuck, translated to Corona SDK Game Edition and LUA
          http://appsamuck.com/day5.html
  ]]

-- Hide the Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- The number var
local number = 0

-- Background setup
local bkg = display.newImage( "backgroundPattern.png" )
bkg.x = 160; bkg.y = 240

-- Here is the big text field with Jack Bauer's font
local timeTextfield = display.newText( "00", 
	display.contentWidth * 0.3, display.contentHeight * 0.12, "DBLCDTempBlack", 100 )
timeTextfield:setTextColor(255,0,0)

-- A couple of buttons
local btnplus = display.newImage( "iconGreenAdd.png" )
btnplus.x = 80; btnplus.y = 400
local btnminus = display.newImage( "iconRedSubtract.png" )
btnminus.x = 240; btnminus.y = 400

-- A formated set text for the text field
function displayNumber()
	timeTextfield.text = string.format("%02d", number)
end

-- The number goes up
function btnplus:tap( event )
	number = number + 1
	displayNumber()
end

-- The number goes down
function btnminus:tap( event )
	number = number - 1
	displayNumber()
end

-- Two listeners for the two buttons
btnplus:addEventListener( "tap", btnplus )
btnminus:addEventListener( "tap", btnminus )
