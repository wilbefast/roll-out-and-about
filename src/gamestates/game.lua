local state = gamestate.new()

--[[------------------------------------------------------------
Constants
--]]--

local spawn_timer, gameover_timer

--[[------------------------------------------------------------
Gamestate navigation
--]]--

function state:init()
end

function state:enter()
	GameObject.purgeAll()
	score = 0
	spawn_timer = 3
	gameover_timer = 3
	Truck(0, 0)
end


function state:leave()
end

--[[------------------------------------------------------------
Callbacks
--]]--


function state:keypressed(key, uni)
  if key=="escape" then
    love.event.push("quit")
  end

end


function state:update(dt)

	-- scrolling
	skyline_back.update(dt)
	skyline_front.update(dt)

	-- update objects
	GameObject.updateAll(dt)
	local truck = GameObject.getObjectOfType("Truck")

	-- gameover ?
	if not truck then
		gameover_timer = gameover_timer - dt
		if gameover_timer <= 0 then
			gamestate.switch(gameover)
		end
	end

	-- spawn enemies
	spawn_timer = spawn_timer -dt
	if spawn_timer <= 0 then
		spawn_timer = 1

		Bomb(w, road.top() + 8 + math.random(road.width() - 16))
	end

	-- set border colour
	local c = white
	if Bomb.BOOM > 0 then
 		c = grey
 	else
 		if not truck then
 			c = darkViolet
 		else
	 		local l = truck.lives
	 		if l == 1 then
	 			c = darkRed
	 		elseif l == 2 then
	 			c = darkYellow
 			elseif l == 3 then
 				c = darkGreen
 			end
 		end
 	end
 	border.setColour(c) 

 	-- boom!
	Bomb.BOOM = math.max(0, Bomb.BOOM - 4*dt)
end

function state:draw()
 	-- skyline
	inAlphaCanvas(1)
		rekt(0, 0, w, h)
	skyline_back.draw()

	-- background
	local y = skyline_back.h()
	inColourCanvas(1)
		black()
		rekt(0, y, w, 32)

	-- road
	road.draw()

	-- objects
	GameObject.drawAll()

	-- foreground
	skyline_front.draw()
end


--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state