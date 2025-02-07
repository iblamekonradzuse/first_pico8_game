function _update()
	-- player movement --
	uplr()
	-- player health --
	update_health()
	upickups()
	uparticles()
	ubullets()
	update_text_trigger()
	u_checkpoint()
	respawn_checkpoint()
	enemies_update()
end
