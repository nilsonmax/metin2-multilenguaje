quest beceri_degistir begin
	state start begin
		when 40004.use begin
			if pc.count_item(item.get_vnum()) < 1 then
				syschat("Yeterli miktarda Beceri de�i�im y�z���ne sahip de�ilsin.")
				return
			end
			if pc.getf("skill_reset2","skill_bind") + get_time() > 0 then
				syschat("Becerilerin m�h�rlenmi� durumdayken bunu ger�ekle�tiremezsin.")
				return
			end
			if pc.get_skill_group() == 1 then
				G_Degerler = beceri_degistir.SinifBeceri(pc.get_job(),2)
				G_BeceriDegerleri = beceri_degistir.BeceriKodlari(pc.get_job(),2)
			elseif pc.get_skill_group() == 2 then
				G_Degerler = beceri_degistir.SinifBeceri(pc.get_job(),1)
				G_BeceriDegerleri = beceri_degistir.BeceriKodlari(pc.get_job(),1)
			end
			D_G_Degerler = {}
			D_G_Becerim = {}
			D_B_Denetim = {}
			beceriTipleri = {}
			beceriDegerleri = {}
			for i=1,table.getn(G_Degerler),1 do D_G_Degerler[i] = G_Degerler[i] end
			D_G_Degerler[tonumber(table.getn(D_G_Degerler))+1] = "Kapat"
			
			G_Becerim = beceri_degistir.SinifBeceri(pc.get_job(),pc.get_skill_group())
			for i=1,table.getn(G_Becerim), 1 do D_G_Becerim[i] = G_Becerim[i] end
			
			G_BeceriKodlari = beceri_degistir.BeceriKodlari(pc.get_job(),pc.get_skill_group())
			
			for i=1,table.getn(D_G_Becerim)+1,1 do
				if i == table.getn(D_G_Becerim) +1 then
					say_title("Bilgilendirme:[WINDOW_SIZE width;350|height;350] ")
					say("")
					say("Beceri de�i�tirme i�leminiz a�a��daki gibi olacakt�r: ")
					say("")
					for m=1,table.getn(D_B_Denetim),1 do
						say_reward(D_B_Denetim[m])
					end
					say("")
					say_reward("Onayl�yor musunuz?")
					say("")
					beceriDegisimOnay = select("Evet","Hay�r")
					if beceriDegisimOnay == 1 then
						if pc.get_skill_group() == 1 then
							pc.set_skill_group(2)
						elseif pc.get_skill_group() == 2 then
							pc.set_skill_group(1)
						end
						say_title("Bilgilendirme: ")
						say("")
						say("��lem yap�l�yor[DELAY value;2500]...[/DELAY]")
						say("")
						say_reward("��lem ba�ar�l�!")
						say("")
						wait()
						item.remove(1)
						for u=1,table.getn(beceriTipleri), 1 do
							pc.set_skill_level(beceriTipleri[u],beceriDegerleri[u])
						end
						warp_to_village(pc.get_map_index())
					elseif beceriDegisimOnay == 2 then
						return
					end
				else
					say_title("Bilgilendirme:[WINDOW_SIZE width;350|height;375] ")
					say("")
					say_reward("Se�ilen beceriniz: "..D_G_Becerim[i])
					say_reward("Se�ilen beceri durumu: "..beceri_degistir.BeceriDurumu(pc.get_skill_level(G_BeceriKodlari[i])))
					say("")
					say_reward("Hangi beceriye aktarmak istiyorsunuz?")
					say("")
					D_G_DegerlerTPL = table.getn(D_G_Degerler)
					beceri_secim = select_table(D_G_Degerler)
					if beceri_secim != D_G_DegerlerTPL then
						table.insert(beceriTipleri, G_BeceriDegerleri[beceri_secim])
						table.insert(beceriDegerleri, pc.get_skill_level(G_BeceriKodlari[i]))
						table.insert(D_B_Denetim, D_G_Becerim[i].."("..beceri_degistir.BeceriDurumu(pc.get_skill_level(G_BeceriKodlari[i]))..") --> "..D_G_Degerler[beceri_secim])
						table.remove(D_G_Degerler, beceri_secim)
						table.remove(G_BeceriDegerleri, beceri_secim)
					else
						return
					end
				end
			end
		end
		
		function SinifBeceri(g_sinif,g_beceri)
			D_SinifBeceri = {
				[0] = {
					[1] = {"�� Y�nl� Kesme","K�l�� �evirme","�fke","Hava K�l�c� ","Hamle","Ya�ama �ste�i"},
					[2] = {"Ruh Vuru�u","�iddetli Vuru� ","G��l� Vuru� ","G��l� Beden","K�l�� Darbesi","K�l�� �emberi"}
				},
				
				[1] = {
					[1] = {"Suikast","H�zl� Sald�r� ","B��ak �evirme","Kamuflaj","Zehirli Bulut"},
					[2] = {"Tekrarlanan At�� ","Ok Ya�muru","Ate�li Ok","Hafif Ad�m","Zehirli Ok"}
				},
				
				[2] = {
					[1] = {"Parmak Darbesi","Ejderha D�n��� ","B�y�l� Keskinlik","Deh�et","B�y�l� Z�rh","B�y� ��zme"},
					[2] = {"Karanl�k Vuru� ","Ate� Vuru� ","Ate� Hayaleti","Karanl�k Koruma","Hayalet Vuru� ","Karanl�k K�re"}
				},
				
				[3] = {
					[1] = {"U�an T�ls�m","Ejderha At��� ","Kutsama","Ejderha K�kremesi","Yans�tma","Ejderha Yard�m� "},
					[2] = {"�im�ek Atma","�im�ek �a��rma","�im�ek Pen�esi","�yile�tirme","H�z","Y�ksek Sald�r� "}
				},
				
				[4] = {
					[1] = {"Y�rtma ","Kurt Nefesi ","Kurt Atlay��� ","Kurt Pen�esi ","K�rm�z� Kurt Ruhu ","�ivit Kurt Ruhu "},
					[2] = {"Y�rtma ","Kurt Nefesi ","Kurt Atlay��� ","Kurt Pen�esi ","K�rm�z� Kurt Ruhu ","�ivit Kurt Ruhu "}
				}
			}
			return D_SinifBeceri[g_sinif][g_beceri]
		end
		
		function BeceriKodlari(g_Kod_sinif,g_Kod_beceri)
			beceriKodlari = {
				[0] = { -- Sava���
					[1] = {1,2,3,4,5,6},
					[2] = {16,17,18,19,20,21}
				},
				
				[1] = { -- Ninja
					[1] = {31,32,33,34,35,36},
					[2] = {46,47,48,49,50,51}
				},
				
				[2] = { -- Sura
					[1] = {61,62,63,64,65,66},
					[2] = {76,77,78,79,80,81}
				},
				
				[3] = { -- �aman
					[1] = {91,92,93,94,95,96},
					[2] = {106,107,108,109,110,111}
				},
				
				[4] = {
					[1] = {170,171,172,173,174,175},
					[2] = {170,171,172,173,174,175}
				}
			}
			return beceriKodlari[g_Kod_sinif][g_Kod_beceri]
		end
	
		function BeceriDurumu(gelenBeceriDurumu)
			if gelenBeceriDurumu < 20 then
				return gelenBeceriDurumu
			else
				beceriDurumlari = {
					[20] = {"Master 1"},
					[21] = {"Master 2"},
					[22] = {"Master 3"},
					[23] = {"Master 4"},
					[24] = {"Master 5"},
					[25] = {"Master 6"},
					[26] = {"Master 7"},
					[27] = {"Master 8"},
					[28] = {"Master 9"},
					[29] = {"Master 10"},
					[30] = {"Grand Master 1"},
					[31] = {"Grand Master 2"},
					[32] = {"Grand Master 3"},
					[33] = {"Grand Master 4"},
					[34] = {"Grand Master 5"},
					[35] = {"Grand Master 6"},
					[36] = {"Grand Master 7"},
					[37] = {"Grand Master 8"},
					[38] = {"Grand Master 9"},
					[39] = {"Grand Master 10"},
					[40] = {"Perfect Master"}
				}
				return beceriDurumlari[gelenBeceriDurumu][1]
			end
		end
	end
end
