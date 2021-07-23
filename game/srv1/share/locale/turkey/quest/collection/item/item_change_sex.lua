quest item_change_sex begin
	state start begin
		when 71048.use begin 
			if pc.get_level() < 50 then 
				say_title("De�i�im T�ls�m� ")
				say_reward("Sadece 50. seviye alt�ndakiler cinsiyet")
				say("de�i�tirebilirler.")
				say("Cinsiyet de�i�tirmek i�in seviyen �ok d���k.")
				say("50. seviyeye ula�t���nda tekrar dene.")
				say("")
				return;
			end
			
			if pc.is_engaged() then
				say_title("De�i�im T�ls�m� ")
				say_reward("Sadece bekar karakterler cinsiyet")
				say_reward("de�i�tirebilirler.")

				----"12345678901234567890123456789012345678901234567890"|
				say("E�er evliysen, cinsiyet de�i�tirmeden �nce")
				say("bo�anmak zorundas�n.")
				say("")
				return;
			end

			if pc.is_married() then
				say_title("De�i�im T�ls�m� ")
				say_reward("Sadece bekar karakterler cinsiyet")
				say_reward("de�i�tirebilirler.")

				----"12345678901234567890123456789012345678901234567890"|
				say("E�er evliysen, cinsiyet de�i�tirmeden �nce")
				say("bo�anmak zorundas�n.")
				return;
			end

			if pc.is_polymorphed() then
				say_title("De�i�im T�ls�m� ")
				say_reward("D�n��m�� haldeyken t�ls�m� kullanamazs�n.")
				say("")

				say("D�n��m�� karakterler cinsiyet de�i�tiremezler.")
				say("")
				return
			end
			
			local WEAR_COSTUME_BODY_INDEX = 19
			local WEAR_COSTUME_HAIR_INDEX = 20
			if pc.get_wear(WEAR_COSTUME_BODY_INDEX) != nil then
				say_title("De�i�im T�ls�m� ")
				say_reward("Kost�m giyili iken t�ls�m� kullanamazs�n.")
				say("")
				
				say("Kost�m giyen karakterler cinsiyet de�i�tiremezler.")
				say("")
				return
			end
			
			if pc.get_wear(WEAR_COSTUME_HAIR_INDEX) != nil then
				say_title("De�i�im T�ls�m� ")
				say_reward("Sa� stili giyili iken t�ls�m� kullanamazs�n.")
				say("")
				
				say("Sa� stili giyen karakterler cinsiyet de�i�tiremezler.")
				say("")
				return
			end
			
			if get_time() < pc.getqf("next_time") then
				say_title("De�i�im T�ls�m� ")
				say_reward("De�i�im T�ls�m� 3 g�n arayla kullan�labilir.")
				say("")	
				----"12345678901234567890123456789012345678901234567890"|
				say("En yak�n kullanabilece�in zaman:")
				say("")

				if pc.is_gm() then
					say(string.format("    %s", time_to_str(pc.getqf("next_time"))))
					say("")
					say("GM can reset time for tesing")
					local s = select("Yes", "NO")
					if s == 1 then
						say("Gender change time has been reset")
						pc.setqf("next_time", 0)
					end
				end
				return;

			end

			say("De�i�im T�ls�m� ")
			say("")
			say("Bu t�ls�mla cinsiyet de�i�tirebilirsin.")
			say("Bir kere kulland���nda tekrar kullanmak i�in 3")
			say("g�n beklemek zorundas�n.")
			wait()

			say("De�i�im T�ls�m� ")
			say("")
			say("Kulland�ktan sonra de�i�ikliklerin g�r�lebilmesi")
			say("i�in oyundan ��kman gerekir.")
			say("")
			say("�imdi karar zaman�.")
			say("Cinsiyetini de�i�tirmek istiyor musun?")
			say("")
			local s=select(
				"De�i�tirmek istiyorum.",
				"De�i�tirmek istemiyorum.")
			if 1==s then
				say("De�i�im T�ls�m� ")
			say("")
				say("Hayat puan�n ve mana puan�n ayn� kalacak.")
				say("Sadece g�r�n���n de�i�ecek.")
				say("")
				say_reward("Yeni cinsiyetin oyuna tekrar girdi�inde g�r�necek.")
				say("")

				pc.remove_item("71048",1)
				pc.change_sex()

				local m_sex = pc.get_sex()

				if m_sex == 0 then
				    char_log(0, "CHANGE_SEX", "F -> M")
				else
				    char_log(0, "CHANGE_SEX", "M -> F")
				end

			elseif 2==s then
				say("E�er teredd�t�n varsa, bunu yapma.")
				say("")
			end
		end
	end
end		

