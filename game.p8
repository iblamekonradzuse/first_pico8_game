pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
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


pal( {[0]=128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143}, 1 )	
init_text_trigger()
	
end 

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



function game_over()
if dead == true then 
	spr(67,54,63)
	spr(68,62,63)
	spr(69,70,63)

	spr(71,50,70)
	spr(72,58,70)
	spr(73,66,70)
	spr(71,74,70)
	end 

	
end 


function _draw()
	cls(0)	
	map()
draw_text_trigger()

	dplr()
	draw_health()
	game_over()
	dpickups()
	dcam()
	dparticles()
dbullets()
enemies_draw()
end





-->8


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
	if health >90 then 
		rectfill(cx+5,cy+9,cx+0.38*health,cy+13,8)
	elseif health <= 90 and health > 65 then 
		rectfill(cx+5,cy+9,cx+0.38*health,cy+13,9)
	elseif health <= 65 and health > 45 then 
		rectfill(cx+5,cy+9,cx+0.38*health,cy+13,8)

	else rectfill(6,6,6,6,1)
		dead = true 
 
	end  
	
	
spr(128,cx+4,cy+8)
spr(129,cx+12,cy+8)
spr(130,cx+20,cy+8)
spr(131,cx+28,cy+8)
spr(132,cx+36,cy+8)
end

-->8
--- player -- 

function iplr()

	player={
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
	fx=false,
	fy=false,
	sp_start=4,
	sp_end=7,
	speed=1,
	default_speed = 1,
	sp=4,
	s_timer = 9,
	jump_height = 50,
	animation_speed = 10,
	speed_timer = 0

	}




end 



-- player update --
function uplr()

gravity(player)
move(player)






end


function dplr()
	spr(player.sp,player.x,player.y,1,1,player.fx,player.fy)
end 

function player_animation()

		if player.s_timer > player.animation_speed then 
			if player.sp < player.sp_end then 
				player.sp += 1
			else 
				player.sp = player.sp_start
			player.s_timer = 0
			end
		else player.s_timer +=1
		end 
end 

-->8
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




-->8
-- pickup -- 

function ipickups()
    pickups = {}
    add(pickups, {
        x = 485,
        y = 38,
        act = true
    })
     add(pickups, {
        x = 1000,
        y = 88,
        act = true
    })
     add(pickups, {
        x = 978,
        y = 278,
        act = true
    })
     add(pickups, {
        x = 328,
        y = 143,
        act = true
    })
     add(pickups, {
        x = 891,
        y = 47,
        act = true
    })
end

function upickups()
    for pu in all(pickups) do
        if pu.act then 
            if abs(player.x-pu.x)<=4 and abs(player.y - pu.y)<=4 then 
                pu.act = false 
                health = 100
                sfx(3)
            end 	
        end
        
        if health <30 then
        pu.act = true
        end 
    end
end 

function dpickups()
    for pu in all(pickups) do
        if pu.act then 
            spr(24,pu.x,pu.y)
        end
    end
end
-->8

function dcam()
if player.y > 200 then
cy = 220

elseif player.y >100 then
cy= 100
elseif player.y>150 then 
cy = 170
else 
cy=-17
end 
cx = player.x-63
camera(cx,cy)

end 
-->8
-- particles -- 

function iparticles()

parts={

}




end


function uparticles()

if btnp(🅾️) then
	if ground == true then
		for i =1,5 do 
			add(parts,{
			purpose="jump",
			x=rnd(5)+3+player.x,
			y=player.y+9,
			sx=rnd(2)-1,
			sy=rnd(1),
			c=rnd(3) ,
			l = 20
			})
			end 
	
		end 
	end 

if player.sp == 10 then
	for i = 1,5 do 
		add(parts,{
				purpose = "damage",
				x = rnd(5)+player.x, 
				y = rnd(5)+player.y,
				c = 9, 
				l = 5 

		})
	end 
end 


for p in all(parts) do 
	if p.purpose == "jump" then
		p.y = player.y+8-rnd(10)+10
		p.l -= 1 
		p.x =rnd(5)+2+player.x

		

		if ground == true then
		p.l = 10
		end
	end 

	if p.purpose == "damage" then
		p.y = rnd(8)+player.y
		p.l -= 1
		p.x = rnd(8)+player.x
		p.l -= 1 
		p.c = rnd(3)+7
	end 
	if p.l <0 then

		del(parts,p)
		end



