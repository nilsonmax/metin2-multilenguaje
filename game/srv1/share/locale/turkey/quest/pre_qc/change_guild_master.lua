quest change_guild_master begin
	state start begin
		function change_master( name , level_limit , time_resign_limit , time_be_other_leader , time_be_other_member , iscacheitem )
			local ret = guild.change_master_with_limit( name , level_limit , time_resign_limit , time_be_other_leader , time_be_other_member, iscacheitem)
			local result = false

			if ret == 0 then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("Yanl�� isim girdin.")
				say("")
			elseif ret == 1 then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("Bu e�yay� sadece lonca liderleri kullanabilir.")
				say("")
			elseif ret == 2 then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("B�yle bir lonca �yesi yok.")
				say("")
			elseif ret == 3 then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("Lonca lideri ba�ar�yla de�i�tirildi.")
				say("")
				result = true
			elseif ret == 4 then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("Bir loncada de�ilsin.")
				say("")
			elseif ret == 5 then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("Bu oyuncu online de�il.")
				say("")
			elseif ret == 6 then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("Bu oyuncu lonca lideri olmak i�in yeterince")
				say("g��l� de�il.")
			elseif ret == 7 then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("Bu oyuncu lonca lideri olmak i�in �ok")
				say("tecr�besiz.")
			end

			return result
		end
		
		
		when 71099.use begin
			if pc.is_guild_master() == false then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("Bu e�yay� sadece lonca liderleri kullanabilir.")
				say("")
				return
			end
			
			say_title("Yer De�i�tirme Y�z��� ")
			say("")
			say("Oyuncunun ad�n� yaz.")
			say("")

			local s = input()

			if s == pc.name then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("Kendi ad�n� yazamazs�n.")
				say("")
				return
			elseif s == "" then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("Bo� b�rakamazs�n.")
				say("")
				return
			end

			if not pc.is_near_vid( find_pc_by_name( s ) , 10 ) then
				say_title("Yer De�i�tirme Y�z��� ")
				say("")
				say("Oyuncu yak�nlar�nda olmal�.")
				say("")
				return
			end

			if change_guild_master.change_master( s , 40 , 0 , 0 , 0 ,true) == true then
				pc.remove_item(71099)
			elseif ret == 5 then
			elseif ret == 6 then
				say_title("")
				say("")
				say("Oyuncunun seviyesi �ok d���k.")
			end

			end

		end
end

