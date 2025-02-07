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

