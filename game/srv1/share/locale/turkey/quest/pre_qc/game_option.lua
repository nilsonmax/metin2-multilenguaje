quest game_option begin
	state start begin
		when login begin
			local val=0
			local msg = "Engelle: "

			if pc.getqf("block_exchange") == 1 then
				msg = msg.."Ticaret "
				val = val + 1
			end

			if pc.getqf("block_guild_invite") == 1 then
				val = val + 4
				msg = msg.."Lonca "
			end

			if pc.getqf("block_messenger_invite") == 1 then
				msg = msg.."Arkada�lar "
				val = val + 16
			end

			if pc.getqf("block_party_invite") == 1 then
				msg = msg.."Grup "
				val = val + 2
			end

			if pc.getqf("block_party_request") == 1 then
				msg = msg.."Rica "
				val = val + 32
			end

			if pc.getqf("block_whisper") == 1 then
				msg = msg.."F�s�lt� "
				val = val + 8
			end
			
			if val != 0 then
				syschat(msg)
			end

			pc.send_block_mode(val)
		end
	end
end
