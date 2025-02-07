-- pickup --

function ipickups()
	pickups = {}
	add(pickups, {
		x = 485,
		y = 38,
		act = true,
	})
	add(pickups, {
		x = 1000,
		y = 88,
		act = true,
	})
	add(pickups, {
		x = 978,
		y = 278,
		act = true,
	})
	add(pickups, {
		x = 328,
		y = 143,
		act = true,
	})
	add(pickups, {
		x = 891,
		y = 47,
		act = true,
	})
end

function upickups()
	for pu in all(pickups) do
		if pu.act then
			if abs(player.x - pu.x) <= 4 and abs(player.y - pu.y) <= 4 then
				pu.act = false
				health = 100
				sfx(3)
			end
		end

		if health < 30 then
			pu.act = true
		end
	end
end

function dpickups()
	for pu in all(pickups) do
		if pu.act then
			spr(24, pu.x, pu.y)
		end
	end
end
-->8

function dcam()
	if player.y > 200 then
		cy = 220
	elseif player.y > 100 then
		cy = 100
	elseif player.y > 150 then
		cy = 170
	else
		cy = -17
	end
	cx = player.x - 63
	camera(cx, cy)
end
