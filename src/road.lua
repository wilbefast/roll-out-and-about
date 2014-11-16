local top = 72
local width = 80

local road = {

	width = function() return width end,

	top = function() return top end,

	draw = function() 
		-- top border
		inAlphaCanvas(2)
			rekt(0, 71, w, 1)
		inColourCanvas(2)
			grey()
			rekt(0, 64, w, 8)
		-- tarmac
		inColourCanvas(1)
		if Bomb.BOOM > 0 then
			violet()
		else
			darkRed()
		end
			rekt(0, top, w, width)
		-- bottom border
		inAlphaCanvas(2)
			rekt(0, top + width, w, 2)
		inColourCanvas(2)
			blue()
			rekt(0, top + width, w, 8)

	end
}


return road