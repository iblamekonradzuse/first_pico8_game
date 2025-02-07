function i_checkpoint()
	checkpoint_x = player.x
	checkpoint_y = player.y
end

function u_checkpoint()
	checkpoint_tile = mget((player.x + 3) / 8, (player.y / 8))

	if fget(checkpoint_tile, 7) then
		checkpoint_x = player.x
		checkpoint_y = player.y
	end
end

function respawn_checkpoint()
	if health <= 20 then
		player.x = checkpoint_x
		player.y = checkpoint_y
		health = 100
	end
end
