quest training_mount begin
	state start begin
		function check_list(material, pc_level, horse_level)
			if pc.count_item(material) <= 0 then 
				say_title(""..mob_name(20349).."")
				say("�zg�n�m, par��men olmadan sana yard�mc� olamam. ")
				return 0
			elseif pc.level <  pc_level then
				say_title(""..mob_name(20349).."")
				say("�zg�n�m, sana yard�mc� olamam.[ENTER]Bunun i�in en az�ndan Asker At lisans�na sahip olmal�s�n. ") 
				return 0
			elseif 	horse.get_level()< horse_level then
				say_title(""..mob_name(20349).."")
				say(string.format("Binek geli�tirmek i�in uygun m�h�r yok.[ENTER]En az�ndan Asker At sahibi olmal�s�n.",horse_level)) 
				return 0
			else
				return 1
			end
		end
		
		function extraTime(typ)
			local n = number (1,100)
			if typ == 1 then
				if n <= 50 then
					return 86400
				elseif n <= 80 then
					return 86400*2
				elseif n <=95 then
					return 86400*3
				else
					return 86400*4
				end
			elseif typ == 2 then
				if n <= 30 then
					return 0
				elseif n <= 70 then
					return 86400
				elseif n <=90 then
					return 86400*2
				else
					return 86400*3
				end
			end
		end
		
		when 20349.chat."Yeni bir bine�e binmek istiyorum! " begin
			say_title(""..mob_name(20349).."")
			say("�ii�t! Hala at s�rt�nda m� gidiyorsun?[ENTER]�nanam�yorum! diye bir �ey var, hi� duymad�n m�? ")
			say("")
			wait()
			say_title(""..mob_name(20349).."")
			say("Ehlile�tirilmi� yaban hayvanlar�n� sava� i�in[ENTER]e�itebilmen i�in derin binicilik bilgisine sahip[ENTER]olmal�s�n. Ayr�ca �u e�yalar da sana laz�m[ENTER]olacak: bine�ini yabani binek hayvan� yapmak i�in[ENTER]evrim par��meni; bine�ini cesur binek hayvan�[ENTER]yapmak i�in de mutasyon par��meni gerekir.")
			say("")
			wait()
			say_title(""..mob_name(20349).."")
			say("Daha fazla sorular�n olursa diledi�in zaman[ENTER]yan�ma gelebilirsin. Sana elimden geldi�i kadar[ENTER]yard�mc� olaca��m. ")
			say("")
			set_state(main_point)
		end
	end

	state main_point begin
		when 20349.chat."Bine�imi geli�tirmek istiyorum! " begin
			say_title(""..mob_name(20349).."")
			say("Demek bine�ini geli�tirmek istiyorsun, �yle mi?[ENTER]Nas�l yap�ld���n� biliyor musun?[ENTER]Hadi gel anlatay�m. ")
			say("")
			wait()
			say_title(""..mob_name(20349).."")
			say("Bine�ini geli�tirip, yabani binek hayvan�[ENTER]yapabilmen i�in Evrim Par��meni aray���na[ENTER]��kmal�s�n. Sonra yaban hayvan�n� e�itip, cesur[ENTER]binek hayvan� yapabilmek i�in de Mutasyon[ENTER]Par��meni'ni bulmal�s�n. Tehlikeli devlerin[ENTER]ya�ad��� �ok uzak bir diyarda sakl�[ENTER]olduklar� s�ylenir! ")
			say("")
			wait()
			say_title(""..mob_name(20349).."")
			say("Bana o par��menlerden birini getirirsen bine�ini[ENTER]geli�tirece�im. Getirdin mi yoksa? ")

			local s=select("Evet, bine�imi geli�tirmek istiyorum! ","Hay�r, �imdi de�il. ")

			if 2==s then
				return
			end
			if pc.count_item(50067) >0  or pc.count_item(50068)>0 then 
				say_title(""..mob_name(20349).."")
				say("Ah, par��menlerden birini getirmi�sin.[ENTER]Hangisini getirdin?[ENTER]Evrim par��meniyle tecr�besiz yavru[ENTER]hayvan�n� sava� i�in e�itiyorsun. Sonra da[ENTER]mutasyon par��meniyle geli�tirip cesur binek[ENTER]hayvan� yapabiliyorsun. ")
			else 
				say_title(""..mob_name(20349).."")
				say("�zg�n�m, par��men olmadan sana yard�mc� olamam. ")
				return
			end

			local s=select("Evrim Par��meni bende. ","Mutasyon Par��meni bende. ","Par��men getirmedim. ")
			if 1==s  then 
				if training_mount.check_list(50067,25,11) == 1 then 
					say_title(""..mob_name(20349).."")
					say("Ah i�te evrim par��meni! Binek hayvan� m�hr�ne[ENTER]bir g�z atay�m. Sahtesiyle beni kand�rmaya[ENTER]�al��an nicelerini g�rd�m! �lk �nce ger�ek olup[ENTER]olmad���na bakaca��m. Ver bakal�m.[ENTER](M�hr�, Seyis'in �zerine s�r�kle.) ")
				end
			elseif 2==s   then
				if training_mount.check_list(50068,45,20) == 1 then 
					say_title(""..mob_name(20349).."")
					say("Ah i�te mutasyon par��meni! Binek hayvan� m�hr�ne[ENTER]bir g�z atay�m. Sahtesiyle beni kand�rmaya[ENTER]�al��an nicelerini g�rd�m! �lk �nce ger�ek olup[ENTER]olmad���na bakaca��m. Ver bakal�m.[ENTER]M�hr�, Seyis'in �zerine s�r�kle.) ")
				end
			elseif 3==s then
				say_title(""..mob_name(20349).."")
				say("Par��men buldu�unda bana geri gel.[ENTER] ")
				say("")
				return
			end
		end --when


		when 20349.take with 
                52001 <= item.vnum and item.vnum <= 52005 or 
                52016 <= item.vnum and item.vnum <= 52020 or 
                52031 <= item.vnum and item.vnum <= 52035 or 
                52046 <= item.vnum and item.vnum <= 52050 or 
                52061 <= item.vnum and item.vnum <= 52065 or 
                52076 <= item.vnum and item.vnum <= 52080 or 
				52091 <= item.vnum and item.vnum <= 52095 or 
				52106 <= item.vnum and item.vnum <= 52110 begin
			if pc.is_riding() == true then
				say_title(""..mob_name(20349).."")
				say("Konu�urken bine�inden iner misin l�tfen?[ENTER]Boynum tutuldu.[ENTER]Durmadan yukar� bakarak konu�mak zor[ENTER]oluyor. ")
				return
			end
			if count_item_range(38100, 38102) >= 1 then
				say_title(""..mob_name(20349).."")
				say("Bu �ifali bitki saf enerji ile g��l�[ENTER]bine�inizim �mr�n� bir ka� g�nl���ne uzat�r.[ENTER]Senin i�in ne yapabilirim?[ENTER]Bine�ini geli�tirmek ya da s�resini uzatmak ister misin? ")
				local choice = select("Uzat ", "Geli�tir ", locale.cancel)
				if choice == 3 then
					return
				elseif choice == 1 then
					local option_select = select("7 G�n ", "15 G�n ", "30 G�n ", locale.cancel)
					local information = {}
					if option_select == 4 then
						return
					end
					if option_select == 1 then
						if pc.count_item(38100) >= 1 then
							information = {86400*7,38100}
						else
							say_title(""..mob_name(20349).."")
							say("Se�ti�in s�reye uygun at��t�rmal���n ne[ENTER]yaz�k ki yok. Ama bunu d�nen paraya[ENTER]t�klayarak alabilirsin. ")
							return
						end
					elseif option_select == 2 then
						if pc.count_item(38101) >= 1 then
							information = {86400*15,38101}
						else
							say_title(""..mob_name(20349).."")
							say("Se�ti�in s�reye uygun at��t�rmal���n ne[ENTER]yaz�k ki yok. Ama bunu d�nen paraya[ENTER]t�klayarak alabilirsin. ")
							return
						end
					elseif option_select == 3 then
						if pc.count_item(38102) >= 1 then
							information = {86400*30, 38102}
						else
							say_title(""..mob_name(20349).."")
							say("Se�ti�in s�reye uygun at��t�rmal���n ne[ENTER]yaz�k ki yok. Ama bunu d�nen paraya[ENTER]t�klayarak alabilirsin. ")
							return
						end
					end
					local remain_time =item.get_socket(0)
					item.set_socket(0,remain_time+information[1])
					pc.remove_item(information[2],1)
					return
				end
			end
			if training_mount.check_list(50067,25,11) == 1 then
				say_title(""..mob_name(20349).."")
				say("Binek hayvan� m�hr�n�n ah� gitmi� vah� kalm��.[ENTER]Bekle yenisiyle de�i�tireyim.[ENTER]Buyur alabilirsin.[ENTER]�imdi yabani binek hayvan�n� �a��rabilirsin.[ENTER]Mutasyon par��menini ke�feder[ENTER]ke�fetmez de yan�ma d�n.[ENTER]Sana daha g��l� bir binek hayvan� m�hr�[ENTER]haz�rlayaca��m. ")
				wait()
				say_title(""..mob_name(20349).."")
				say("Bu m�h�r, d�n��m�� bine�ini �a��rman� sa�lar.[ENTER]Ona g�z�n gibi bak, de�eri paha bi�ilemez! ")
				local remain_time =item.get_socket(0)
				local old_vnum =item.get_vnum()
				local new_vnum =item.get_vnum()+5
				local extra = training_mount.extraTime(1)
				pc.give_item2_select(new_vnum,1)
				item.set_socket(0,remain_time+extra)
				pc.remove_item(old_vnum,1)
				pc.remove_item(50067,1)
			end
		end

		when 20349.take with 52006 <= item.vnum and item.vnum <= 52010 or 
							52021 <= item.vnum and item.vnum <= 52025 or 
							52036 <= item.vnum and item.vnum <= 52040 or 
							52051 <= item.vnum and item.vnum <= 52055 or 
							52066 <= item.vnum and item.vnum <= 52070 or 
							52081 <= item.vnum and item.vnum <= 52085 or 
							52096 <= item.vnum and item.vnum <= 52100 or
							52111 <= item.vnum and item.vnum <= 52115 begin
			if pc.is_riding() == true then
				say_title(""..mob_name(20349).."")
				say("Konu�urken bine�inden iner misin l�tfen?[ENTER]Boynum tutuldu.[ENTER]Durmadan yukar� bakarak konu�mak zor[ENTER]oluyor. ")
				return
			end
			
			if count_item_range(38100, 38102) >= 1 then
				say_title(""..mob_name(20349).."")
				say("Bu �ifali bitki saf enerji ile g��l�[ENTER]bine�inizim �mr�n� bir ka� g�nl���ne uzat�r.[ENTER]Senin i�in ne yapabilirim?[ENTER]Bine�ini geli�tirmek ya da s�resini uzatmak ister misin? ")
				local choice = select ("Uzat ", "Geli�tir ", locale.cancel)
				if choice == 3 then
					return
				elseif choice == 1 then
					local option_select = select("7 G�n ", "15 G�n ", "30 G�n ", locale.cancel)
					local information = {}
					if option_select == 4 then
						return
					end
					if option_select == 1 then
						if pc.count_item(38100) >= 1 then
							information = {86400*7,38100}
						else
							say_title(""..mob_name(20349).."")
							say("Se�ti�in s�reye uygun at��t�rmal���n ne[ENTER]yaz�k ki yok. Ama bunu d�nen paraya[ENTER]t�klayarak alabilirsin. ")
							return
						end
					elseif option_select == 2 then
						if pc.count_item(38101) >= 1 then
							information = {86400*15,38101}
						else
							say_title(""..mob_name(20349).."")
							say("Se�ti�in s�reye uygun at��t�rmal���n ne[ENTER]yaz�k ki yok. Ama bunu d�nen paraya[ENTER]t�klayarak alabilirsin. ")
							return
						end
					elseif option_select == 3 then
						if pc.count_item(38102) >= 1 then
							information = {86400*30, 38102}
						else
							say_title(""..mob_name(20349).."")
							say("Se�ti�in s�reye uygun at��t�rmal���n ne[ENTER]yaz�k ki yok. Ama bunu d�nen paraya[ENTER]t�klayarak alabilirsin. ")
							return
						end
					end
					
					local remain_time =item.get_socket(0)
					item.set_socket(0,remain_time+information[1])
					pc.remove_item(information[2],1)
					return
				end
			end
			if training_mount.check_list(50068,45,20) == 1 then
				say_title(""..mob_name(20349).."")
				say("��te sana bir m�ddet �nce verdi�im binek hayvan�[ENTER]m�hr�. Ama baya�� kullan�lm��. Onu bana geri ver,[ENTER]sana daha g��l� bir binek hayvan� m�hr�[ENTER]haz�rlayaca��m. ")
				wait()
				say_title(""..mob_name(20349).."")
				say("Bu m�h�r, d�n��m�� bine�ini �a��rman� sa�lar.[ENTER]Ona g�z�n gibi bak, de�eri paha bi�ilemez! ")
				local remain_time =item.get_socket(0)
				local old_vnum =item.get_vnum()
				local new_vnum =item.get_vnum()+5
				local extra = training_mount.extraTime(1)
				pc.give_item2_select(new_vnum,1)
				item.set_socket(0,remain_time+extra)
				pc.remove_item (old_vnum,1)
				pc.remove_item (50068,1)
				
			end
		end

		when 20349.take with 52011 <= item.vnum and item.vnum <= 52015 or 
                            52026 <= item.vnum and item.vnum <= 52030 or
                            52041 <= item.vnum and item.vnum <= 52045 or
							52056 <= item.vnum and item.vnum <= 52060 or
                            52071 <= item.vnum and item.vnum <= 52075 or
							52086 <= item.vnum and item.vnum <= 52090 or
                            52101 <= item.vnum and item.vnum <= 52105 or
							52116 <= item.vnum and item.vnum <= 52120
                            begin
			if pc.is_riding() == true then
				say_title(""..mob_name(20349).."")
				say("Konu�urken bine�inden iner misin l�tfen?[ENTER]Boynum tutuldu.[ENTER]Durmadan yukar� bakarak konu�mak zor[ENTER]oluyor. ")
				return
			end
			
			say_title(""..mob_name(20349).."")
			say("Mutasyon Par��meni b�y�k bir g�ce sahiptir. Cesur[ENTER]bine�inin �mr�n� d�rt g�ne kadar uzatabilir. Bir[ENTER]deneme sana 200.000 Yang'a mal olur. Ancak bunun[ENTER]i�in bine�in �ok yorulmu� olmal� ve �mr� bir[ENTER]g�nden daha az olmal�. Ayr�ca tabi biraz da[ENTER]�ans�n olmal�! E�er uzatma ba�ar�s�z olursa ona[ENTER]g��l� bir at��t�rmal�k yedir. Bunu d�nen paran�n[ENTER]arkas�nda bulabilirsin. ")
			local choice = select ("Uzat ", locale.cancel)
			if choice == 2 then
				return
			elseif choice == 1 then
				local option_select = select("7 G�n ", "15 G�n ", "30 G�n ", "Mutasyon Par��meni + 200k Yang ", locale.cancel)
				local information = {}
				if option_select == 5 then
					return
				end
				if option_select == 1 then
					if pc.count_item(38100) >= 1 then
						information = {86400*7,38100}
					else
						say_title(""..mob_name(20349).."")
						say("Se�ti�in s�reye uygun at��t�rmal���n ne[ENTER]yaz�k ki yok. Ama bunu d�nen paraya[ENTER]t�klayarak alabilirsin. ")
						return
					end
				elseif option_select == 2 then
					if pc.count_item(38101) >= 1 then
						information = {86400*15,38101}
					else
						say_title(""..mob_name(20349).."")
						say("Se�ti�in s�reye uygun at��t�rmal���n ne[ENTER]yaz�k ki yok. Ama bunu d�nen paraya[ENTER]t�klayarak alabilirsin. ")
						return
					end
				elseif option_select == 3 then
					if pc.count_item(38102) >= 1 then
						information = {86400*30, 38102}
					else
						say_title(""..mob_name(20349).."")
						say("Se�ti�in s�reye uygun at��t�rmal���n ne[ENTER]yaz�k ki yok. Ama bunu d�nen paraya[ENTER]t�klayarak alabilirsin. ")
						return
					end
				elseif option_select == 4 then
					local remain_time = item.get_socket(0)
					local run_time = remain_time-get_time()
					if (remain_time-get_time()) > 86400 then
						say_title(""..mob_name(20349).."")
						say("G��l� bine�in hen�z �ok g��l�.[ENTER]Mutasyon par��meni burada hi�bir etki sa�lamaz.[ENTER]Bir g�nden az �mr� kald���nda yine gel. ")
						if  is_test_server()  then
							item.set_socket(0, get_time() + 86460)
						end
						return
					end
					if pc.count_item(50068) >= 1 and pc.get_gold() >= 200000 then
						information = {training_mount.extraTime(2),50068}
						pc.changegold(-200000)
					else
						say_title(""..mob_name(20349).."")
						say("Ne yaz�k ki sana yard�m edemem.[ENTER]Ya Mutasyon Par��meni yan�nda de�il[ENTER]ya da 200.000 Yang'�n yok. ")
						return
					end
				end
				
				local remain_time = item.get_socket(0)
				item.set_socket(0,remain_time+information[1])
				pc.remove_item(information[2],1)
				return
			end
			
		end
		
		when 20349.chat."At becerileri kullanabilir miyim? "  begin
			say_title(""..mob_name(20349).."")
			say("At becerilerini kullanmak istiyorsun, �yle mi?[ENTER]Senin de isteklerin bitmiyor Ger�i onu ben bile[ENTER]sterim... Neyse, onu ��renebilmek i�in bir tak�m[ENTER]kurallara uymal�s�n. ")
			wait()
			say_title(""..mob_name(20349).."")
			say("�lk olarak at binmeyi ��renmelisin, aksi takdirde[ENTER]senin i�in �ok tehlikeli olabilir. Bunun d���nda,[ENTER]sava�ta kullanmaya elveri�li bir bine�in olmas�[ENTER]gerekir. Ancak o zaman at becerilerini kullanacak[ENTER]durumunda olur. ")
			wait()
			say_title(""..mob_name(20349).."")
			say("Bine�in, at becerilerini kullanabilecek durumda[ENTER]m�? De�ilse e�itime izin veremeyece�im. Ne[ENTER]yapmay� d���n�yorsun? ")
			local s=select(locale.yes,locale.no)
			if 2==s then
				return
			end
			say_title(""..mob_name(20349).."")
			say("Anl�yorum. �imdi de g�c�n� ve binicilik bilgini[ENTER]tahmin edece�im. Bekle bir saniye. ")
			wait()
			if pc.count_item(50068) >0  then
				if horse.get_level()>1 then 
					say_title(""..mob_name(20349).."")
					say("Korkar�m bine�in hen�z haz�r de�il. ")
					wait()
					say("Sava�maya daha hevesli oldu�unda tekrar gel.")
				else 
					say_title(""..mob_name(20349).."")
					say("Ata binmek �ok tehlikelidir.[ENTER]Ata binmeyi ��rendi�in zaman gel.")
					return
				end
			else
				say_title(""..mob_name(20349).."")
				say("Hen�z haz�r de�ilsin.[ENTER]Haz�r oldu�unda tekrar gel. ")
				return
			end	
		end
	end
end
