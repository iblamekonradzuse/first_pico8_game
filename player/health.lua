--------- health --------
function init_health()
	health = 100
end

function update_health()
	-- if health > 18 then
	--		health -=2
	--	end
end

function draw_health()
	--	rect(cx+4,cy+4,cx+34,cy+8,6)
	if health > 90 then
		rectfill(cx + 5, cy + 9, cx + 0.38 * health, cy + 13, 8)
	elseif health <= 90 and health > 65 then
		rectfill(cx + 5, cy + 9, cx + 0.38 * health, cy + 13, 9)
	elseif health <= 65 and health > 45 then
		rectfill(cx + 5, cy + 9, cx + 0.38 * health, cy + 13, 8)
	else
		rectfill(6, 6, 6, 6, 1)
		dead = true
	end

	spr(128, cx + 4, cy + 8)
	spr(129, cx + 12, cy + 8)
	spr(130, cx + 20, cy + 8)
	spr(131, cx + 28, cy + 8)
	spr(132, cx + 36, cy + 8)
end
