CREATE TABLE IF NOT EXISTS biblioteka.Bibliotekarz (
  Bibliotekarz_id INT AUTO_INCREMENT NOT NULL,
  Imie VARCHAR(45) NOT NULL,
  Nazwisko VARCHAR(45) NOT NULL,
  PESEL VARCHAR(45) UNIQUE NOT NULL,
  PRIMARY KEY (Bibliotekarz_id));
  
  CREATE TABLE IF NOT EXISTS biblioteka.Czytelnik (
  Czytelnik_id INT AUTO_INCREMENT NOT NULL,
  Imie VARCHAR(45) NOT NULL,
  Nazwisko VARCHAR(45) NOT NULL,
  Telefon VARCHAR(45) UNIQUE NOT NULL,
  email VARCHAR(45) UNIQUE NOT NULL,
  Data_dodania DATE,
  PRIMARY KEY(Czytelnik_id));
  
  CREATE TABLE IF NOT EXISTS biblioteka.Autorzy (
  Autor_id INT AUTO_INCREMENT NOT NULL,
  Imie VARCHAR(45) NOT NULL,
  Nazwisko VARCHAR(45) NOT NULL,
  PRIMARY KEY (Autor_id));
  
  CREATE TABLE IF NOT EXISTS biblioteka.Status_Wypozyczenia (
  Status_wypozyczenia_id INT AUTO_INCREMENT NOT NULL,
  Status VARCHAR(45) NOT NULL,
  PRIMARY KEY (Status_wypozyczenia_id));
  
  CREATE TABLE IF NOT EXISTS biblioteka.Status (
  Status_id INT AUTO_INCREMENT NOT NULL,
  Status VARCHAR(45) NOT NULL,
  PRIMARY KEY (Status_id));
  
  CREATE TABLE IF NOT EXISTS biblioteka.Wydawnictwo (
  Wydawnictwo_id INT AUTO_INCREMENT NOT NULL,
  Nazwa VARCHAR(45) NOT NULL,
  PRIMARY KEY (Wydawnictwo_id));
  
  CREATE TABLE IF NOT EXISTS biblioteka.Ksiazka (
  ISBN VARCHAR(45) UNIQUE NOT NULL,
  Tytul VARCHAR(45) NOT NULL,
  Wydawnictwo_id INT NOT NULL,
  Data_wydania DATE NOT NULL,
  Liczba_Egzemplarzy INT NOT NULL,
  Maksymalny_czas_wypozyczenia INT NOT NULL,
  PRIMARY KEY (ISBN));
  
  CREATE TABLE IF NOT EXISTS biblioteka.Egzemplarz (
  Egzemplarz_id INT AUTO_INCREMENT NOT NULL,
  ISBN VARCHAR(45) NOT NULL,
  Wypozyczenie_id INT NULL,
  Status_id INT NOT NULL,
  Dodatkowy_opis VARCHAR(45),
  PRIMARY KEY (Egzemplarz_id));
  
  CREATE TABLE IF NOT EXISTS biblioteka.Wypozyczenia (
  Wypozyczenie_id INT AUTO_INCREMENT NOT NULL,
  ISBN VARCHAR(45) NOT NULL,
  Bibliotekarz_id INT NOT NULL,
  Czytelnik_id INT NOT NULL,
  Data_wypozyczenia DATE NOT NULL,
  Wymagana_data_zwrotu DATE NOT NULL,
  Rzeczywista_data_zwrotu DATE NULL,
  Status_wypozyczenia_id INT NOT NULL,
  PRIMARY KEY (Wypozyczenie_id));
  
  CREATE TABLE IF NOT EXISTS biblioteka.Autorzy_Ksiazki (
  Autorzy_ksiazki_id INT AUTO_INCREMENT NOT NULL,
  ISBN VARCHAR(45) NOT NULL,
  Autor_id INT NOT NULL,
  PRIMARY KEY (Autorzy_ksiazki_id));
  
  ALTER TABLE biblioteka.ksiazka ADD CONSTRAINT FK_Wydawnictwo FOREIGN KEY (Wydawnictwo_id) REFERENCES biblioteka.wydawnictwo (Wydawnictwo_id);
  ALTER TABLE biblioteka.egzemplarz ADD CONSTRAINT FK_ISBN_egzemplarz FOREIGN KEY (ISBN) REFERENCES biblioteka.ksiazka (ISBN);
  ALTER TABLE biblioteka.egzemplarz ADD CONSTRAINT FK_Wypozyczenie_id FOREIGN KEY (Wypozyczenie_id) REFERENCES biblioteka.wypozyczenia (Wypozyczenie_id);
  ALTER TABLE biblioteka.egzemplarz ADD CONSTRAINT FK_Status FOREIGN KEY (Status_id) REFERENCES biblioteka.status (Status_id);
  ALTER TABLE biblioteka.wypozyczenia ADD CONSTRAINT FK_ISBN_wypozyczenia FOREIGN KEY (ISBN) REFERENCES biblioteka.ksiazka (ISBN);
  ALTER TABLE biblioteka.wypozyczenia ADD CONSTRAINT FK_Bibliotekarz FOREIGN KEY (Bibliotekarz_id) REFERENCES biblioteka.bibliotekarz (Bibliotekarz_id);
  ALTER TABLE biblioteka.wypozyczenia ADD CONSTRAINT FK_Czytelnik FOREIGN KEY (Czytelnik_id) REFERENCES biblioteka.czytelnik (Czytelnik_id);
  ALTER TABLE biblioteka.wypozyczenia ADD CONSTRAINT FK_Status_wypozyczenia FOREIGN KEY (Status_wypozyczenia_id) REFERENCES biblioteka.status_wypozyczenia (Status_wypozyczenia_id);
  ALTER TABLE biblioteka.autorzy_ksiazki ADD CONSTRAINT FK_ISBN_autorzy_ksiazki FOREIGN KEY (ISBN) REFERENCES biblioteka.ksiazka (ISBN);
  ALTER TABLE biblioteka.autorzy_ksiazki ADD CONSTRAINT FK_Autor_id FOREIGN KEY (Autor_id) REFERENCES biblioteka.autorzy (Autor_id);