end

-- not rendering when off screen
-- t0do 

end





function dparticles()

 for p in all(parts) do
	circfill(p.x,p.y,1,p.c)
	end 


	

end

-->8
-- bullets -- 

function ibullets()

buls={ 

}
shoot_timer = 21
end 


function ubullets()

for b in all(buls) do 

b.x += b.spd

if abs(b.x-b.start_x)>45 then
del(buls,b) 
end



if b.sprite <b.sprite_end then
b.sprite +=1

else 

b.sprite = b.sprite_start

end 

 local tile = mget((b.x) / 8, ((b.y+2) / 8-1) + 1)

if fget(tile,5) and fget(tile,6) then

blcok_shot = true 
tile_x = b.x
tile_y = b.y 

mset((b.x) / 8, (b.y / 8)-1 + 1, 0)


end


end


if shoot_timer <40 then
shoot_timer +=1

end

end 



function dbullets()

for b in all(buls) do 

spr(b.sprite,b.x,b.y)

end




end 


function shoot()





if shoot_timer >35 then
if player.fx == true then 
add(buls,{
x = player.x,
y = player.y,
start_x = player.x,
spd =-1,
sprite = 25,
sprite_start = 25,
sprite_end = 30
})
else 
add(buls,{
x = player.x,
y = player.y,
start_x = player.x,
spd =1,
sprite = 25,
sprite_start = 25,
sprite_end = 30
})
end 


shoot_timer = 0 
shot = true 
	player.sp =53
	sfx(4)
end 



end 
-->8
-- enemey --
-->8
-- text initiators by cords? -- 

function init_text_trigger()

