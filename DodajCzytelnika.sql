DELIMITER $$
CREATE PROCEDURE biblioteka.NowyCzytelnik(
	Imie VARCHAR(45),
    Nazwisko VARCHAR(45),
    Telefon VARCHAR(45),
    email VARCHAR(45)
)    
BEGIN
	START TRANSACTION;
	INSERT INTO biblioteka.czytelnik(Imie, Nazwisko, Telefon, email, Data_dodania) 
    VALUE (Imie, Nazwisko, Telefon, email, CURRENT_DATE());
    COMMIT;
END $$
DELIMITER ;