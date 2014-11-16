local state = gamestate.new()

--[[------------------------------------------------------------
Gamestate navigation
--]]--

function state:init()
end

function state:enter()

end


function state:leave()
end

--[[------------------------------------------------------------
Callbacks
--]]--


function state:keypressed(key, uni)
  if key=="escape" then
    love.event.push("quit")
  elseif key==" " then
    gamestate.switch(game)
  end

end


function state:update(dt)

	-- scrolling
	skyline_back.update(dt*0.5)
	skyline_front.update(dt*0.5)

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

	-- foreground
	skyline_front.draw()
end


--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state