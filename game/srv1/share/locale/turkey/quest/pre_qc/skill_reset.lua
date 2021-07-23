quest skill_reset2 begin
    state start begin			
        when 9006.chat."Becerileri s�f�rla." begin
			say_title(mob_name(npc.get_race())..":")
			say("")
			---
			if(math.floor(get_global_time()/86400) == pc.getf("skill_reset2","time")) then
				say("Becerilerini zaten s�f�rlam��s�n. Haf�zan� ")
				say("bu kadar yorarsan akl�n� kaybedebilirsin.")
				say("Bu de�i�im 1 G�n arayla de�i�tirebilir.")
				return
			elseif(pc.get_level() < 5) then
				say("�ncelikle hen�z bir �aylaks�n ve hi�bir �ey")
				say("bilmiyorsun. Git ve bir �eyler ��ren!")
				say("")
				return
			elseif(pc.get_skill_group() == 0) then
				say("Haf�zan �u anda zaten bo�.")
				say("")
				return
			end
			local cost
			if(pc.get_level() > 30) then
				cost = 10000 + pc.level * 200000
			else
				cost = 10000 + pc.level * 100000
			end
			say("Merhaba, do�ru yerdesin.")
			say("Dertli g�r�n�yorsun.")
			say("�nsanlar�n becerilerini unutmalar�na yard�mc� ")
			say("oluyorum. Hayata yeniden ba�l�yorlar.")
			say("Becerilerini unutup, ba�tan ba�lamak")
			say("ister misin?")
			say_reward("Fiyat : "..cost.." Yang.")
			say("")
			local s = select("S�f�rla","S�f�rlama")
			if(s == 2) then
				return
			end
			if(pc.get_money() < cost) then
				say_title(mob_name(npc.get_race())..":")
				say("")
				---
				say("Yeterli Yang'a sahip de�ilsin.")
				say("Yang olmadan sana yard�m edemem,")
				say("Ya�amak i�in bir �eyler yapmam gerekiyor.")
				return
			end
			local horse_level = horse.get_level()
			pc.setf("skill_reset2","time",math.floor(get_global_time()/259000))
			pc.change_gold(-cost)
			pc.clear_skill()
			pc.set_skill_group(0)
			horse.set_level(horse_level)
			if pc.job == 4 then
				pc.set_skill_group(1) -- !!!
				pc.clear_skill()
				pc.set_skill_level (170,0)
				pc.set_skill_level (171,0)
				pc.set_skill_level (172,0)
				pc.set_skill_level (173,0)
				pc.set_skill_level (174,0)
				pc.set_skill_level (175,0)
				pc.set_skill_level(121,20)
				pc.set_skill_level(122,1)
				pc.set_skill_level(123,20)
				pc.set_skill_level(124,20)
				pc.set_skill_level(126,20)
				pc.set_skill_level(127,20)
				pc.set_skill_level(128,20)
				pc.set_skill_level(130,21)
				pc.set_skill_level(131,20)
				pc.set_skill_level(137,20)
				pc.set_skill_level(138,20)
				pc.set_skill_level(139,20)
				horse.set_level(horse_level)
			end
			set_quest_state("skill_group","run")
		end
    end
end