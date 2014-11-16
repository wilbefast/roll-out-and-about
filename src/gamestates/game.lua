local state = gamestate.new()

--[[------------------------------------------------------------
Constants
--]]--

local timer = 3

--[[------------------------------------------------------------
Gamestate navigation
--]]--

function state:init()
end

function state:enter()
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

	

	GameObject.updateAll(dt)

	timer = timer -dt
	if timer <= 0 then
		timer = 1

		Bomb(w, road.top() + 8 + math.random(road.width() - 16))
	end
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