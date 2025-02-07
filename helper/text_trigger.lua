-- text initiators by cords? --

function init_text_trigger()
	texts = {}

	--demo color tables
	c_tables = {
		--light to dark
		{ 7, 11, 3 },
		{ 7, 14, 8 },
		{ 14, 8, 2 },
		{ 7, 12, 13 },
		{ 10, 9, 4 },
		{ 7, 6, 5 },
		--dark to light
		{ 3, 11, 7 },
		{ 8, 14, 7 },
		{ 2, 8, 14 },
		{ 13, 12, 7 },
		{ 4, 9, 10 },
		{ 5, 6, 7 },
	}

	text1_created = false
	text2_created = false
	text3_created = false
	text4_created = false
	text5_created = false
	text6_created = false
	text7_created = false
	text8_created = false
	text9_created = true
end

function update_text_trigger()
	if abs(player.x - 60) < 100 then
		if text1_created == false then
			text1_print = true
		end
	end

	if abs(player.x - 150) < 15 then
		if text2_created == false then
			text2_print = true
		end
	end

	if abs(player.x - 250) < 15 then
		if text3_created == false then
			text3_print = true
		end
	end

	if abs(player.x - 350) < 2 then
		if text4_created == false then
			text4_print = true
		end
	end

	if abs(player.x - 590) < 5 then
		if text4_created == false then
			text5_print = true
		end
	end

	if abs(player.x - 906) < 5 then
		if text4_created == false then
			text6_print = true
		end
	end

	if abs(player.x - 694) < 5 then
		if text4_created == false then
			text7_print = true
		end
	end

	if abs(player.x - 363) < 5 then
		if text4_created == false then
			text8_print = true
		end
	end
end

function draw_text_trigger()
	if text1_print == true then
		print("use ⬅️ and ➡️ to move", 60, 50, 5)
	end

	if text2_print == true then
		print("🅾️ or z to jump", 150, 60, 5)
	end

	if text3_print == true then
		print("be careful!", 220, 30, 8)
	end

	if text4_print == true then
		print("oh that..", 350, 20, 8)
		print("dont look good", 350, 30, 8)
	end

	if text5_print == true then
		print("this will give you ", 590, 5, 8)
		print("speed boost ", 600, 13, 8)
	end

	if text6_print == true then
		print("you can shoot fireballs ", 870, 250, 8)
		print("by pressing ⬆️ or ❎ ", 885, 260, 8)
	end

	if text7_print == true then
		print("smoke em! ", 680, 155, 8)
	end

	if text8_print == true then
		print("this banner means ", 363, 80, 6)
		print("checkpoint saved ", 363, 90, 6)
	end

	if player.x > 480 and player.y > 100 then
		print("you can shoot monsters too!", 440, 120)
	end

	if abs(player.x - 50) < 15 and abs(player.y - 160) < 20 then
		print("thanks for playing!", 8, 130, 6)
		print("-the end-", 26, 140, 6)
	end
end
