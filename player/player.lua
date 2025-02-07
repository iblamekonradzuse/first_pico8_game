--- player --

function iplr()
	player = {
		-- start --
		x = 45,
		y = 80,
		-- sprite test --
		--	x=120,
		--	y=190,
		--checkpoint 1 --
		--x= 323,
		--y= 38,

		-- checkpoint 2(not really) --
		--x =615,
		--y=20,

		--checkpoint --

		--x = 955,
		--y = 30,

		-- checkpoint after tower --
		--x = 1000,
		--y = 280,

		-- checkpoint--

		--x =694,
		--y =185,

		-- zor yerler --
		--x =492,
		--y =135,

		--x = 327,
		--y = 130,

		--x =29,
		--y = 160,
		fx = false,
		fy = false,
		sp_start = 4,
		sp_end = 7,
		speed = 1,
		default_speed = 1,
		sp = 4,
		s_timer = 9,
		jump_height = 50,
		animation_speed = 10,
		speed_timer = 0,
	}
end

-- player update --
function uplr()
	gravity(player)
	move(player)
end

function dplr()
	spr(player.sp, player.x, player.y, 1, 1, player.fx, player.fy)
end

function player_animation()
	if player.s_timer > player.animation_speed then
		if player.sp < player.sp_end then
			player.sp += 1
		else
			player.sp = player.sp_start
			player.s_timer = 0
		end
	else
		player.s_timer += 1
	end
end

-->8
