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


