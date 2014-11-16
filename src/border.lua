local top = 72
local width = 80

local c = white

local border = {

	setColour = function(new_c) c = new_c end,

	draw = function()
		inScreenCanvas()
		clearAlpha()
		c()
		rekt(0, 0, W, H)
	end
}


return border