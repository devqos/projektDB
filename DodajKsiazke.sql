DELIMITER $$
CREATE PROCEDURE biblioteka.DodajKsiazke(
	ISBN VARCHAR(45),
	Tytul VARCHAR(45),
    Autor VARCHAR(45),
    Wydawnictwo VARCHAR(45),
    Data_wydania DATE,
    Maksymalny_czas_wypozyczenia INT
)    
BEGIN
	DECLARE wyd_id INT;
    DECLARE space_pos INT;
    DECLARE aut_id INT;
	START TRANSACTION;
	IF NOT EXISTS (SELECT * FROM biblioteka.wydawnictwo WHERE wydawnictwo.Nazwa = Wydawnictwo) THEN
		INSERT INTO biblioteka.wydawnictwo(Nazwa) VALUE (Wydawnictwo);
    END IF;
    
    SET space_pos = INSTR(Autor, ' ');
    
    IF NOT EXISTS (SELECT * FROM biblioteka.autorzy WHERE CONCAT(autorzy.Imie, ' ', autorzy.Nazwisko) = Autor) THEN
			INSERT INTO biblioteka.autorzy(Imie, Nazwisko) VALUE (SUBSTRING(Autor, 1, space_pos - 1), SUBSTRING(Autor, space_pos + 1));
	END IF;
    
    SELECT Wydawnictwo_id INTO wyd_id FROM wydawnictwo WHERE wydawnictwo.Nazwa = Wydawnictwo;

	INSERT INTO biblioteka.ksiazka(ISBN, Tytul, Wydawnictwo_id, Data_wydania, Liczba_egzemplarzy, Maksymalny_czas_wypozyczenia) 
    VALUE (ISBN, Tytul, wyd_id, Data_wydania, 0, Maksymalny_czas_wypozyczenia);
    
    SELECT Autor_id INTO aut_id FROM biblioteka.autorzy WHERE CONCAT(autorzy.Imie, ' ', autorzy.Nazwisko) = Autor;
    
    INSERT INTO biblioteka.autorzy_ksiazki (ISBN, Autor_id) VALUE (ISBN, aut_id);
    COMMIT;
END $$
DELIMITER ;