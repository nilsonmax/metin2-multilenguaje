quest cube begin
    state start begin
        when 20018.chat."�ifal� Bitkiler Bilimi " or 20017.chat."�ifal� Bitkiler Bilimi " or 20022.chat."Gizli tarif" begin
			say_title(npc.get_name())
			say("")
			say("Merhaba, nas�ls�n?")
			say("Seni g�clendirecek yada iyile�tirecek ")
			say("iksirler yaratmakla ilgileniyormusun?")
			say("Bir �ifac� olarak kendimi ")
			say("iksirlere adad�m.")
			say("Bir�ok tarif buldum. ")
			say("Onlar� denemek istermisin? ")
			say("")
			wait()
			setskin(NOWINDOW)
			command("cube open")
		end
		-- when 20383.chat."Ar�nd�rma Penceresini A� " or 20421.chat."Ar�nd�rma Penceresini A� " or 20470.chat."Ar�nd�rma Penceresini A� " or 20406.chat."Ar�nd�rma Penceresini A� " or 20015.chat."Ar�nd�rma Penceresini A� " begin
		-- 	say_title(npc.get_name())
		-- 	say("")
		-- 	say("Senin i�in bir�eyleri y�kseltebilirim... ")
		-- 	say("E�yay� s�r�kle ve yeni bir e�ya olu�tur. ")
        --     say("")
        --     wait()
        --     setskin(NOWINDOW)
        --     command("cube open")
		-- end
	end
end
