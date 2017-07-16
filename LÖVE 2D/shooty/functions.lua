function clamp(val, lower, upper)
  assert(val and lower and upper, "not very useful error message here")
  if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
  return math.max(lower, math.min(upper, val))
end

function firstEmptyKey(array)
	local len = #array
	if len == 0 then return 1
	elseif len == 1 then return 2
	elseif array[len-1] == nil then return len - 1
	else return len + 1
	end
end

function distance (x1, y1, x2, y2)
  local dx, dy = x1 - x2, y1 - y2
 	return math.sqrt(dx^2 + dy^2)
end
