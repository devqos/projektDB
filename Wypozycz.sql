DELIMITER $$
CREATE PROCEDURE biblioteka.WypozyczKsiazke(
	ISBN VARCHAR(45),
    PESEL VARCHAR(45),
    email VARCHAR(45)
)
BEGIN
	DECLARE Wypozyczany_egzemplarz_id INT;
    DECLARE bib_id INT;
    DECLARE czyt_id INT;
    DECLARE Data_zwrotu INT;
    DECLARE wyp_id INT;
	
    START TRANSACTION;
    SELECT Egzemplarz_id INTO Wypozyczany_egzemplarz_id FROM egzemplarz WHERE egzemplarz.ISBN = ISBN AND egzemplarz.Status_id = 2 LIMIT 1;
    SELECT Bibliotekarz_id INTO bib_id FROM bibliotekarz WHERE bibliotekarz.PESEL = PESEL;
    SELECT Czytelnik_id INTO czyt_id FROM czytelnik WHERE czytelnik.email = email;
    SELECT Maksymalny_czas_wypozyczenia INTO Data_zwrotu FROM ksiazka WHERE ksiazka.ISBN = ISBN;
    
    INSERT INTO wypozyczenia(ISBN, Bibliotekarz_id, Czytelnik_id, Data_wypozyczenia, Wymagana_data_zwrotu, Status_wypozyczenia_id) 
    VALUE (ISBN, bib_id, czyt_id, CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL Data_zwrotu DAY), 1);
    
    SELECT MAX(Wypozyczenie_id) INTO wyp_id FROM wypozyczenia;
    
    UPDATE egzemplarz SET Wypozyczenie_id = wyp_id, Status_id = 1 WHERE egzemplarz.Egzemplarz_id = Wypozyczany_egzemplarz_id;
    COMMIT;
END $$
DELIMITER ;