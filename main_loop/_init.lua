-- init --
function _init()
	iplr()
	i_checkpoint()
	ipickups()
	iparticles()
	pause_timer_start = 0
	pause_timer_end = 10
	dead = false
	damage_timer = 10
	state = "Pause"
	init_health()
	jforce = 1 -- should 1 instead 0 becasue of gravitiy
	cx = 0
	cy = 0
	ibullets()
	enemies_init()

	pal({ [0] = 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143 }, 1)
	init_text_trigger()
end
