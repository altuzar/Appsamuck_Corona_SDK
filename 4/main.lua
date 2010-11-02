--[[ Show My Ip is the fourth example by Appsamuck:
          http://www.appsamuck.com/day4.html
		Sadly, the system.getInfo("ip"), or something like that, is not supported via Corona 
		or even via iOS SKD for that matter, as long as I know. There are a couple of undocumented 
		tricks that can be done. The LuaSocket is another option. 
		So, unless someone can do something about it, the local IP is...
  ]] 

function getIp()
	-- Hopefully, there will be a more useful IP Address
	return "127.0.0.1"
end
	
-- Hide the Status Bar
display.setStatusBar( display.HiddenStatusBar )

-- A nice var
local ip = getIp()

-- Set the textfield with the address
local ipTextfield = display.newText( "IP Address: " .. ip, 
	display.contentWidth * 0.03, display.contentHeight * 0.12, "Arial", 18 )
ipTextfield:setTextColor(255,255,255)
