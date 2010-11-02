-- scrollView.lua Scroll View Library
-- Version 0.2
 
module(..., package.seeall)

-- set some global values for width and height of the screen
local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

local prevTime = 0

function new(params)
	-- setup a group to be the scrolling screen
	local scrollView = display.newGroup()
	
	scrollView.top = params.top or 0
	scrollView.bottom = params.bottom or 0

	function scrollView:touch(event) 
	        local phase = event.phase      
	        print(phase)
	        			        
	        if( phase == "began" ) then
	                self.startPos = event.y
	                self.prevPos = event.y                                       
	                self.delta, self.velocity = 0, 0
		            if self.tween then transition.cancel(self.tween) end

	                Runtime:removeEventListener("enterFrame", scrollView ) 

					self.prevTime = 0
					self.prevY = 0

					-- Start tracking velocity
					Runtime:addEventListener("enterFrame", trackVelocity)
	                
	                -- Subsequent touch events will target button even if they are outside the stageBounds of button
	                display.getCurrentStage():setFocus( self )
	                self.isFocus = true
	 
	        elseif( self.isFocus ) then
	 
	                if( phase == "moved" ) then     
					        local bottomLimit = screenH - self.height - self.bottom
	            
	                        self.delta = event.y - self.prevPos
	                        self.prevPos = event.y
	                        if ( self.y > self.top or self.y < bottomLimit ) then 
                                self.y  = self.y + self.delta/2
	                        else
                                self.y = self.y + self.delta       
	                        end
	                elseif( phase == "ended" or phase == "cancelled" ) then 
	                        local dragDistance = event.y - self.startPos
							self.lastTime = event.time
	                        
	                        Runtime:addEventListener("enterFrame", scrollView )  	 			
	                        Runtime:removeEventListener("enterFrame", trackVelocity)
           
	        	                	        
	                        -- Allow touch events to be sent normally to the objects they "hit"
	                        display.getCurrentStage():setFocus( nil )
	                        self.isFocus = false
	                end
	        end
	        
	        return true
	end
	 
	function scrollView:enterFrame(event)   
		local friction = 0.9
		local timePassed = event.time - self.lastTime
		self.lastTime = self.lastTime + timePassed       

        --turn off scrolling if velocity is near zero
        if math.abs(self.velocity) < .01 then
                self.velocity = 0
	            Runtime:removeEventListener("enterFrame", scrollView )          
        end       

        self.velocity = self.velocity*friction
        
        self.y = math.floor(self.y + self.velocity*timePassed)
        
        local upperLimit = self.top 
	    local bottomLimit = screenH - self.height - self.bottom
        
        if ( self.y > upperLimit ) then
                self.velocity = 0
                Runtime:removeEventListener("enterFrame", scrollView )          
                self.tween = transition.to(self, { time=400, y=upperLimit, transition=easing.outQuad})
        elseif ( self.y < bottomLimit and bottomLimit < 0 ) then 
                self.velocity = 0
                Runtime:removeEventListener("enterFrame", scrollView )          
                self.tween = transition.to(self, { time=400, y=bottomLimit, transition=easing.outQuad})
        elseif ( self.y < bottomLimit ) then 
                self.velocity = 0
                Runtime:removeEventListener("enterFrame", scrollView )          
                self.tween = transition.to(self, { time=400, y=upperLimit, transition=easing.outQuad})        
        end 
	        
	    return true
	end


	function trackVelocity(event) 	
		local timePassed = event.time - scrollView.prevTime
		scrollView.prevTime = scrollView.prevTime + timePassed
	
		if scrollView.prevY then 
			scrollView.velocity = (scrollView.y - scrollView.prevY)/timePassed 
		end
		scrollView.prevY = scrollView.y
	end			
	    
	    
	scrollView.y = scrollView.top
	
	-- setup the touch listener 
	Runtime:addEventListener( "touch", scrollView )
	
	function scrollView:cleanUp()
        Runtime:removeEventListener("enterFrame", trackVelocity)
		Runtime:removeEventListener( "touch", scrollView )
		Runtime:removeEventListener("enterFrame", scrollView ) 
	end
	
	return scrollView
end
