quest dragon_soul_refine begin
	state start begin
		when 20001.chat."Ejderha Ta�� Ar�nd�rma " with ds.is_qualified() != 0 begin
			say_title(mob_name(20001))
			say ("Ejderha Ta�� m� y�kseltmek istiyorsun?[ENTER]Tam yerindesin. Ama �unu bilmelisin y�kseltmeler[ENTER]ba�ar�s�zda olabilir. Y�kseltme yaparken, farkl� renkte[ENTER]fas�lyelere ihtiya� duyacaks�n.")
			ds.open_refine_window()
		end
	end
end
