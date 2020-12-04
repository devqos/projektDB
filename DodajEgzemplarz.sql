DELIMITER $$
CREATE PROCEDURE biblioteka.DodajEgzemplarz(
	ISBN VARCHAR(45),
    Dodatkowy_opis VARCHAR(45)
)
BEGIN
	DECLARE Nowa_liczba_egzemplarzy INT;
	START TRANSACTION;
	INSERT INTO biblioteka.egzemplarz(ISBN, Status_id, Dodatkowy_opis) 
    VALUE (ISBN, 2, Dodatkowy_opis);
    
    SELECT Liczba_egzemplarzy + 1 INTO Nowa_liczba_egzemplarzy FROM ksiazka WHERE ksiazka.ISBN = ISBN;
    
    UPDATE ksiazka SET Liczba_egzemplarzy = Nowa_liczba_egzemplarzy WHERE ksiazka.ISBN = ISBN;
    COMMIT;
END $$
DELIMITER ;