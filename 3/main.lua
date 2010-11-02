--[[ Open Url, the third example by Appsamuck.
          http://appsamuck.com/day3.html
	 Lots of code, like ScrollView and Util, by Gilbert Guerrero: http://github.com/gg-ansca/ATA
	 I just changed the buttons info, really. 
	 To be honest, it's just a launcher, like the Google App for iPhone.
  ]]

local scrollView = require("scrollView")
local util = require("util")

-- Hide the Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Create the group
local g = display.newGroup()

-- Setup a scrollable content group
local scrollView = scrollView.new{ top=0, bottom=48 }

-- A couple of tables with the buttons info
local supportBtn = { "Phone", "SMS", "E-Mail", "Map", "Browser" }
local supportLinks = { "tel://8004664411", "sms://466453", "mailto://devprograms@apple.com",
 	"http://maps.google.com/?q=1%20Infinite%20Loop", "http://www.anscamobile.com/" }

-- Nice loop to place and connect all the buttons
for i=1, #supportBtn do 
	local button = display.newGroup()
	local bg = display.newRoundedRect( 0, 0, display.contentWidth-100, 50, 6 ) 	
	bg:setFillColor( 255, 255, 255, 50 )
	bg:setStrokeColor( 255, 255, 255, 255 )
	bg.strokeWidth = 1
	bg.x = 0 
	button:insert( bg )
	local t = display.newText( "Open " .. supportBtn[i] .. " URL", 0, 0, "Helvetica", 14 )
	t:setTextColor( 255, 255, 255 )
	t.x = 0
	t.y = math.floor(bg.height/2) - 3
	button:insert( t )
	button.link = supportLinks[i]
	button:addEventListener("tap", util.aLink)
	button.x = display.contentWidth*0.5
	button.y = math.floor( 20 + (button.height + 24)*(i-1) + 24 )
	scrollView:insert( button )	
end

-- Some black background
local background = display.newRect(0, 0, display.contentWidth, scrollView.height)
background:setFillColor(0,0,0)
scrollView:insert(1, background)

-- And insert of the scrollview into the group
g:insert(scrollView)
