DELIMITER $$
CREATE PROCEDURE biblioteka.NowyBibliotekarz(
	Imie VARCHAR(45),
    Nazwisko VARCHAR(45),
    PESEL VARCHAR(45)
)    
BEGIN
	START TRANSACTION;
	INSERT INTO biblioteka.bibliotekarz(Imie, Nazwisko, PESEL) 
    VALUE (Imie, Nazwisko, PESEL);
    COMMIT;
END $$
DELIMITER ;