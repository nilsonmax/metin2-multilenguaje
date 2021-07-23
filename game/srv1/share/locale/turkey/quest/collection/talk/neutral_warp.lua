quest neutral_warp begin
	state start begin
		when 20009.chat."Merhaba! " begin
			say_title("Ya�l� Adam: ")

			say("Merhaba![ENTER]Buradan ba�ka b�lgelere nas�l[ENTER]gidebilece�ini biliyorum. E�er bana biraz Yang[ENTER]verirsen, seni oralara I��nlayabilirim. ")
			local s =  select("I��nlan ", "I��nlanma ")

			if 2 == s then
				return
			end

			local cost = 1000
			say_title("Ya�l� Adam: ")

			say(string.format("Nereye gitmek istiyorsun?[ENTER]�creti %s Yang. ", cost))
			if pc.gold < cost then
				say("Yeterli Yang yok.")
				return
			end

			local m = pc.get_map_index()
			local e = pc.empire

			if m == 1 or m == 3 then
				e = 1
			elseif m == 21 or m == 23 then
				e = 2
			elseif m == 41 or m == 43 then
				e = 3
			end

			if m == 1 or m == 21 or m == 41 then
				if pc.count_item(30180) == 0 then
					s =  select("Seungryong Vadisi ", "Sohan Da�� ", "�ptal Et")
					if 3 == s then
						return
					end
				else
					s =  select("Seungryong Vadisi ", "Sohan Da�� ", "Ejderha Tanr� T�ls�m� kullan. ", "�ptal Et")
					if 4 == s then
						return
					end
				end

				local warp = {
					{
						{ 402100, 673900 },
						{ 270400, 739900 },
						{ 321300, 808000 },
					},
					{
						{ 434200, 290600 },
						{ 375200, 174900 },
						{ 491800, 173600 },
					},
					{
						{ 287800, 799700 },
						{ 275500, 800000 },
						{ 277000, 788000 },
					},
				}
				test_chat(warp[s][e][1]..warp[s][e][2])

				pc.warp(warp[s][e][1], warp[s][e][2])
				pc.changegold(-cost)

			elseif m == 3 or m == 23 or m == 43 then
				if pc.count_item(30180) == 0 then
					s =  select("Yongbi ��l� ", "Doyyumhwan ", "�ptal Et")
					if 3 == s then
						return
					end
				else 
					s =  select("Yongbi ��l� ", "Doyyumhwan ", "Ejderha Tanr� T�ls�m� kullan. ", "�ptal Et")
					if 4 == s then
						return
					end
				end
					
				local warp = {
					{
						{ 217800, 627200 },
						{ 221900, 502700 },
						{ 344000, 502500 },
					},
					{
						{ 599400, 756300 },
						{ 597800, 622200 },
						{ 730700, 689800 },
					},
					{
						{ 287800, 799700 },
						{ 275500, 800000 },
						{ 277000, 788000 },
					},
				}
				test_chat(warp[s][e][1]..warp[s][e][2])

				pc.warp(warp[s][e][1], warp[s][e][2])
				pc.changegold(-cost)
			end
		end -- end_of_when
	end -- end_of_state
end -- end_of_quest
