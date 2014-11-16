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
  end

end


function state:update(dt)

end

function state:draw()

end


--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state