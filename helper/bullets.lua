-- bullets --

function ibullets()
	buls = {}
	shoot_timer = 21
end

function ubullets()
	for b in all(buls) do
		b.x += b.spd

		if abs(b.x - b.start_x) > 45 then
			del(buls, b)
		end

		if b.sprite < b.sprite_end then
			b.sprite += 1
		else
			b.sprite = b.sprite_start
		end

		local tile = mget(b.x / 8, ((b.y + 2) / 8 - 1) + 1)

		if fget(tile, 5) and fget(tile, 6) then
			blcok_shot = true
			tile_x = b.x
			tile_y = b.y

			mset(b.x / 8, (b.y / 8) - 1 + 1, 0)
		end
	end

	if shoot_timer < 40 then
		shoot_timer += 1
	end
end

function dbullets()
	for b in all(buls) do
		spr(b.sprite, b.x, b.y)
	end
end

function shoot()
	if shoot_timer > 35 then
		if player.fx == true then
			add(buls, {
				x = player.x,
				y = player.y,
				start_x = player.x,
				spd = -1,
				sprite = 25,
				sprite_start = 25,
				sprite_end = 30,
			})
		else
			add(buls, {
				x = player.x,
				y = player.y,
				start_x = player.x,
				spd = 1,
				sprite = 25,
				sprite_start = 25,
				sprite_end = 30,
			})
		end

		shoot_timer = 0
		shot = true
		player.sp = 53
		sfx(4)
	end
end
