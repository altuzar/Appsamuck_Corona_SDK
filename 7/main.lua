--[[ Fast Dial, the seventh example by Appsamuck.
          http://appsamuck.com/day7.html
	I had a couple of problems with this app. First, there is no Preferences Pane support, as long as I know,
	in Corona. Second: the native.newTextField only works with a device, and I still don't have a iPhone dev
	account. So, this is a sketch of the app. Maybe later, there will be a Preference Pane support or a  
	better TextField, native or not, to complete the app.
  ]]

local scrollView = require("scrollView")
local util = require("util")

-- Hide the Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Create the group
local g = display.newGroup()

-- Setup a scrollable content group
local scrollView = scrollView.new{ top=0, bottom=48 }

local buttonCall = display.newGroup()
local bgCall = display.newRoundedRect( 0, 0, display.contentWidth-100, 150, 6 ) 	
bgCall:setFillColor( 255, 255, 255, 50 )
bgCall:setStrokeColor( 255, 255, 255, 255 )
bgCall.strokeWidth = 1
bgCall.x = 0 
buttonCall:insert( bgCall )
local t = display.newText( "Call", 0, 0, "Helvetica", 72 )
t:setTextColor( 255, 255, 255 )
t.x = 0
t.y = math.floor(bgCall.height/2) - 3
buttonCall:insert( t )
--	button.link = "tel://8004664411"
--	button:addEventListener("tap", util.aLink)
buttonCall.x = display.contentWidth*0.5
buttonCall.y = math.floor( 20 + (buttonCall.height + 24)*(1-1) + 24 )
scrollView:insert( buttonCall )	

local buttonSetup = display.newGroup()
local bgSetup = display.newRoundedRect( 0, 0, display.contentWidth-100, 50, 6 ) 	
bgSetup:setFillColor( 255, 255, 255, 50 )
bgSetup:setStrokeColor( 255, 255, 255, 255 )
bgSetup.strokeWidth = 1
bgSetup.x = 0 
buttonSetup:insert( bgSetup )
local tt = display.newText( "Setup", 0, 0, "Helvetica", 24 )
tt:setTextColor( 255, 255, 255 )
tt.x = 0
tt.y = math.floor(bgSetup.height/2) - 3
buttonSetup:insert( tt )
--	button.link = "tel://8004664411"
--	button:addEventListener("tap", util.aLink)
buttonSetup.x = display.contentWidth*0.5
buttonSetup.y = math.floor( 20 + 180 + 24 )
scrollView:insert( buttonSetup )

function textFieldHandler()
	return
end
numericField = native.newTextField( 50, 150, 220, 36, textFieldHandler )
numericField.inputType = "phone"
numericField.x = display.contentWidth*0.5
numericField.y = math.floor( 20 + 230 + 24 )
scrollView:insert( numericField )


-- Some black background
local background = display.newRect(0, 0, display.contentWidth, scrollView.height)
background:setFillColor(0,0,0)
scrollView:insert(1, background)

-- And insert of the scrollview into the group
g:insert(scrollView)
