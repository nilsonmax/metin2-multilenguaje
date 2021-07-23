quest guild_building_melt begin
	state start begin
		function GetOreRefineCost(cost)
			if pc.empire != npc.empire then
				return 3 * cost
			end
			if pc.get_guild() == npc.get_guild() then
				return cost * 0.9
			end
			return cost
		end

		function GetOreRefineGoodPct()
			return 60
		end

		function GetOreRefineBadPct()
			return 30
		end

		function GetMyRefineNum(race)
			return({
				[20060] = 50601,
				[20061] = 50602,
				[20062] = 50603,
				[20063] = 50604,
				[20064] = 50605,
				[20065] = 50606,
				[20066] = 50607,
				[20067] = 50608,
				[20068] = 50609,
				[20069] = 50610,
				[20070] = 50611,
				[20071] = 50612,
				[20072] = 50613,
				[33009] = 50614,
				[33010] = 50615,
				[33011] = 50616,
				[33012] = 50617,
				[33013] = 50618
			})[race]
			--return race - 20060 + 50601 or race - 33009 + 50614
		end

		function IsRefinableRawOre(vnum)
			return vnum >= 50601 and vnum <= 50618
		end

		function DoRefineDiamond(pct)
			local from_name = item_name(item.vnum)
			local to_vnum = item.vnum + 20
			local to_name = item_name(to_vnum)

			say_title("Simyager:")
			say("")
            say("100 " .. from_name .. " toplaman laz�m ki ")
            say(to_name .. " �retimi yapabilesin.")
			say("")
			if item.count >= 100 then
                say("Ba�ar� ihtimalin "..pct.."%.")
				say(""..guild_building_melt.GetOreRefineCost(10000).." Yang gerekli.")
                say("Denemek istiyormusun?")
                local s = select("Evet", "Hay�r")
				if s == 1 then
					if pc.get_gold() < guild_building_melt.GetOreRefineCost(10000) then
						say_title("Simyager:")
						say("")
                        say("Yeterli Yang yok.")
						say("")
						return
					end

					if pc.diamond_refine(10000, pct) then
						say_title("Simyager:")
						say("")
                        say("Tebrikler! Cevherler ba�ar�yla i�lendi. �imdi senin:")
                        say_item(to_name, to_vnum, "")
						say("")
					else
						say_title("Simyager:")
						say("")
                        say("Cevher i�leme ba�ar�s�z oldu.")
						say("")
					end
				end
			else
                say("�nce 100 tane topla.")
			end
		end
		function DoRefine(pct)
			local from_postfix
			local from_name = item_name(item.vnum)
			local to_vnum = item.vnum + 20
			local to_name = item_name(to_vnum)
			local to_postfix

			if under_han(from_name) then
                from_postfix = ""
			else
                from_postfix = ""
			end

			if under_han(to_name) then
                from_postfix = ""
			else
                from_postfix = ""
			end
			say_title("Simyager:")
			say("")
			say(""..to_name.." �retebilmek i�in �nce 100 adet " .. from_name .." ")
			say("ve bir adet Metin Ta�� +0, +1 ,+2 gereklidir.")
			say("")
			if item.count >= 100 then
                say("Ba�ar� ihtimalin "..pct.."%."..guild_building_melt.GetOreRefineCost(3000).." Yang �demen gerekiyor.")
                say("Denemek istiyor musun?")
                local s = select("Evet", "Hay�r")
				if s == 1 then
					if pc.get_gold() < guild_building_melt.GetOreRefineCost(3000) then
						say_title("Simyager:")
						say("")
                        say("Yeterli Yang yok.")
						say("")
						return
					end

					local selected_item_cell = select_item()
					if selected_item_cell == 0 then
						say_title("Simyager:")
						say("")
                        say("Bana do�ru itemleri g�ster.")
						say("")
						return
					end
					local old_item = item.get_id()

					if not item.select_cell(selected_item_cell) then
						say_title("Simyager:")
						say("")
                        say("Bu istedi�imiz malzeme de�il.")
						say("")
						return
					end

					-- check whether the material is
					if item.vnum < 28000 or item.vnum >= 28300 then
						say_title("Simyager:")
						say("")
                        say("Bu do�ru madde de�il.")
						say("")
						return
					end

					item.select(old_item)

					if pc.ore_refine(3000, pct, selected_item_cell) then
						----"123456789012345678901234567890123456789012345678901234567890"|
						say_title("Simyager:")
						say("")
                        say("Tebrik ederim, islem tamamlandi.Sonu�:")
						say("")
                        say_item(to_name, to_vnum, "")
						say("")
						return
					else
						say_title("Simyager:")
						say("")
                        say("��lem ba�ar�l� olmad�.")
						say("")
						return
					end
				end
			else
				wait()
				say_title("Simyager:")
				say("")
                say("100 tane topla.")
				say("")
				return
			end
		end
		
		when 20060.take or 20061.take or 20062.take or 20063.take or 20064.take or 20065.take or 20066.take or
			 20067.take or 20068.take or 20069.take or 20070.take or 20071.take or 20072.take or 
			 33009.take or 33010.take or 33011.take or 33012.take or 33013.take
			with guild_building_melt.IsRefinableRawOre(item.vnum) begin
			--Good
			if guild_building_melt.GetMyRefineNum(npc.race) == item.vnum then
				if item.vnum == 50601 then
					guild_building_melt.DoRefineDiamond(guild_building_melt.GetOreRefineGoodPct())
				else
					guild_building_melt.DoRefine(guild_building_melt.GetOreRefineGoodPct())
				end
			else--Bad
				if item.vnum == 50601 then
					guild_building_melt.DoRefineDiamond(guild_building_melt.GetOreRefineBadPct())
				else
					guild_building_melt.DoRefine(guild_building_melt.GetOreRefineBadPct())
				end
			end
		end

		when 20060.click or 20061.click or 20062.click or 20063.click or 20064.click or 20065.click or 20066.click or
			 20067.click or 20068.click or 20069.click or 20070.click or 20071.click or 20072.click or 
			 33009.click or  33010.click or 33011.click or  33012.click or 33013.click begin
			if npc.get_guild() == pc.get_guild() and pc.isguildmaster() then
				say_title("Simyager:")
				say("")
				say(" 3.000.000 Yang kar��l���nda iyi bir kimyager")
				say("kullanabilirsin.")
				say("")
				wait()
				if pc.get_gold() < 3000000 then
					say_title("Simyager:")
					say("")
					say("Hangi t�r �zerinde �al��an kimyager istiyorsun?")
					say("")
					return
				end

				local sel = 0
				local timetable1 = {"Elmas", "Fosiller", "Bak�r", "G�m��", "Alt�n", "Ye�im", "Devam", "Kapat"}
				local valuetable1 = {14043, 14045, 14046, 14047, 14048, 14049, 1, 3}
				local timetable2 = {"Abanoz", "�nci", "Beyaz Alt�n", "Kristal", "Ametist", "Devam", "Geri", "Kapat"}
				local valuetable2 = {14050, 10451, 14052, 14053, 14054, 2, 0, 3}
				local timetable3 = {"Cennetin G�zya��", "Ruh Kristali", "Yakut", "Grena", "Z�mr�t", "Safir", "Geri", "Kapat"}
				local valuetable3 = {14055, 26992, 26993, 26994, 26995, 26996, 1, 3}
				repeat
					say_size(300, 350)
					say_title("Sistem:")
					say("Hangi t�r �zerinde �al��an kimyager istiyorsun?")
					if sel == 0 then
						local s = select_table(timetable1)
						sel = valuetable1[s]
					elseif sel == 1 then
						local s = select_table(timetable2)
						sel = valuetable2[s]
					elseif sel == 2 then
						local s = select_table(timetable3)
						sel = valuetable3[s]
					end
				until sel > 2
				if sel != 3 then
					npc_num = sel + 20060 - 14043
					--chat("#debug#sel:"..sel.."#npc_num:"..npc_num)
					if npc_num == npc.get_race() then
						say("Bu simyager zaten �al���yor.")
					else
						pc.changegold(-3000000)
						building.reconstruct(sel)
					end
				end
			else
				setskin(NOWINDOW)
			end
		end
	end
end