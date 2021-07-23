quest reset_scroll begin
    state start begin
                when 71002.use begin
                        ---                                                   l
                        say_title("Stat� S�f�rlama Ka��d�: ")
                        say("")
                        say("Bu ka��t her �eyi unutmay� m�mk�n k�l�yor.")
                        say("Bu senin t�m stat� puanlar�n� s�f�rlayacak.")
                        say("Geri d�n��� m�mk�n de�il. ")
                        say("")
                        say("Kullanmak istiyor musun?")
                        say("")

                        local s = select("Evet", "Hay�r")
                        if 2 == s then
                                return
                        end

                        say_title("Stat�n� S�f�rla Onay:")
                        say("")
                        say("T�m stat� puanlar�n s�f�rlanacak ve ")
                        say("ba�tan ba�layacaks�n. ")
                        say("")
                        say("Stat� s�f�rlama i�lemini onayl�yor musun?")
                        say("")

                        local c = select("Onayl�yorum", "S�f�rlamay� iptal et")
                        if 2 == c then
                                return
                        end

                        char_log(0, "RESET_ALL", "USE_ITEM(71002)")
                        pc.remove_item(71002)

                        char_log(0, "RESET_ALL", "RESET_STAT_POINTS")
                        pc.reset_point()

                        --char_log(0, "RESET_ALL", "RESET_SKILL_POINTS")
                        --pc.clear_skill()
                        --pc.set_skill_group(0)
                        char_log(0, "RESET_ALL", "RESET_END")
                end

                when 71003.use begin

                        ----------                                                   l
                        say_title("Beceri S�f�rlama Ka��d�: ")
                        say_reward("Se�ilen beceri s�f�rlanacak,")
                        say_reward("puanlar�n� tekrar d�zenleyebileceksin.")
                        say_reward("�u ana kadar toplad���n t�m puanlar�n� ")
                        say_reward("kaybedeceksin ve se�ti�in beceri i�in ")
                        say_reward("kulland���n puan�n sadece 17'sini ")
                        say_reward("geri kazanacaks�n.")

                        local result = BuildSkillList(pc.get_job(), pc.get_skill_group())

                        local vnum_list = result[1]
                        local name_list = result[2]

                        if table.getn(vnum_list) < 2 then
                                say("S�f�rlanacak beceri yok.")
                                say("")
                                return
                        end

                        say("S�f�rlamak istedi�in beceriyi se�. ")
                        say("")

                        local i = select_table(name_list)

                        if table.getn(name_list) == i then
                                return
                        end

                        local name = name_list[i]
                        local vnum = vnum_list[i]

                        say_title("Beceri S�f�rlama Ka��d�:")
                        say_reward("Se�ilen beceri s�f�rlanacak,")
                        say_reward("puanlar�n� tekrar d�zenleyebileceksin.")
                        say_reward("�u ana kadar toplad���n t�m puanlar�n� ")
                        say_reward("kaybedeceksin ve se�ti�in beceri i�in ")
                        say_reward("kulland���n puan�n sadece 17'sini ")
                        say_reward("geri kazanacaks�n.")

                        say(string.format("%s becerini s�f�rlamak istiyor musun?", name))
                        say("")

                        local s = select("Evet", "Hay�r")
                        if 2 == s then
                                return
                        end

                        say_title("Becerini S�f�rla Onay:")
                        say("")
                        say("Beceri s�f�rlama i�lemini onayl�yor musun?")
                        say("")

                        local c = select("Onayl�yorum", "S�f�rlamay� iptal et")

                        if 2 == c then
                                return
                        end

                        char_log(0, "RESET_ONE_SKILL", "USE_ITEM(71003)")
                        pc.remove_item(71003)

                        char_log(0, "RESET_ONE_SKILL", string.format("RESET_SKILL[%s]", name))
                        pc.clear_one_skill(vnum)

                        char_log(0, "RESET_ONE_SKILL", "APPLY_17MASTER_BONUS")
                        pc.setqf("force_to_master_skill", 1)

                        say_title("Beceri S�f�rlama Ka��d�:")
                        say(string.format("%s Becerisi S�f�rland�.", name))
                        say("")

                        ---                                                   l
                        say("")
                end
        end
end
