/* Spis wszystkich książek */

SELECT k.ISBN, k.Tytul AS Tytuł, w.Nazwa AS Wydawnictwo, CONCAT(a.Imie, ' ', a.Nazwisko) AS Autor
FROM ksiazka k 
INNER JOIN wydawnictwo w ON k.Wydawnictwo_id = w.Wydawnictwo_id
INNER JOIN autorzy a ON a.Autor_id = (SELECT Autor_id FROM autorzy_ksiazki WHERE autorzy_ksiazki.ISBN = k.ISBN);

/* Spis czytelników którzy mają wypożyczone książki */

SELECT cz.Imie, cz.Nazwisko, cz.email, k.Tytul AS Tytuł, w.Wymagana_data_zwrotu AS 'Wymagana data zwrotu'
FROM czytelnik cz
INNER JOIN wypozyczenia w ON w.Czytelnik_id = cz.Czytelnik_id
INNER JOIN ksiazka k ON k.ISBN = w.ISBN;

/* Ilość dostępnych egzemplarzy danej książki */

SELECT k.ISBN, k.Tytul AS Tytuł, w.Nazwa AS Wydawnictwo, COUNT(*) AS 'Liczba dostępnych egzemplarzy'
FROM ksiazka k
INNER JOIN wydawnictwo w ON k.Wydawnictwo_id = w.Wydawnictwo_id
INNER JOIN egzemplarz e ON k.ISBN = e.ISBN
WHERE k.ISBN = '9788328352341' AND e.Status_id = 2;

/* Lista książek wypożyczonych przez danego czytelnika */

SELECT cz.Imie, cz.Nazwisko, cz.email, k.Tytul AS Tytuł, w.Wymagana_data_zwrotu AS 'Wymagana data zwrotu'
FROM czytelnik cz
INNER JOIN wypozyczenia w ON w.Czytelnik_id = cz.Czytelnik_id
INNER JOIN ksiazka k ON k.ISBN = w.ISBN
WHERE cz.Czytelnik_id = 15;