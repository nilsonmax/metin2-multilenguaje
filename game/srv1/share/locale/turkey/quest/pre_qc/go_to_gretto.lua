quest go_to_gretto begin
	state start begin
		when login or levelup with pc.level >0 begin
			set_state(zone_enter)
		end
	end
		
	state zone_enter begin
		when 20093.chat."Giri� izni iste" begin
			if pc.level < 75 then
				say_title("Koe-Pung:")
				say("")
				---                                                   l
				say("75. seviyenin alt�nda oldugun i�in")
				say("seni buz zindan�na ���nlayamam..")
				return
			end
			say_title("Koe-Pung:")
			say("Dur! Ben Ejderha Mezhebinden Koe-Pung,")
			say("bu kap�n�n bek�isiyim. Sadece mezhebin")
			say("iznini al�rsan ge�ebilirsin!")
			wait()
			say_title(""..mob_name(20093).."")
			say("Ejderha Tanr� seni se�ti.")
			say("O her zaman seni izliyor olmal�!")	
			wait()
			pc.warp(10000, 1213200)
		end
	end

end

