--- move ---

function move(o)

-- local vars -- 

local lx =o.x -- last x
local ly = o.y -- last y 

-- x movement -- 
	if btn(➡️) then 
		player.x+=player.speed
		player.fx=false
		player.fy=false
		player_animation()
	end 
	
		if btn(⬅️) then 
		player.x-=player.speed
		player.fx=true
		player.fy=false
		player_animation()
	end 
	
-- y movement -- 
	if btn(🅾️) then
	
	jump()  
		
	end 
	if jforce > 0 then 
			jforce = jforce *0.6			 
	end 
	
	
	player.y -= jforce

if ground == false then
player.sp=2

end 

	function jump()
	if ground == true then 
		jforce =25
		player.fy=false
		sfx(0)
		end 
	end

	if btn(⬇️) then 
		player.y+=player.speed
		player.sp=2
		player.fy=true
	end 
	
	if btn (⬆️) or btn(❎) then
		shoot()
	
	end


	-- if colides -- 
	if colide(o) then 
		o.x = lx 
		o.y = ly 
	end 



end 

	function colide(o)
		local x1 = o.x/8
		local y1 = o.y/8
		local x2 =(o.x+7)/8
		local y2 = (o.y+7)/8

		local A= fget(mget(x1,y1),0)
		local B =fget(mget(x1,y2),0)
		local C =fget(mget(x2,y1),0)
		local D = fget(mget(x2,y2),0)

		if A or B or C or D then 
			return true 
		else 
			return false 
	end 
	
end 

-- gravitiy and tiles -- 
function gravity(o)
    -- Get the tile below the object's position
    local tile = mget((o.x+3) / 8, (o.y / 8) + 1)
   
	
	if fget(tile, 1) then
		ground = true 
	end 

	if fget(tile,2) then
			if damage_timer >= 10 then
		health -= 30
		damage_timer = 0
		sfx(1)
		player.sp = 10
		else 
			damage_timer += 1 
			player.sp = 10
		end

	
end

		
	if fget(tile,5) then 
		jump()
	end 




if fget(tile,3 ) then
		player.speed = 5
		player.speed_timer = 10
	end 
	 if player.speed_timer > 0 then
        player.speed_timer -= 1
        if player.speed_timer <= 0 then
            player.speed = player.default_speed  -- reset to normal speed
			sfx(2)
        end
    end 
    -- Check if the tile has flag 1 set
    if not fget(tile, 1) then
        -- Move the object down by 1 pixel
        o.y += 1
		ground = false 
    end
    
    
 		
	 	if fget(tile,6) then 
		health = 0
	end 
					
end





