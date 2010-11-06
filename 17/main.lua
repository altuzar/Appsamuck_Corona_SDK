--[[ Fireball, the example by Appsamuck.
          http://appsamuck.com/day17.html
	 To be honest, I don't have a lot of experience with animations. In particular if those animations, even if
	 quite simple, are kind of "low level", and not only a transitionTo or something like that. Anyway, was good
	 to learn about the Corona's Runtime and some other things.
	 Thanks to @_zetta for a lot of this code!
  ]]

-- Good bye status bar
display.setStatusBar( display.HiddenStatusBar )

-- 3 parameters for the number of balls, the distance between them and an offset I had to do
local totalballs = 30
local distance = -2.9
local offset = 3

-- Lots of vars and tables
local width = display.contentWidth
local height = display.contentHeight
local balls = {}
local xlastpos = {}
local ylastpos = {}
local xinit = math.random(width-45) + 25
local yinit = math.random(height-45) + 25

-- Here is the creation of the balls. It's a reversed loop (30 to 1) so that the last ball is over the rest
for i = totalballs, 1, -1 do
	if i == 1 then
		local fire = display.newImage( "fireball.png",-50,-50 ) --) + 15, math.random(HEIGHT-30) + 15 )
		fire:scale(.3,.3)
		fire.speed = 5 --math.random(2,6)
		fire.direction = math.random(0,1) < 1 and -1 or 1
		fire.speed = fire.speed*fire.direction
		fire.speedOnX, fire.speedOnY = fire.speed, fire.speed -- multiple asignation
	    balls[i] = fire
	else
		local smoke = display.newImage( "smokeball.png",xinit,yinit)
		smoke:scale(.3,.3)
	    balls[i] = smoke
	end
	balls[i].x = xinit
	balls[i].y = yinit
end 

function doAllTheBallsMove()
	balls[1].x = balls[1].x + balls[1].speedOnX
	balls[1].y = balls[1].y + balls[1].speedOnY
	if balls[1].x >= width or balls[1].x <= 0 then
		balls[1].speedOnX = balls[1].speedOnX*-1
	end
	if balls[1].y >= height or balls[1].y <= 0 then
		balls[1].speedOnY = balls[1].speedOnY*-1
	end
	table.insert( xlastpos, 1, balls[1].x + ( balls[1].speedOnX * distance ) )
	table.insert( ylastpos, 1, balls[1].y + ( balls[1].speedOnY * distance ) )
	for i = 2, totalballs do
		if i*offset <= #xlastpos + 1 then
			balls[i].x = xlastpos[(i-1)*offset] 
			balls[i].y = ylastpos[(i-1)*offset] 
			balls[i].alpha = 2/i
			-- Couldn't make the scale. Maybe in the next version.
--				balls[i].xscale = 2/i
--				balls[i].yscale = 2/i
			if i == 2 then
				balls[i].x = xlastpos[i]
				balls[i].y = ylastpos[i]
			end
		else
			balls[i].alpha = 0
		end
	end
	-- Keeps the tables small
	if #xlastpos >= totalballs*offset then
		xlastpos[totalballs*offset] = nil
		ylastpos[totalballs*offset] = nil
	end
end

-- The main loop. Lots os tricks and stuff
Runtime:addEventListener( "enterFrame", doAllTheBallsMove )

-- And that's it. There is no launcher because all is done with the Runtime:addEventListener( "enterFrame", func )