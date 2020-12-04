DELIMITER $$
CREATE PROCEDURE biblioteka.OddajKsiazke(
	ISBN VARCHAR(45),
    Email VARCHAR(45)
)
BEGIN
	DECLARE wyp_id INT;
    START TRANSACTION;
    SELECT MIN(Wypozyczenie_id) INTO wyp_id FROM wypozyczenia WHERE wypozyczenia.ISBN = ISBN AND 
    wypozyczenia.Czytelnik_id = (SELECT Czytelnik_id FROM biblioteka.czytelnik WHERE czytelnik.email = Email) AND
    wypozyczenia.Status_wypozyczenia_id = 1;
    
	UPDATE biblioteka.wypozyczenia SET Rzeczywista_data_zwrotu = CURRENT_DATE(), Status_wypozyczenia_id = 2 WHERE wypozyczenia.ISBN = ISBN AND 
    wypozyczenia.Czytelnik_id = (SELECT Czytelnik_id FROM biblioteka.czytelnik WHERE czytelnik.email = Email) AND 
    wypozyczenia.Status_wypozyczenia_id = 1;
    
    UPDATE biblioteka.egzemplarz SET Status_id = 2, Wypozyczenie_id = NULL WHERE egzemplarz.Wypozyczenie_id = wyp_id;
    COMMIT;
END $$
DELIMITER ;