texts={}

	--demo color tables
	c_tables={
		--light to dark
		{7,11,3},
		{7,14,8},
		{14,8,2},
		{7,12,13},
		{10,9,4},
		{7,6,5},
		--dark to light
		{3,11,7},
		{8,14,7},
		{2,8,14},
		{13,12,7},
		{4,9,10},
		{5,6,7},
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
print("use ⬅️ and ➡️ to move",60,50,5)

end 

if text2_print == true then
print("🅾️ or z to jump",150,60,5)

end

if text3_print == true then
print("be careful!",220,30,8)
end

if text4_print == true then
print("oh that..",350,20,8)
print("dont look good",350,30,8)
end 

if text5_print == true then
print("this will give you ",590,5,8)
print("speed boost ",600,13,8)
end

if text6_print == true then
print("you can shoot fireballs ",870,250,8)
print("by pressing ⬆️ or ❎ ",885,260,8)


end

if text7_print == true then
print("smoke em! ",680,155,8)


end

if text8_print == true then
print("this banner means ",363,80,6)
print("checkpoint saved ",363,90,6)



end

if player.x > 480 and player.y>100 then
print("you can shoot monsters too!",440,120)

end

if  abs(player.x -50) <15 and abs(player.y-160) < 20 then
print("thanks for playing!",8,130,6)
print("-the end-",26,140,6)

end 

end
-->8
function i_checkpoint()
checkpoint_x = player.x 
checkpoint_y = player.y
end 


function u_checkpoint()

checkpoint_tile = mget((player.x+3) / 8, (player.y / 8))


	if fget(checkpoint_tile,7) then 
			
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



-->8
function enemies_init()
    enemies = {}
    spawn_enemies()
end

function enemies_update()
    for e in all(enemies) do
        -- slow down movement by using smaller values
        if e.move_distance >= 30 then    -- reduced from 100
            e.direction = -0.5           -- reduced speed
        elseif e.move_distance <= 0 then
            e.direction = 0.5            -- reduced speed
        end
        
        e.move_distance += e.direction
        e.x = e.ex + e.move_distance
    end
end

function enemies_draw()

shot_enemies()
    for e in all(enemies) do
        spr(e.sp, e.x, e.ey)
        
        if abs(player.x-e.x)<5 and abs(player.y-e.ey)<5 then
        health -=2
        end 
    				
        
        if e.shot == true then
        del(enemies,e)
        end
    end
end

-- cool function start

function shot_enemies()

for b in all(buls) do 
for e in all(enemies) do 

if abs(b.x-e.x)<2 and abs(b.y-e.ey)<2 then
del(enemies,e)
end 

end
end 
end 

-- cool function end --

function spawn_enemies()
    local cx = player.x\8
    local cy = player.y\8
    
    for x = cx-20,cx+20 do
        for y = cy-30,cy+30 do
            if mget(x,y) == 44 then
                add(enemies,{
                    ex = x*8,
                    ey = y*8,
                    x = x*8,
                    sp = 34,
                    speed = 0.5,         -- reduced from 2
                    direction = 0.5,     -- start with slower speed
                    move_distance = 0,
                    shot = false,
                })
                mset(x,y,1)
            end
        end
    end
end
__gfx__
00000000000000000060000500660055006606050000660500066605000066050000000000000000008800220000000000000000000000000000000099999999
00000000000000000066665500666655006666550066665500666655006666550000000000000000008888220000000000000000000000000000000099999999
0000000000000000006665f500666555006665f5006665f5006665f5006665f50000000000000000008882220000000000000000000000000000000099999999
00000000000000000065cfc00066cfc00065cfc00065cfc00065cfc00065cfc000000000000000000088dfd00000000000000000000000000000000099999999
0000000000000000005ffff0006ffff0005ffff0005ffff0005ffff0005ffff00000000000000000008ffff00000000000000000000000000000000099999999
00000000000000000111151101111511001115500111155001111500001115500000000000000000011115110000000000000000000000000000000099999999
00000000000000000001150000011500010115050001150000011500010115000000000000000000000115000000000000000000000000000000000099999999
00000000000000000001050000010500000105000001005000100100000105000000000000000000000105000000000000000000000000000000000099999999
0000000000000000cd0dd0dc00000000000000000000000000000000222020220220022000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000022882288200000000000000000000000000000000000000000000000000000000
0000000000000000cd0000dc000000000000000000000000000000002020200288888888000088000008890000889a0008899a0008899a0008899a0000000000
0000000000000000000dd00000000000000000000000000000000000200022028888888800899998089999a808999aa8899aaaa8899aaaa8899aaaa800000000
0000000000000000000000000000000000000000000000000000000020200002888888888899aaa98999aaa9899aaaa999aaaaa999aaaaa999aaaaa900000000
0000000000000000c220022c00000000000000000000000000000000000022022888888200899998089999a808999aa8899aaaa8899aaaa8899aaaa800000000
000000000000000020000002000000000000000000000000000000002020000002888820000088000008890000889a0008899a0008899a0008899a0000000000
00000000000000002000000200000000000000000000000000000000202220220028820000000000000000000000000000000000000000000000000000000000
000000000000000077800877000000000000000000000000000000009999999900000000999999990000000000000000cccccccc000000000000000099999999
000000000000000077800877000000000000000000000000000000009999999900000000999999990000000000000000cccccccc000000000000000099999999
000000000000000077777777000000000000000000000000000000009999999900000000999999990000000000000000cccccccc000000000000000099999999
000000000000000070777707000000000000000000000000000000009999999900000000999999990000000000000000cccccccc000000000000000099999999
000000000000000077777777000000000000000000000000000000009999999900000000999999990000000000000000cccccccc000000000000000099999999
000000000000000077888877000000000000000000000000000000009999999900000000999999990000000000000000cccccccc000000000000000099999999
000000000000000000888800000000000000000000000000000000009999999900000000999999990000000000000000cccccccc000000000000000099999999
000000000000000000888800000000000000000000000000000000009999999900000000999999990000000000000000cccccccc000000000000000099999999
00000000000000000000000000000000000000000080990800000000000000009999999900000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000088999800000000000000009999999900000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000009995f900000000000000009999999900000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000958f8000000000000000009999999900000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000005ffff000000000000000009999999900000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000011155000000000000000009999999900000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000101150900000000000000009999999900000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000001050000000000000000009999999900000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000033b3000000000000000000000000000000000033b3333333333333000000003333333300000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0b0b030303030b0000000003030303000000000
0000000000000000000000000000000000000000000000000333bb3000000000000000000000000000000000303030b0b030b00000000000303030b000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b030b030b0b0300000000000b030b00000000000
0000000000000000000000000000000000000000000000303333bbb30b000000000000000000000000000000b030b03030b0000000000000b030000000000000
000000000000000000000e00000e000000000000000000000000000000000000000000000000000000000000b030303030b0000000000000b000000000000000
00000000000000000e000e0008ee0e8008e000e000000330333bbbbb0b300000000000000000000000000000b0b0303030000000000000000000000000000000
00000000000000008e000880080000e08e0000e800000000000000000000000000000000000000000000000030b0303030000000000000000000000000000000
0000000088888888888888888888888888888888000000003044990300000000000000000000000000000000303030b000006500000000003333033000000000
0000000080808080808080800808008008008000000000000004900000000000000000000000000000000000b03030b000066000000000000000000000000000
00000000008080808000000000080080000000800000000000049000000000000000e0000000000000000000b030303000000000000000000000000000000000
00000000808080008080808008000000080000000000000000049000000000000e00b000000000000000000030b0303000650000000000000000000000000000
00000000800080800080000000080080000000000000000000049000000000000b00b0e0000000000000000030b0303000600000000000000000000000000000
0000000000808080808080000000000000000000000000000004900000000300030030b000000000000300003030303000050000000000000000000000000000
0000000080800080800000800000008000000000000000000004000000000b03030030b000000000030b00003030b03000600000000000000000000000000000
00000000808080808080000000000000000000000000000000449000003b0b0303003030000000000b0b03b03030303000005000000000000000000000000000
0000000080808080000000000000000000000000000000003333333333333333333333333b33333b3333333330b0303000000000c0c0cc0cc0c0c0c000ccc0c0
0000000080800080808008000000000000000000000000000040900000000000030b030b0b0b030b0300300330b0303000060000c0009000c0c00c0c000c0c00
000000008000808000000000000000000000000000000000044049000000000000030b0b030b0b030000003030b0300000600000c090c0c0c090090c090c0c0c
000000008080800000800000000000000000000000000000000009000000000000000b0303030b03030000003030000000000000909000909000000909000c0c
0000000000800080000000000000000000000000000000000040040000000000000000030b03030b00000000303000000000000000c0c090000000000c090c0c
0000000080808000000080000000000000000000000000000040090000000000000000030b03030b00000000300000000600000090c0c00000000000000c0009
000000008000008000000000000000000000000000000000000000000000000000000000030b0303000000003000000006600000c0c000000000000000000909
000000008080000000000000000000000000000000000000000009000000000000000000030b0303000000003000000000665000900000000000000000000009
888888880000000000000000222020228888888888888888888888880000000000000000000b0303000000000000000000000000000000000000000000000000
80000000000000000000000000000002808080800808008080808080000000000000000000030303000000000000000000066000000000000000000000000000
88888080000000000000000020202002800000000008008000808080000000000000000000030b0b000000000000000000000050000000000000000000000000
80000000000000000000000020002202808080800800000080808000000000000000000000000b03000000000000000000000650000000000000000000000000
88880800000000000000000020200002008000000008008080008080000000000000000000000303000000000000000000000650000000000000000000000000
80000000000000000000000000002202808080000000000000808080000000000000000000000003000000000000000000000050000000000000000000000000
8880800000000000000000002020000080000080000000808080008000000000000000000000000b000000000000000000000000000000000000000000000000
8000000000000000000000002022202280800000000000008080808000000000000000000000000b000000000000000000066600000000000000000000000000
02200220222022002220020002220022200000000000000000000000000000000000000000000000000000000000000000005500000000000000000000000000
28822882222222222222222222222222220000000000000000000000f1f1000404f1f104047121710000007100000000002171000000000000808e00828282c6
88888888222022002202220022002222220000000000000000000000000000000000000000000000000000000000000006600000000000000000000000000000
8888888822000000000000000000000002000000000000000000000000f1f1000404f1f1040000710000007171000000000071000000000000809082828282c7
88888888220002202200002200000000020000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000
28888882222222222222222222002200220000000000000000000000000000f1000404f1f10000710021000071000000000000002100000000718282828282c5
02888822202222022220222022222222220000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000
0028820000002200002002202222002220000000000000000000000000000000f1f10004f1f100000000000000000000000000000000004480717585a50085c7
02200220000000000000000000000000000000000000000002200220000000000000000000000000000000000000000000000000000000000000000000000000
28822882000000000000000000000000000000000000000000000000000000f1f1f1000000f1f1f1f1f1f1f1f1f1f1f1f1f1f1000000002180808696a61ca6c4
88888888000000000000000000000000000000000000000288888888222000000000000000000000002000000000000000000000000000000000000000000000
888888880000000000000000000000000000000000000000000000000000000000f1f1000000f1f100000000040000040404f1f1f1f1f10080803197511d04f1
888888880000000000000000000000000000000000000002888888882200000000000000000000002ee000000000000000000000000000000000000000000000
2888888200000000000000000000000000000000000000000000000000000000000000f1f10000000000000000000004040404040400f1f1000031f1f1f1f1f1
02888820000000000000000000000000000000000000000002888820000000000000000000000000000000000000000000000000000000000000000000000000
00288200000000000000000000000000000000000000000000000000000000000000000000f1f100000000000000000000000404040000f1f1f1f1f15151f1f1
00022000000000000000000000000000000000000000000000022000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f100000000000000000000f1f1f1315131515131
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000f10000f1f1f1f1f1f1f1f1f1f1f10000513151315131
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000313151313131
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000313151515131
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000069000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000315151315131
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000315131315151
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008d0000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008e0000000000
0002800033333333333333330003000000000000000000000dd00dd0000000000066605600000000000055500000000000000000000000000000000099999999
0022800000bb3000000030000033000000000000000000005dddddd5000000000656506600000000055555500000000000000000000000000000000099999999
028880000b333000000330000030000000000000000000000d0000d0000000006655600600000000055500000000000000000000000000000000000099999999
000820000003b000000300000000000000000000000000000d0000d0000000006556000000000000000055550000000000000000000000000000000099999999
000822000003bb00000000000000000000000000000000000d0000d0000000005560000000000000000055550000000000000000000000000000000099999999
0028020000b30b000000000000000000000000000000000005000050000000000000665600000000055550000000000000000000000000000000000099999999
0028000000b30000000000000000000000000000000000000d0000d0000000006006656500000000055555500000000000000000000000000000000099999999
00080000000300000000000000000000000000000000000005000050000000005605665000000000000555500000000000000000000000000000000099999999
00020000000300000000000088808088888888880000000044400444000000003333333322000022006666000000000000666056000000000000000000000000
00220000003300000000000000000008888888880000000044499444000000000449944004499440044994400000000006565066000000000000000000000000
002000000030000000000000808080088888888800000000049dd94000000000049dd940049dd940049dd9400000000066556006000000000000000000000000
00000000000000000000000080008808888888880000000009dddd900000000009dddd9009dddd9009dddd900000000065560000000000000000000000000000
0000000000000000000000008080000888888888000000000dd55dd0000000000dd55dd00dd55dd00dd55dd00000000055600000000000000000000000000000
00000000000000000000000000008808888888880000000009d55d900000000009d55d9009d55d9009d55d900000000000006656000000000000000000000000
00000000000000000000000080800000888888880000000009999990000000000999999009999990099999900000000060066565000000000000000000000000
00000000000000000000000080888088888888880000000009666690000000000966669009666690096666900000000056056650000000000000000000000000
000c100000000000000000005550505500000000000000000d6826d0000000000d6826d000000000000000000000000000000000000000000000000000000000
00cc100000000000000000000000000500000000000000000d6226d0000000000d6226d000000000000000000000000000000000000000000000000000000000
0c11100000000000000000005050500500000000000000000dd66dd0000000000dd66dd000000000000000000000000000000000000000000000000000000000
0001c00000000000000000005000550500000000000000000dd66dd0000000000dd66dd000000000000000000000000000000000000000000000000000000000
0001cc0000000000000000005050000500000000000000000dd66dd0000000000dd66dd000000000000000000000000000000000000000000000000000000000
00c10c0000000000000000000000550500000000000000000dd66dd0000000000dd66dd000000000000000000000000000000000000000000000000000000000
00c10000000000000000000050500000000000000000000000d66d000000000000d66d0000000000000000000000000000000000000000000000000000000000
00010000000000000000000050555055000000000000000000066000000000000006600000000000000000000000000000000000000000000000000000000000
000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggiiggiigiiigiiggiiiggigggiiiggiiiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggiooiiooiiiiiiiiiiiiiiiiiiiiiiiiiiigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggooooooooiiioiiooiioiiiooiiooiiiiiigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggooooooooiioooooooooooooooooooooooigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggooooooooiioooiioiiooooiioooooooooigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggiooooooiiiiiiiiiiiiiiiiiiiooiiooiigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggiooooiiigiiiigiiiigiiigiiiiiiiiiigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggggiooiggggggiiggggiggiigiiiiggiiiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gigiiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
giggiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
giigiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
giigiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
iigiiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gigiiiiigigiiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggiiigigiiiiigigiiggggggggggg
ggggigggggggigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigggggggiggggggggggg
giggiigigiggiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigigiggiigigiggiggggggggggg
giigiigggiigiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigggiigiigggiigiggggggggggg
ggggiigiggggiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigiggggiigiggggiggggggggggg
giigiggggiigiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggiigiggggiigiggggggggggg
gggggigigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigigggggigigggggggggggggggg
iigiiigiiigiiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigiiigiiigiiigiiggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggiiigigiiiiigigiiiiigigiiiiigigiiggg
ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigggggggigggggggigggggggiggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigigiggiigigiggiigigiggiigigiggiggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigggiigiigggiigiigggiigiigggiigiggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigiggggiigiggggiigiggggiigiggggiggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggiigiggggiigiggggiigiggggiigiggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigigggggigigggggigigggggigigggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggigiiigiiigiiigiiigiiigiiigiiigiiggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
uggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
uguoggougggugggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggugougggguoggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gsgsgggsssgsgggggggggggggggggggggggggiiigigiiiiigigiiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggsgsgggsgsgggggggggggggggggggggggggggggggggigggggggiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggpgsgpgsgsgsggggggggggggggggggggggggigigiggiigigiggiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggpgpgggsgsggggggggggggggggggggggggigggiigiigggiigiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggggsgpgsgsggggggggggggggggggggggggigiggggiigiggggiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggggggsgggpggggggggggggggggggggggggggggiigiggggiigiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggggggggpgpggggggggggggggggggggggggigigggggigigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
ggggggggggggpggggggggggggggggggggggggigiiigiiigiiigiiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggiiigigiiiiigigiiiiigigiiiiigigiiggggggggggggggggggjjrjggggggggggggggggggggggggggggggggggggggggggggg
ggggggggggggggggggggggggggggggggggggigggggggigggggggigggggggiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggigigiggiigigiggiigigiggiigigiggigggggggggggggggggjjjrrjgggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggigggiigiigggiigiigggiigiigggiigiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggigiggggiigiggggiigiggggiigiggggiggggggggggggggjgjjjjrrrjgrggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggiigiggggiigiggggiigiggggiigiggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggigigggggigigggggigigggggigiggggggggggggggggggjjgjjjrrrrrgrjgggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggigiiigiiigiiigiiigiiigiiigiiigiiggggggggggggggggggggggggggggggggggggggggggggggggggggiiggiiggggggggg
ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggglgmgmmggggggggjgkkppgjgggggggggggggggggggggggggggiooiiooigggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggllmmmmgggggggggggkpggggggggggggggggggggggggggggggoooooooogggggggg
ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggglvlmmmgggguggggggkpggggggggggggggggggggggguggggggoooooooogggggggg
ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggsvslmguggrggggggkpgggggggggggggggggggguggrggggggoooooooogggggggg
ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggvvvvlgrggrguggggkpggggggggggggggggggggrggrguggggiooooooigggggggg
ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggllhhhgjggjgrggggkpggggggggggggggggggggjggjgrggggjiooooigjggggggg
ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggglglhhjhjggjgrggggkgggggggggggggggggggggjggjgrggjgrgiooijgrggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjrlrhjgjggjgjgggkkpggggggggggggggggggggjggjgjggrgrgjrggrgrgjrgggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjjrjjjjjjjjjjjjjjjjjjjjjggggggggggggggggjjjjjjjjjjjjjjjjjjjjjjjjsgs
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggrgrgrgjgjgjgjgrgggkgpggggggggggggggggggggjggjggjjgjgjgrgggrrjgggsgs
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjgjgjgrgrgjgrggggkkgkpggggggggggggggggggggggggjgrgjgrggggrjjjgggsgp
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggrgjgrgjgrgrgjggggggggpgggggggggggggggggggjggggggrgrgjggggggjrgggpgg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggrgjgrgjgjgrgggggggkggkggggggggggggggggggggggggggjgrggggggggjrrggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggrgjgjgjgjgrgggggggkggpggggggggggggggggggggggggggjgrgggggggrjgrggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggrgrgjgjgjgggggggggggggggggggggggggggggggggggggggjgggggggggrjggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjgrgjgjgjggggggggggggpggggggggggggggggggggggggggjggggggggggjggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjgrgjgjggggggggggggggggggggggggggggggggggggggggggggggggggggjggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjgrgjgjgggggggggggggggggggggggggggggggggggggggggggggggggggjjggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjgrgjgggggggggggggggggggggggggggggggggggggggggggggggggggggjgggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjgjgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjgjgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggjgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg

__gff__
000000000000000000000000000000000000230000000004000000000000006000000000000000008000000000000000000000000000000000000000000000000000000000000000000000030300030000070707070000000000000003000000000303000000030303030303030b0b0b07000004474747000303000003000000
0000030000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030300000000000000000000000080000300600000000003000000000000000000000700000000000000000000000000000000000000000000000000000000
__map__
2626262626262626262626162626262616262626262626262626262626262626162626262626262616161616161616281616161616161616161616161616161640161616080808080808080808280808080008080808000000171700262626261717264026080808080808080808080000000000000000000000000000000000
262626262626262626262626262626262626262626262626262626262626262626262626262626261616161616161628161616161616161640161616161616401616161608080808080808080828080808000808400800001717171726262617171717004008080808080808080817170000000017170000280000000000001f
26261f262626262626262626262626262626262626262626262626262626402626262626262626261616161616161628161600000000000008080808080808400808080808080808080808080828080808000808080800000000002626262626262626402608404000000040401717171700001717171700280000000000001f
26001f0000000000000000000000000028000000400000000000000000004000000000000000000000000000000000280000000000000000080808080808084008080808084344085758080808282843440008080808000057585a262626575a42434440000000000000000040081600160000000000c600280000000000001f
26001f00000000000000000000000000280000004000000000000000000040000000000000000000000000000000002800000000004546470808080808080840080808120851536a68694040406d6e6e6f120808080000164b4c686926264b4c6e6e6f40000017170000004040401616160000000000d616281616161717161f
26001f000000000000d7d7d7d7d7d700280000004000000000000000000040000000000000000057585a00000057582800420043575856000808425758080840080808d008614040407940404040404040d90808000008265b40407926266b4040404040401717171700454647080800000000000000e616281616171717171f
26001f0000714040d7d700d7d7d7d70028000000400000004000000000004000000000000012004b4cc16800004cd868005152534c67664c5253546a686940400812080808404040404040404040404040e80808000808266b264026262640404040404040000000005758560808585a5a00430000004342280000000000161f
26001f000040404040d7d7d7d7d7d700280000004000004000000000005758000000001200d0005b40d140000840e8400861624040404040624040404079404008c00808084040404040404040404040400808080808082626262626262626404040264000000000004b4c6608086a4cc16e6f0000006d6e6f0000000017171f
26001f004040404040d7d7d7d7d7d740281600004000004546470000004b4c00001200c00000006b4040400008400840086240404040404040400008c540401f1fd01f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f4040260026000000006b400808084040d140400000004040404000000000161f
26001f00404040636445464740404040284040404040575756405740005b4d00000000d00000004040401f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f4040404008404040404040404040c540401f08080808082626262626262626261f1f2626260800000808080808080840404040000000400040405c170000175c
01001f0000004057584056585740574028575840404b4c6766686976766b40001f1f1f1f1f1f1f1f1f1f000008080808080808004040404008080808081f080808080808084040404040404040400808081f1f08080808262626262626262626261f1f1f260808080808080808080800404040000000400000006c000000006c
26001f0000004b4c6ac166c2676ac1c26a686974756b784000407961624040001f000000000000000000000008080808080808084040080808080808080808080808080808084008084008084008080808081f080808082626262626262626262626261f1f1f1f1f1f1f1f1f1f1f1f00404040000000000000087c001700177c
00001f0016406b4040d140404040d140404079404040160000404040404040401f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f08080808262626262626262626262626261f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f5c000040407c
00001f1640404040404040404040404040404040161616001f1f1f1f1f1f1f1f1f000000000000000000000008080808080808080808080808080808080808080808080808080808080808080808080808080808080808262626262626262626262626261f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f6c401717007c
00161f404040404040404040404040404040404016161600001f4040000000000000000000000000000000002c08170808080808081708080808c60840280808080808080808080808080808080808080808080808080808080808080808080808080808081f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f7c404040005c
001f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f40400000000000000000000000000028000008171708080808080817082c0808d60840280840400808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080800000000000000000000085c170800006c
1f1f00000000000000000000000000000000000000000000000000000000000000000000000000000028004040170808171708172cd308080808e60840280808400808084008400808080808080808080816161616161616160808080808080808080800000000000000000000000000000000000000000000086c080817177c
1fc600000000000028c6000000000000000000000000000000000000000000000000000000002c000028004040080808172c081708d308080843084240285a08080840404040400808080808080808080816161616002816160808080808080808080800000000000000000000000000000000000000080808087c080008087c
1fd600000000000028d60000000000000040000000002c000000171700000000002c000000000000002840400808081217081208081208080851525354686908084040407340400808080808080808080816161616162816160808080808080808080800000000000000000000000000000000000808080808085c170808085c
1fe600000045464728e600000000000000000000000000000017171717000000000000005152535468d854000808080808080808080808081261620808087940404008737373400808080808080808080816161616162816160808080808080808080800000000000000000000000000000000000808080808087c001708006c
1f00005a575856582800004040004300000000002c001700000000002c000000171700006162004040e80000080808080808080808080808081f1f1f1f1f0840404073737373734008420808080808080828161616162816160808080808080808080800000000000000000000000000000000000800080808087c404000177c
1f4b4c6ac16a666a6869000040486e4848480000481717484840401717404017171717000000004040000000120808081f1f1f1f1f080808081f0808081f40401273737373737373086e0808d30808080828161616162816160808080808080808080800000000000000000000000000000000080000000000086c174000005c
1f5b4000d10000000079000048484848480017174040004012401717174040171717170000000000000000000808081f1f0808081f1f081f1f080808081f1f40080808080808080808080808120840d308281645464728161608080808d3080808080800000000000000000000000000000000000000000000085c404017176c
1f1f1f1f40000000000000004040404012171717404040404017171717172c0043444342000000001f1f1f1f1f1f1f1f08080808081f1f1f0808080808081f1f1f1f1f1f1f1f1f1f080808080813404308285757565a58571608080817d3080808080800000000000000000000000000000000000000000000087c174000007c
1616161f1f1f1f1f1f1f1f1f1f16401717171717124040404040404040406d6e6e6e6e6e6f16161f1f161616161616161616080808080808080808080808080808080808080808081f1f080808131312134b4c6a66d86869160808121717080816000000000000000000000000000000000000000000000000087c004000007c
1616161616161616161f1f161f1f401717171740c04040404040404040401616161616161f1f1f1f1616161616161616161608080808080808080808080808080808080808080808081f1f0808080808085b161616e840791608081617171208160000d3000000000000000000000000000000000000000000085c081717085c
161616161616161616161616401f404040404040d0404848481f1f1f1f1f1f1f1f1f1f1f1f161616161616161616161616160808080808080808080808080808080808080808080808081f0808080808086b1616161640161608080808172121430000d300000000000000d300000000000000000000000000086c000817006c
161616161616161616161616401f1f1f16161640401f1f1f1f1f164016161616161616161616161616161616161616161616080808080808080808080808080808080808080808080808081f08080808081616161616161616080808081621211221001700d30000000000d300000000000000000000000000087c170000007c
1616161616161616161616164016161f1f1f1f1f1f1f16404040404016161616161616161616161616161616161616161616080808080808080808080808080808080808080808080808081f1f080808081f1f1f1f1f1f1f1f0808081f1f21212121121700d30000000000d300000000000000000000000000087c000000005c
161616161616161616161640404040404040404040404040404040401616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161f1f1f1f1f1f1616161616161f1f1f16161f1f1f2121001744170000000000d300004400000000000000000000085c000017177c
1616161616161616161616164040401640404040401616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616081f1f0840401f1f212117121700d30000000000001200000000000000000000086c001700006c
161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161600000000000000001f1f0040401f1f212121170017000017170000000000004000000000000008da161700175c
__sfx__
000100000000000000000000000000000000000000000000000000000000000000001b0501c0501e0501f050210502305026050280502a0500000000000000000000000000000000000000000000000000000000
001000000000002050020500205000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000c0500e0500e0501005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000f0500f0500f0500f0500e0500c0500e0500c0500e0500c0500e0500c0500c05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000345011450000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
