--[[ U Decide, the example by Appsamuck.
          http://appsamuck.com/day12.html
	 A Decision Factory! Like the 8 Ball, but without a nice display of the decision. We need some animations!
  ]]

-- Here are the awesome scroll scripts
local scrollView = require("scrollView")

-- Hide the Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- Randomize!
math.randomseed( os.time() )

-- Create the group
local g = display.newGroup()

-- Setup a scrollable content group
local scrollView = scrollView.new{ top=0, bottom=48 }

-- A table with the buttons info (and content)
local decideBtn = { "Yes/No", "A/B/C/D", "1-100", "Left/Center/Right", "Buy/Sell/Hold", 
	"Agree/Disagree", "Heads/Tails", "Russian Roulette", "Positive/Negative", "True/False" }

-- This dumper was just for debug of the tables. Works awesome!
require( "dumper" )
function dump(...)
  print(DataDumper(...), "\n---")
end

-- A string to table splitter
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function niceDisplay( str )
	-- This should be a * nice * display, with animations or something, but... for now is this crappy alert =P
	local alert = native.showAlert( "U Decide", str, { "Alright" } )
end

-- A random of the table items
function tableRand( tablein )
	return tablein[ math.random( #tablein ) ] -- returns the item number random among the number or items
end

-- The holy brains of the decisions
function letsDecide(e)
	local t = e.target
	if (t.decisions) then
			local dataValues = split(e.target.decisions,"/")
			if #dataValues > 1 then
				niceDisplay( tableRand(dataValues) )
			else
				dataValues = split(e.target.decisions,"-")
				if #dataValues > 1 then
					niceDisplay( math.random( dataValues[1], dataValues[2] ) )
				else
					niceDisplay( "Click..." )
				end
			end
	else
		print("no decisions at all")
	end
end

-- Nice loop to place and connect all the buttons
for i=1, #decideBtn do 
	local button = display.newGroup()
	local bg = display.newRoundedRect( 0, 0, display.contentWidth-100, 50, 6 ) 	
	bg:setFillColor( 255, 255, 255, 50 )
	bg:setStrokeColor( 255, 255, 255, 255 )
	bg.strokeWidth = 1
	bg.x = 0 
	button:insert( bg )
	local t = display.newText( decideBtn[i], 0, 0, "Helvetica", 14 )
	t:setTextColor( 255, 255, 255 )
	t.x = 0
	t.y = math.floor(bg.height/2) - 3
	button:insert( t )
	button.decisions = decideBtn[i]
	button:addEventListener("tap", letsDecide)
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
